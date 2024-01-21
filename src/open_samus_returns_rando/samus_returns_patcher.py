import json
import shutil
import typing
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import OutputFormat

from open_samus_returns_rando.debug import debug_custom_pickups, debug_spawn_points
from open_samus_returns_rando.logger import LOG
from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.misc_patches.credits import patch_credits
from open_samus_returns_rando.misc_patches.exefs import DSPatch
from open_samus_returns_rando.misc_patches.spawn_points import patch_custom_spawn_points
from open_samus_returns_rando.misc_patches.text_patches import add_spiderboost_status, apply_text_patches
from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.pickups.custom_pickups import patch_custom_pickups
from open_samus_returns_rando.pickups.pickup import patch_pickups
from open_samus_returns_rando.specific_patches import cosmetic_patches, game_patches, tunable_patches
from open_samus_returns_rando.specific_patches.chozo_seal_patches import patch_chozo_seals
from open_samus_returns_rando.specific_patches.door_patches import patch_doors
from open_samus_returns_rando.specific_patches.heat_room_patches import patch_heat_rooms
from open_samus_returns_rando.specific_patches.hint_patches import patch_hints
from open_samus_returns_rando.specific_patches.map_icons import patch_tiles
from open_samus_returns_rando.specific_patches.metroid_patches import patch_metroids
from open_samus_returns_rando.specific_patches.static_fixes import apply_static_fixes
from open_samus_returns_rando.validator_with_default import DefaultValidatingDraft7Validator

T = typing.TypeVar("T")

def _read_schema():
    with Path(__file__).parent.joinpath("files", "schema.json").open() as f:
        return json.load(f)


def patch_exefs(exefs_patches: Path):
    exefs_patches.mkdir(parents=True, exist_ok=True)
    patch = DSPatch()
    # file needs to be named code.ips for Citra
    exefs_patches.joinpath("code.ips").write_bytes(bytes(patch))

def validate(configuration: dict):
    DefaultValidatingDraft7Validator(_read_schema()).validate(configuration)

def patch_extracted(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files from %s", input_path)

    validate(configuration)

    editor = PatcherEditor(input_path)
    lua_scripts = LuaEditor()

    # Apply fixes
    apply_static_fixes(editor)

    # Update Map Icons
    patch_tiles(editor)

    # Custom pickups
    patch_custom_pickups(editor)
    debug_custom_pickups(editor, configuration["debug_custom_pickups"])

    # Patch all pickups
    patch_pickups(editor, lua_scripts, configuration["pickups"], configuration)

    # Custom spawn points
    patch_custom_spawn_points(editor)
    debug_spawn_points(editor, configuration["debug_spawn_points"])

    # Fix unheated heat rooms
    patch_heat_rooms(editor)

    # Patch door types and make shields on both sides
    patch_doors(editor)

    # Patch tunables
    tunable_patches.patch_tunables(editor, configuration.get("reserves_per_tank", {}))

    # Patch cosmetics
    cosmetic_patches.patch_cosmetics(editor, configuration.get("cosmetics", {}))

    # Patch metroids
    patch_metroids(editor)

    # Patch Chozo Seals
    patch_chozo_seals(editor)
    patch_hints(lua_scripts, configuration["hints"])

    # Specific game patches
    game_patches.apply_game_patches(editor, configuration.get("game_patches", {}))

    # Text patches
    if "text_patches" in configuration:
        apply_text_patches(editor, configuration["text_patches"])
    patch_credits(editor, configuration["spoiler_log"])
    add_spiderboost_status(editor)

    out_romfs = output_path.joinpath("romfs")
    out_exefs = output_path.joinpath("exefs")
    shutil.rmtree(out_romfs, ignore_errors=True)
    shutil.rmtree(out_exefs, ignore_errors=True)

    # Create Exefs patches (currently there are none)
    LOG.info("Creating exefs patches")
    patch_exefs(out_exefs)

    LOG.info("Saving modified lua scripts")
    lua_scripts.save_modifications(editor, configuration)

    LOG.info("Flush modified assets")
    editor.flush_modified_assets()

    LOG.info("Saving modified pkgs to %s", out_romfs)
    editor.save_modifications(out_romfs, OutputFormat.PKG)

    LOG.info("Done")
