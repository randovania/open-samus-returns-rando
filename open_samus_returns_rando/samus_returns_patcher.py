import json
import logging
import typing
from pathlib import Path

import jsonschema

from mercury_engine_data_structures.file_tree_editor import OutputFormat

from open_samus_returns_rando.patcher_editor import PatcherEditor
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


def patch_pickups(editor: PatcherEditor, pickups: list):
    template_bmsad = _read_template_powerup()

    pkgs_for_lua = set()

    for pickup in pickups:
        actor_reference = pickup["actor"]
        scenario = editor.get_scenario(actor_reference["scenario"])
        actor_name = actor_reference["actor"]

        model_name: str = pickup["type"]
        pickup_type = get_data(model_name)

        found_actor = False
        for actors in scenario.raw.actors:
            if actor_name in actors:
                actor = actors[actor_name]
                actor["type"] = pickup["type"]
                found_actor = True
                break
    
        if not found_actor:
            raise KeyError("Actor named '{}' found in ".format(actor_name, actor_reference["scenario"]))

        # Dependencies
        for level_pkg in editor.get_level_pkgs(actor_reference["scenario"]):
            editor.ensure_present(level_pkg, "system/animtrees/base.bmsat")
            for dep in pickup_type.dependencies:
                editor.ensure_present(level_pkg, dep)

    editor.add_new_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc",
                         _read_powerup_lua(),
                         in_pkgs=pkgs_for_lua)

def patch(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    jsonschema.validate(instance=configuration, schema=_read_schema())

    out_romfs = output_path.joinpath("romfs")
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

    # Patches pikcups
    patch_pickups(editor, configuration["pickups"])

    editor.flush_modified_assets()
    editor.save_modifications(out_romfs, OutputFormat.PKG)

    logging.info("Done")
