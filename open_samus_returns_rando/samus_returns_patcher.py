import copy
import json
import logging
import shutil
import typing
from pathlib import Path

import jsonschema

from mercury_engine_data_structures.file_tree_editor import OutputFormat
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.misc_patches.exefs import DSPatch
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level
from open_samus_returns_rando import lua_util
from open_samus_returns_rando.model_data import get_data


T = typing.TypeVar("T")
LOG = logging.getLogger("samus_returns_patcher")


def _read_schema():
    with Path(__file__).parent.joinpath("files", "schema.json").open() as f:
        return json.load(f)


def _read_template_powerup():
    with Path(__file__).parent.joinpath("templates", "template_powerup_bmsad.json").open() as f:
        return json.load(f)


def _read_powerup_lua() -> bytes:
    return Path(__file__).parent.joinpath("files", "randomizer_powerup.lua").read_bytes()


def create_custom_init(inventory: dict[str, int], starting_location: dict):
    def _wrap(v: str):
        return f'"{v}"'

    # Game doesn't like to start if some fields are missing, like ITEM_WEAPON_POWER_BOMB_MAX
    final_inventory = {
        "ITEM_MAX_LIFE": 99,
        "ITEM_MAX_SPECIAL_ENERGY": 1000,
        "ITEM_METROID_COUNT": 0,
        "ITEM_METROID_TOTAL_COUNT": 40,
        "ITEM_WEAPON_MISSILE_MAX": 0,
        "ITEM_WEAPON_SUPER_MISSILE_MAX": 0,
        "ITEM_WEAPON_POWER_BOMB_MAX": 0,
    }
    final_inventory.update(inventory)

    replacement = {
        "new_game_inventory": "\n".join(
            "{} = {},".format(key, value)
            for key, value in final_inventory.items()
        ),
        "starting_scenario": _wrap(starting_location["scenario"]),
        "starting_actor": _wrap(starting_location["actor"]),
    }


    return lua_util.replace_lua_template("custom_init.lua", replacement)

def patch_pickups(editor: PatcherEditor, pickups_config: list[dict]):
    template_bmsad = editor.get_parsed_asset("actors/items/powerup_chargebeam/charclasses/powerup_chargebeam.bmsad").raw

    pkgs_for_lua = set()

    for i, pickup in enumerate(pickups_config):
        LOG.info("Writing pickup %d: %s", i, pickup["item_id"])
        pkgs_for_level = set(editor.find_pkgs(path_for_level(pickup["pickup_actor"]["scenario"]) + ".bmsld"))
        pkgs_for_lua.update(pkgs_for_level)

        actor_reference = pickup["pickup_actor"]
        scenario = editor.get_scenario(actor_reference["scenario"])
        actor_name = actor_reference["actor"]

        found_actor = False
        for actors in scenario.raw.actors:
            if actor_name in actors:
                actor = actors[actor_name]
                actor["model"] = pickup["model"]
                found_actor = True
                break
    
        if not found_actor:
            raise KeyError("Actor named '{}' found in ".format(actor_name, actor_reference["scenario"]))      

        model_name: str = pickup["model"]
        model_data = get_data(model_name)

        new_template = copy.deepcopy(template_bmsad)
        new_template["name"] = f"randomizer_powerup_{i}"

        # Update used model
        new_template["model_name"] = model_data.bcmdl_path
        MODELUPDATER = new_template["components"]["MODELUPDATER"]
        MODELUPDATER["functions"][0]["params"]["Param1"]["value"] = model_data.bcmdl_path

        # Update caption
        PICKABLE = new_template["components"]["PICKABLE"]

        # Update given item
        set_custom_params: dict = PICKABLE["functions"][0]["params"]
        item_id: str = pickup["item_id"]
        quantity: float = pickup["quantity"]

        if item_id == "ITEM_ENERGY_TANKS":
            item_id = "fMaxLife"
            quantity *= 100.0
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fCurrentLife"
            set_custom_params["Param6"]["value"] = "LIFE"

        elif item_id == "ITEM_SENERGY_TANKS":
            item_id = "fMaxEnergy"
            quantity *= 50.0
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fEnergy"
            set_custom_params["Param6"]["value"] = "SPECIALENERGY"

        set_custom_params["Param1"]["value"] = item_id
        set_custom_params["Param2"]["value"] = quantity

        actordef_id = new_template["name"]
        new_path = f"actors/items/{actordef_id}/charclasses/{actordef_id}.bmsad"
        editor.add_new_asset(new_path, Bmsad(new_template, editor.target_game), in_pkgs=pkgs_for_level)
        actor.type = actordef_id

        # Powerup is in plain sight (except for the part we're using the sphere model)
        # actor.components.pop("LIFE", None)

        # Dependencies
        for level_pkg in pkgs_for_level:
            editor.ensure_present(level_pkg, "system/animtrees/base.bmsat")
            for dep in model_data.dependencies:
                editor.ensure_present(level_pkg, dep)

        # For debugging, write the bmsad we just created
        # Path("custom_bmsad", f"randomizer_powerup_{i}.bmsad.json").write_text(
        #     json.dumps(new_template, indent=4)
        # )

    editor.add_new_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc",
                         _read_powerup_lua(),
                         in_pkgs=pkgs_for_lua)

def patch_exefs(exefs_patches: Path, configuration: dict):
    exefs_patches.mkdir(parents=True, exist_ok=True)
    patch = DSPatch()
    # file needs to be named code.ips for Citra
    exefs_patches.joinpath("code.ips").write_bytes(bytes(patch))

def patch(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    jsonschema.validate(instance=configuration, schema=_read_schema())

    out_romfs = output_path.joinpath("romfs")
    out_exefs= output_path.joinpath("exefs")
    shutil.rmtree(out_romfs, ignore_errors=True)
    shutil.rmtree(out_exefs, ignore_errors=True)
    editor = PatcherEditor(input_path)

    # Update init.lc
    lua_util.create_script_copy(editor, "system/scripts/init")
    editor.replace_asset(
        "system/scripts/init.lc",
        create_custom_init(
            configuration["starting_items"],
            configuration["starting_location"]
        ).encode("ascii"),
    )

    lua_util.replace_script(editor, "system/scripts/scenario", "custom_scenario.lua")
    lua_util.replace_script(editor, "actors/characters/player/scripts/player", "custom_player.lua")

    # Replaces the original area lua files with modified ones
    lua_util.replace_area_lua(editor)

    # Pickups
    patch_pickups(editor, configuration["pickups"])

    # Exefs
    LOG.info("Creating exefs patches")
    patch_exefs(out_exefs, configuration)

    editor.flush_modified_assets()

    # shutil.rmtree(out_romfs)
    editor.save_modifications(out_romfs, OutputFormat.PKG)

    logging.info("Done")