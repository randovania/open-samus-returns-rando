import json
import shutil
import typing
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import OutputFormat

from open_samus_returns_rando.debug import debug_custom_pickups, debug_spawn_points
from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.logger import LOG
from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.misc_patches.actor_attributes import patch_actor_attributes
from open_samus_returns_rando.misc_patches.block_patches import patch_block_types
from open_samus_returns_rando.misc_patches.collision_camera_table import create_collision_camera_table
from open_samus_returns_rando.misc_patches.credits import patch_credits
from open_samus_returns_rando.misc_patches.elevators import patch_elevators
from open_samus_returns_rando.misc_patches.final_boss import patch_final_boss
from open_samus_returns_rando.misc_patches.spawn_points import patch_custom_spawn_points
from open_samus_returns_rando.misc_patches.text_patches import add_spiderboost_status, apply_text_patches
from open_samus_returns_rando.multiworld_integration import create_exefs_patches
from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.pickups.custom_pickups import patch_custom_pickups
from open_samus_returns_rando.pickups.pickup import patch_pickups
from open_samus_returns_rando.romfs.rom3ds import Rom3DS, parse_rom_file
from open_samus_returns_rando.specific_patches.chozo_seal_patches import patch_chozo_seals
from open_samus_returns_rando.specific_patches.cosmetic_patches import patch_cosmetics
from open_samus_returns_rando.specific_patches.door_patches import patch_doors
from open_samus_returns_rando.specific_patches.environmental_damage import apply_constant_damage
from open_samus_returns_rando.specific_patches.game_patches import apply_game_patches
from open_samus_returns_rando.specific_patches.heat_room_patches import patch_heat_rooms
from open_samus_returns_rando.specific_patches.hint_patches import patch_hints
from open_samus_returns_rando.specific_patches.metroid_patches import patch_metroids
from open_samus_returns_rando.specific_patches.static_fixes import apply_static_fixes
from open_samus_returns_rando.specific_patches.tunable_patches import patch_tunables
from open_samus_returns_rando.validator_with_default import DefaultValidatingDraft7Validator

T = typing.TypeVar("T")

def _read_schema() -> dict:
    with Path(__file__).parent.joinpath("files", "schema.json").open() as f:
        return json.load(f)

def add_custom_files(editor: PatcherEditor) -> None:
    custom_romfs = files_path().joinpath("romfs")
    for child in custom_romfs.rglob("*"):
        if not child.is_file():
            continue
        relative = child.relative_to(custom_romfs).as_posix()
        LOG.info("Adding custom asset %s", relative)
        asset_name = str(relative)
        raw_bytes = child.read_bytes()
        try:
            editor.add_new_asset(asset_name, raw_bytes, [])
        except ValueError:
            editor.replace_asset(asset_name, raw_bytes)



def validate(configuration: dict) -> None:
    # validate patcher json with the schema.json
    DefaultValidatingDraft7Validator(_read_schema()).validate(configuration)

def cleanup_old_patcher(output_path: Path) -> None:
    out_exefs = output_path.joinpath("exefs")
    shutil.rmtree(out_exefs, ignore_errors=True)

    out_romfs = output_path.joinpath("romfs")
    shutil.rmtree(out_romfs, ignore_errors=True)

    out_code = output_path.joinpath("code.bps")
    out_code.unlink(missing_ok=True)

    out_exheader = output_path.joinpath("exheader.bin")
    out_exheader.unlink(missing_ok=True)


def patch_extracted(input_path: Path, output_path: Path, configuration: dict) -> None:
    LOG.info("Will patch files from %s", input_path)
    file_stream = input_path.open("rb")
    parsed_rom = Rom3DS(parse_rom_file(input_path, file_stream), file_stream)

    validate(configuration)

    editor = PatcherEditor(input_path, parsed_rom)
    lua_scripts = LuaEditor()

    # Add all custom files from RomFS
    add_custom_files(editor)

    # Apply fixes
    apply_static_fixes(editor)

    # Custom pickups
    patch_custom_pickups(editor, configuration)
    debug_custom_pickups(editor, configuration["debug_custom_pickups"])

    # Patch all pickups
    patch_pickups(editor, lua_scripts, configuration["pickups"], configuration)

    # Custom spawn points
    patch_custom_spawn_points(editor)
    debug_spawn_points(editor, configuration["debug_spawn_points"])

    # Custom final boss
    patch_final_boss(editor, configuration)

    # Fix unheated heat rooms
    patch_heat_rooms(editor)

    # Environmental Damage
    apply_constant_damage(editor, configuration["constant_environment_damage"])

    # Patch door types and make shields on both sides
    patch_doors(editor, configuration["door_patches"], configuration["custom_doors"])

    # Patch tunables
    patch_tunables(editor, configuration)

    # Patch cosmetics
    patch_cosmetics(editor, configuration.get("cosmetic_patches", {}))

    # Patch metroids
    patch_metroids(editor)

    # Patch Chozo Seals
    patch_chozo_seals(editor)
    patch_hints(lua_scripts, configuration["hints"])

    # Specific game patches
    apply_game_patches(editor, configuration.get("game_patches", {}))

    # Text patches
    if "text_patches" in configuration:
        apply_text_patches(editor, configuration["text_patches"])
    patch_credits(editor, configuration["spoiler_log"])
    add_spiderboost_status(editor)

     # Update cc_to_room_name.lua
    create_collision_camera_table(editor, configuration)

    # Patch elevator destinations
    patch_elevators(editor, configuration)

    # Patch blocks to another type
    patch_block_types(editor, configuration)

    # Patch actor attributes
    patch_actor_attributes(editor, configuration["actor_attributes"])

    cleanup_old_patcher(output_path)

    out_romfs = output_path.joinpath("romfs")
    out_code = output_path.joinpath("code.bin")
    out_exheader = output_path.joinpath("exheader.bin")

    # Create Exefs patches for multiworld
    LOG.info("Creating exefs patches")
    create_exefs_patches(
        out_code, out_exheader,
        parsed_rom.get_code_binary(),
        parsed_rom.exheader(),
        configuration["enable_remote_lua"]
    )

    LOG.info("Saving modified lua scripts")
    lua_scripts.save_modifications(editor, configuration)

    LOG.info("Flush modified assets")
    editor.flush_modified_assets()

    LOG.info("Saving modified pkgs to %s", out_romfs)
    editor.save_modifications(out_romfs, OutputFormat.ROMFS)

    LOG.info("Done")
