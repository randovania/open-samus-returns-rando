import json
import logging
import shutil
import typing
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import OutputFormat

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.custom_pickups import patch_custom_pickups
from open_samus_returns_rando.debug import debug_custom_pickups, debug_spawn_points
from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.misc_patches.credits import patch_credits
from open_samus_returns_rando.misc_patches.exefs import DSPatch
from open_samus_returns_rando.misc_patches.text_patches import patch_pb_status
from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.pickup import patch_pickups
from open_samus_returns_rando.specific_patches import game_patches
from open_samus_returns_rando.specific_patches.door_patches import patch_doors
from open_samus_returns_rando.specific_patches.heat_room_patches import patch_heat_rooms
from open_samus_returns_rando.specific_patches.metroid_patches import patch_metroids
from open_samus_returns_rando.specific_patches.static_fixes import apply_static_fixes
from open_samus_returns_rando.specific_patches.tunable_patches import patch_tunables
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
    max_life = inventory.pop("ITEM_MAX_LIFE")

    max_aeion = inventory.pop("ITEM_MAX_SPECIAL_ENERGY")

    # increase starting HP if starting with etanks
    if "ITEM_ENERGY_TANKS" in inventory:
        etanks = inventory.pop("ITEM_ENERGY_TANKS")
        max_life += etanks * energy_per_tank

    # These fields are required to start the game
    final_inventory = {
        "ITEM_MAX_LIFE": max_life,
        "ITEM_MAX_SPECIAL_ENERGY": max_aeion,
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
        "energy_per_tank": energy_per_tank,
        "reveal_map_on_start": configuration["reveal_map_on_start"],
    }

    return lua_util.replace_lua_template("custom_init.lua", replacement)


def patch_exefs(exefs_patches: Path):
    exefs_patches.mkdir(parents=True, exist_ok=True)
    patch = DSPatch()
    # file needs to be named code.ips for Citra
    exefs_patches.joinpath("code.ips").write_bytes(bytes(patch))


def patch_extracted(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    DefaultValidatingDraft7Validator(_read_schema()).validate(configuration)

    editor = PatcherEditor(input_path)
    lua_scripts = LuaEditor()

    # Apply fixes
    apply_static_fixes(editor)

    # Update init.lc
    lua_util.create_script_copy(editor, "system/scripts/init")
    editor.replace_asset(
        "system/scripts/init.lc",
        create_custom_init(configuration).encode("ascii"),
    )

    # Add custom lua files
    lua_util.replace_script(editor, "system/scripts/scenario", "custom_scenario.lua")
    lua_util.replace_script(editor, "actors/props/samusship/scripts/samusship", "custom_ship.lua")
    lua_util.replace_script(editor, "actors/props/savestation/scripts/savestation", "custom_savestation.lua")

    # Custom pickups
    patch_custom_pickups(editor)
    debug_custom_pickups(editor, configuration["debug_custom_pickups"])

    # Patch all pickups
    patch_pickups(editor, lua_scripts, configuration["pickups"], configuration)

    # Custom spawn points
    debug_spawn_points(editor, configuration["debug_spawn_points"])

    # Fix unheated heat rooms
    patch_heat_rooms(editor)

    # Patch door types and make shields on both sides
    patch_doors(editor)

    # Patch tunables
    patch_tunables(editor)

    # Patch metroids
    patch_metroids(editor)

    # Specific game patches
    game_patches.apply_game_patches(editor, configuration.get("game_patches", {}))

    # Text patches
    patch_credits(editor, configuration["spoiler_log"])
    patch_pb_status(editor)

    # TODO: Remove this integrity check later
    from mercury_engine_data_structures.crc import crc32
    for area in ALL_AREAS:
        scenario = editor.get_scenario(area)
        for sub_area in scenario.raw["sub_areas"]:
            crcs_list = [
                crc32(name)
                for name in sub_area.names
            ]
            sorted_list = sorted(crcs_list)
            if sorted_list != crcs_list:
                print(sub_area)
                print(sub_area.names)
                raise ValueError("oops")

    out_romfs = output_path.joinpath("romfs")
    out_exefs = output_path.joinpath("exefs")
    shutil.rmtree(out_romfs, ignore_errors=True)
    shutil.rmtree(out_exefs, ignore_errors=True)

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
