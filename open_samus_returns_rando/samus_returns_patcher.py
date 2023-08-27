import json
import logging
import shutil
import typing
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import OutputFormat

from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.misc_patches.exefs import DSPatch
from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.pickup import patch_pickups
from open_samus_returns_rando.validator_with_default import DefaultValidatingDraft7Validator

T = typing.TypeVar("T")
LOG = logging.getLogger("samus_returns_patcher")


def _read_schema():
    with Path(__file__).parent.joinpath("files", "schema.json").open() as f:
        return json.load(f)


def create_custom_init(configuration: dict) -> str:
    inventory: dict[str, int] = configuration["starting_items"]
    starting_location: dict = configuration["starting_location"]

    energy_per_tank = configuration["energy_per_tank"]
    max_life = energy_per_tank - 1

    # max_aeion has to be setup like this,
    # otherwise the starting aeion amount will be 1000 (hardcoded) plus the aeion tank amount
    aeion_per_tank = configuration["aeion_per_tank"]
    max_aeion = 1000 - aeion_per_tank

     # increase starting HP if starting with etanks
    if "ITEM_ENERGY_TANKS" in inventory:
        etanks = inventory.pop("ITEM_ENERGY_TANKS")
        max_life += etanks * energy_per_tank

     # increase starting Aeion if starting with atanks
    if "ITEM_AEION_TANKS" in inventory:
        atanks = inventory.pop("ITEM_AEION_TANKS")
        max_aeion += atanks * aeion_per_tank

    # Game doesn't like to start if some fields are missing, like ITEM_WEAPON_POWER_BOMB_MAX
    final_inventory = {
        "ITEM_MAX_LIFE": max_life,
        "ITEM_MAX_SPECIAL_ENERGY": max_aeion,
        "ITEM_METROID_COUNT": 0,
        "ITEM_METROID_TOTAL_COUNT": 40,
        "ITEM_WEAPON_MISSILE_MAX": 0,
        "ITEM_WEAPON_SUPER_MISSILE_MAX": 0,
        "ITEM_WEAPON_POWER_BOMB_MAX": 0,
    }
    final_inventory.update(inventory)

    replacement = {
        "new_game_inventory": final_inventory,
        "starting_scenario": lua_util.wrap_string(starting_location["scenario"]),
        "starting_actor": lua_util.wrap_string(starting_location["actor"]),
        "energy_per_tank": energy_per_tank,
        "aeion_per_tank": aeion_per_tank,
        "reveal_map_on_start": configuration["reveal_map_on_start"],
    }

    return lua_util.replace_lua_template("custom_init.lua", replacement)


def patch_exefs(exefs_patches: Path):
    exefs_patches.mkdir(parents=True, exist_ok=True)
    patch = DSPatch()
    # file needs to be named code.ips for Citra
    exefs_patches.joinpath("code.ips").write_bytes(bytes(patch))

def patch_spawn_points(editor: PatcherEditor, spawn_config: list[dict]):
    # create custom spawn point
    _EXAMPLE_SP = {"scenario": "s010_area1", "layer": "5", "actor": "StartPoint0"}
    base_actor = editor.resolve_actor_reference(_EXAMPLE_SP)
    for new_spawn in spawn_config:
        scenario_name = new_spawn["new_actor"]["scenario"]
        new_actor_name = new_spawn["new_actor"]["actor"]
        collision_camera_name = new_spawn["collision_camera_name"]
        new_spawn_pos = (new_spawn["location"]["x"], new_spawn["location"]["y"], new_spawn["location"]["z"])
        scenario = editor.get_scenario(scenario_name)
        editor.copy_actor(scenario_name, new_spawn_pos, base_actor, new_actor_name, 5)
        eg_name = f"eg_SubArea_{collision_camera_name}"
        eg_collison_camera = next((sub_area for sub_area in scenario.raw.sub_areas if sub_area.name ==  eg_name), None)
        eg_collison_camera.names.append(new_actor_name)

def patch_extracted(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    DefaultValidatingDraft7Validator(_read_schema()).validate(configuration)

    out_romfs = output_path.joinpath("romfs")
    out_exefs = output_path.joinpath("exefs")
    shutil.rmtree(out_romfs, ignore_errors=True)
    shutil.rmtree(out_exefs, ignore_errors=True)

    editor = PatcherEditor(input_path)
    lua_scripts = LuaEditor()

    # Update init.lc
    lua_util.create_script_copy(editor, "system/scripts/init")
    editor.replace_asset(
        "system/scripts/init.lc",
        create_custom_init(configuration).encode("ascii"),
    )

    # Add custom lua files
    lua_util.replace_script(editor, "system/scripts/scenario", "custom_scenario.lua")
    lua_util.replace_script(editor, "actors/characters/player/scripts/player", "custom_player.lua")

    # Patch all pickups
    patch_pickups(editor, lua_scripts, configuration["pickups"], configuration)

    # custom spawn points
    patch_spawn_points(editor, configuration["new_spawn_points"])

    # Create Exefs patches (currently there are none)
    LOG.info("Creating exefs patches")
    patch_exefs(out_exefs)

    LOG.info("Saving modified lua scripts")
    lua_scripts.save_modifications(editor)

    LOG.info("Flush modified assets")
    editor.flush_modified_assets()

    LOG.info("Saving modified pkgs to %s", out_romfs)
    editor.save_modifications(out_romfs, OutputFormat.PKG)

    LOG.info("Done")
