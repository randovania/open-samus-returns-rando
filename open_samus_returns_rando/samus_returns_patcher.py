import json
import logging
import shutil
import typing
from pathlib import Path

from construct import Container
from mercury_engine_data_structures.file_tree_editor import OutputFormat
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.misc_patches.exefs import DSPatch
from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.pickup import patch_pickups
from open_samus_returns_rando.specific_patches import game_patches
from open_samus_returns_rando.specific_patches.heat_room_patches import patch_heat_rooms
from open_samus_returns_rando.specific_patches.static_fixes import apply_static_fixes
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

    aeion_per_tank = configuration["aeion_per_tank"]
    max_aeion = inventory.pop("ITEM_MAX_SPECIAL_ENERGY")

     # increase starting HP if starting with etanks
    if "ITEM_ENERGY_TANKS" in inventory:
        etanks = inventory.pop("ITEM_ENERGY_TANKS")
        max_life += etanks * energy_per_tank

     # increase starting Aeion if starting with atanks
    if "ITEM_AEION_TANKS" in inventory:
        atanks = inventory.pop("ITEM_AEION_TANKS")
        max_aeion += atanks * aeion_per_tank

    inventory_update = {
        "ITEM_MAX_LIFE": max_life,
        "ITEM_MAX_SPECIAL_ENERGY": max_aeion,
    }
    inventory.update(inventory_update)

    replacement = {
        "new_game_inventory": inventory,
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

def unpack_new_actor(new_actor: dict):
    scenario_name = new_actor["new_actor"]["scenario"]
    new_actor_name = new_actor["new_actor"]["actor"]
    collision_camera_name = new_actor["collision_camera_name"]
    new_pos = (new_actor["location"]["x"], new_actor["location"]["y"], new_actor["location"]["z"])
    return scenario_name,new_actor_name,collision_camera_name,new_pos

def patch_spawn_points(editor: PatcherEditor, spawn_config: list[dict]):
    # create custom spawn point
    _EXAMPLE_SP = {"scenario": "s010_area1", "layer": "5", "actor": "StartPoint0"}
    base_actor = editor.resolve_actor_reference(_EXAMPLE_SP)
    for new_spawn in spawn_config:
        scenario_name, new_actor_name, collision_camera_name, new_spawn_pos = unpack_new_actor(new_spawn)
        scenario = editor.get_scenario(scenario_name)
        editor.copy_actor(scenario_name, new_spawn_pos, base_actor, new_actor_name, 5)
        scenario.add_actor_to_entity_groups(collision_camera_name, new_actor_name)

def patch_custom_pickups(editor: PatcherEditor, pickup_config: list[dict]):
    # create custom pickup
    _EXAMPLE_PICKUP = {"scenario": "s000_surface", "layer": "9", "actor": "LE_PowerUP_Morphball"}
    base_actor = editor.resolve_actor_reference(_EXAMPLE_PICKUP)
    for new_pickup in pickup_config:
        scenario_name, new_actor_name, collision_camera_name, new_pos = unpack_new_actor(new_pickup)
        scenario = editor.get_scenario(scenario_name)
        editor.copy_actor(scenario_name, new_pos, base_actor, new_actor_name, 9)
        scenario.add_actor_to_entity_groups(collision_camera_name, new_actor_name)

def patch_shields(editor: PatcherEditor):
    # TODO: Move this function clean up this mess
    # TODO: Write down all door / shields...lol
    # TODO: Make unk06 a float in MEDS branch (cause I'm assign float values here)
    # create custom pickup
    _EXAMPLE_LEFT_SIDE = {"scenario": "s000_surface", "layer": "9", "actor": "LE_MissileShield_Door_002"}
    _EXAMPLE_RIGHT_SIDE = {"scenario": "s010_area1", "layer": "9", "actor": "LE_DoorShieldMissile"}
    _EXAMPLE_SPAZER = {"scenario": "s050_area5", "layer": "9", "actor": "LE_SpazerShield_Door008"}

    scenario = editor.get_scenario("s050_area5")
    scenario.remove_actor_from_all_groups("LE_SpazerShield_Door008")


    left_actor = editor.resolve_actor_reference(_EXAMPLE_LEFT_SIDE)
    left_actor["unk06"] = 90
    right_actor = editor.resolve_actor_reference(_EXAMPLE_RIGHT_SIDE)
    right_actor["unk06"] = 90

    # messy spazer stuff (basically adds a call to RandomizerPowerup.GenerateADN when the door creature dies)
    spazer_bmsad = editor.get_parsed_asset("actors/props/doorspazerbeam/charclasses/doorspazerbeam.bmsad", type_hint=Bmsad) # noqa
    alpha_bmsad = editor.get_parsed_asset("actors/characters/alphanewborn/charclasses/alphanewborn.bmsad", type_hint=Bmsad) # noqa
    spazer_bmsad.raw["components"]["SCRIPT"] = alpha_bmsad.raw["components"]["SCRIPT"]
    spazer_bmsad.raw["components"]["SCRIPT"]["functions"][0]["params"]["Param1"]["value"] = "actors/items/randomizer_powerup/scripts/randomizer_powerup.lua" # noqa
    spazer_bmsad.raw["components"]["SCRIPT"]["functions"][0]["params"]["Param2"]["value"] = "RandomizerPowerup"
    unknown_mess = Container({"unk1": 22, "unk2": 1, "unk3": 0, "args": Container({601445949: Container({"type": "s", "value": "GenerateADN"})})}) # noqa
    spazer_bmsad.action_sets[0].raw["animations"][0].event_counts[0] = spazer_bmsad.action_sets[0].raw["animations"][0].event_counts[0] + 1 # noqa
    spazer_bmsad.action_sets[0].raw["animations"][0]["events0"].append(unknown_mess)
    editor.replace_asset("actors/props/doorspazerbeam/charclasses/doorspazerbeam.bmsad", spazer_bmsad)

    spazer_actor = editor.resolve_actor_reference(_EXAMPLE_SPAZER)
    new_spazer_actor = editor.copy_actor(_EXAMPLE_SPAZER["scenario"], (spazer_actor["x"],  spazer_actor["y"],  spazer_actor["z"]), spazer_actor, "LE_SpazerShield_Door008_a", 9) # noqa
    new_spazer_actor["unk05"] = 0
    new_spazer_actor["unk06"] = 0
    new_spazer_actor["unk07"] = 0


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
    patch_custom_pickups(editor, configuration["custom_pickups"])

    # Patch all pickups
    patch_pickups(editor, lua_scripts, configuration["pickups"], configuration)

    # Custom spawn points
    patch_spawn_points(editor, configuration["new_spawn_points"])

    # Fix unheated heat rooms
    patch_heat_rooms(editor)

    patch_shields(editor)

    # Specific game patches
    game_patches.apply_game_patches(editor, configuration.get("game_patches", {}))

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
