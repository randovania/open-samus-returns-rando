from mercury_engine_data_structures.formats.bmtun import Bmtun
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_cosmetics(editor: PatcherEditor, configuration: dict):
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    _tunable_cosmetics(tunables, configuration)
    _lua_cosmetics(configuration)


def _tunable_cosmetics(tunables: Bmtun, configuration: dict):
    aim = tunables.raw["classes"]["CTunableAim"]["tunables"]
    aim["vLaserLockedColor0"]["value"] = configuration["laser_locked_color"]
    aim["vLaserUnlockedColor0"]["value"] = configuration["laser_unlocked_color"]
    aim["vGrappleLaserLockedColor0"]["value"] = configuration["grapple_laser_locked_color"]
    aim["vGrappleLaserUnlockedColor0"]["value"] = configuration["grapple_laser_unlocked_color"]


def _lua_cosmetics(configuration: dict) -> str:
    replacement = {
        "energy_counter_r": lua_util.wrap_string(configuration["energy_counter_color"][0]),
        "energy_counter_g": lua_util.wrap_string(configuration["energy_counter_color"][1]),
        "energy_counter_b": lua_util.wrap_string(configuration["energy_counter_color"][2]),
    }

    return lua_util.replace_lua_template("guicolor.lua", replacement)
