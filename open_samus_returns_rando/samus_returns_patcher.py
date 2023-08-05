import json
import logging
import typing
from pathlib import Path

import jsonschema
from mercury_engine_data_structures.file_tree_editor import OutputFormat
from open_samus_returns_rando.logger import LOG
from open_samus_returns_rando import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor

from open_samus_returns_rando.model_data import get_data

T = typing.TypeVar("T")


def _read_schema():
    with Path(__file__).parent.joinpath("files", "schema.json").open() as f:
        return json.load(f)


def create_custom_init(editor: PatcherEditor, configuration: dict) -> str:
    inventory: dict[str, int] = configuration["starting_items"]
    starting_location: dict = configuration["starting_location"]

    energy_per_tank = configuration["energy_per_tank"],

    max_life = energy_per_tank - 1

    # increase starting HP if starting with etanks
    if "ITEM_ENERGY_TANKS" in inventory:
        etanks = inventory.pop("ITEM_ENERGY_TANKS")
        max_life += etanks * energy_per_tank

    # Game doesn't like to start if some fields are missing, like ITEM_WEAPON_POWER_BOMB_MAX
    final_inventory = {
        "ITEM_MAX_LIFE": max_life,
        "ITEM_CURRENT_SPECIAL_ENERGY": 1000,
        "ITEM_MAX_SPECIAL_ENERGY": 1000,
        "ITEM_METROID_COUNT": 0,
        "ITEM_METROID_TOTAL_COUNT": 40,
        "ITEM_WEAPON_MISSILE_MAX": 0,
        "ITEM_WEAPON_POWER_BOMB_MAX": 0,
    }
    final_inventory.update(inventory)

    replacement = {
        "new_game_inventory": final_inventory,
        "starting_scenario": lua_util.wrap_string(starting_location["scenario"]),
        "starting_actor": lua_util.wrap_string(starting_location["actor"]),
        "energy_per_tank": energy_per_tank
    }

    return lua_util.replace_lua_template("custom_init.lua", replacement)


def patch_extracted(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    editor = PatcherEditor(input_path)

ALL_PICKUPS = [
    "powerup_variasuit",
    "powerup_gravitysuit",
    "powerup_scanningpulse",
    "powerup_energyshield",
    "powerup_energywave",
    "powerup_phasedisplacement",
]

ALL_AREAS = [
    "s000_surface",
    "s010_area1",
    "s020_area2",
    "s025_area2b",
    "s028_area2c",
    "s030_area3",
    "s033_area3b",
    "s036_area3c",
    "s040_area4",
    "s050_area5",
    "s060_area6",
    "s065_area6b",
    "s067_area6c",
    "s070_area7",
    "s090_area9",
    "s100_area10",
    "s110_surfaceb",
] 

def patch_pickups(editor: PatcherEditor, pickups: list):
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

def patch(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    jsonschema.validate(instance=configuration, schema=_read_schema())

    out_romfs = output_path.joinpath("romfs")
    editor = PatcherEditor(input_path)

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
    
    for x in ALL_PICKUPS:
        lua_util.replace_script(
            editor,
            f"actors/items/{x}/scripts/{x}",
            f"pickups/{x}.lua"
            )

    for x in ALL_AREAS:
        lua_util.replace_script(
            editor,
            f"maps/levels/c10_samus/{x}/{x}",
            f"levels/{x}.lua"
            )

    patch_pickups(editor, configuration["pickups"])

    LOG.info("Flush modified assets")
    editor.flush_modified_assets()

    LOG.info("Saving modified pkgs to %s", out_romfs)
    editor.save_modifications(out_romfs, OutputFormat.PKG)
    
    logging.info("Done")