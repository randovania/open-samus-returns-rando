import json
import shutil
import typing
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import OutputFormat

import open_samus_returns_rando.pickup
from open_samus_returns_rando import lua_util
from open_samus_returns_rando.logger import LOG
from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.patcher_editor import path_for_level, PatcherEditor
from open_samus_returns_rando.pickup import _read_powerup_lua, _powerup_script, _custom_level_scripts
from open_samus_returns_rando.text_patches import apply_text_patches
from open_samus_returns_rando.validator_with_default import DefaultValidatingDraft7Validator


T = typing.TypeVar("T")


def _read_schema():
    with Path(__file__).parent.joinpath("files", "schema.json").open() as f:
        return json.load(f)


def create_custom_init(editor: PatcherEditor, configuration: dict) -> str:
    inventory: dict[str, int] = configuration["starting_items"]
    starting_location: dict = configuration["starting_location"]

    # Game doesn't like to start if some fields are missing, like ITEM_WEAPON_POWER_BOMB_MAX
    final_inventory = {
        "ITEM_MAX_LIFE": 99,
        "ITEM_CURRENT_SPECIAL_ENERGY": 1000,
        "ITEM_WEAPON_ICE_BEAM": 0,
        "ITEM_MAX_SPECIAL_ENERGY": 1000,
        "ITEM_WEAPON_MISSILE_MAX": 0,
        "ITEM_WEAPON_SUPER_MISSILE_MAX": 0,
        "ITEM_WEAPON_POWER_BOMB_MAX": 0,
        "ITEM_METROID_COUNT": 0,
        "ITEM_METROID_TOTAL_COUNT": 40,
    }
    final_inventory.update(inventory)

    replacement = {
        "new_game_inventory": final_inventory,
        "starting_scenario": lua_util.wrap_string(starting_location["scenario"]),
        "starting_actor": lua_util.wrap_string(starting_location["actor"]),
    }

    return lua_util.replace_lua_template("custom_init.lua", replacement)


def powerup_lua():
    return _powerup_script or _read_powerup_lua()


def patch_pickups(editor: PatcherEditor, pickups_config: list[dict]):
    # add to the TOC
    editor.add_new_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc", b'', [])

    for i, pickup in enumerate(pickups_config):
        LOG.info("Writing pickup %d: %s", i, pickup["item_id"])

    # replace with the generated script
    editor.replace_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc", powerup_lua())
    for scenario, script in _custom_level_scripts.items():
        editor.replace_asset(path_for_level(scenario) + ".lc", script.encode("utf-8"))

def validate(configuration: dict):
    DefaultValidatingDraft7Validator(_read_schema()).validate(configuration)

def patch_extracted(input_path: Path, output_path: Path, configuration: dict):
    open_samus_returns_rando.pickup._outpath = output_path
    LOG.info("Will patch files from %s", input_path)

    validate(configuration)

    out_romfs = output_path.joinpath("romfs")
    editor = PatcherEditor(input_path)
    lua_scripts = LuaEditor()

    # Update init.lc
    lua_util.create_script_copy(editor, "system/scripts/init")
    editor.replace_asset(
        "system/scripts/init.lc",
        create_custom_init(editor, configuration).encode("ascii"),
    )

    # Update scenario.lc
    lua_util.replace_script(editor, "system/scripts/scenario", "custom_scenario.lua")

    # Update player.lc
    lua_util.replace_script(editor, "actors/characters/player/scripts/player", "custom_player.lua")

    # Pickups
    patch_pickups(editor, configuration["pickups"])

    # Text patches
    if "text_patches" in configuration:
        apply_text_patches(editor, configuration["text_patches"])

    LOG.info("Saving modified lua scripts")
    lua_scripts.save_modifications(editor)

    LOG.info("Flush modified assets")
    editor.flush_modified_assets()

    LOG.info("Saving modified pkgs to %s", out_romfs)
    shutil.rmtree(out_romfs, ignore_errors=True)
    editor.save_modifications(out_romfs, OutputFormat.PKG)
    
    LOG.info("Done")