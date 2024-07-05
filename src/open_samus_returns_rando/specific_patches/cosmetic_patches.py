from mercury_engine_data_structures.formats.bmtun import Bmtun
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_cosmetics(editor: PatcherEditor, configuration: dict) -> None:
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    tunable_cosmetics(tunables, configuration)
    music_shuffle(editor, configuration)


def tunable_cosmetics(tunables: Bmtun, configuration: dict) -> None:
    aim = tunables.raw["classes"]["CTunableAim"]["tunables"]
    aim["vLaserLockedColor0"]["value"] = configuration["laser_locked_color"]
    aim["vLaserUnlockedColor0"]["value"] = configuration["laser_unlocked_color"]
    aim["vGrappleLaserLockedColor0"]["value"] = configuration["grapple_laser_locked_color"]
    aim["vGrappleLaserUnlockedColor0"]["value"] = configuration["grapple_laser_unlocked_color"]


def lua_cosmetics(configuration: dict) -> str:
    replacement = {
        # Energy Tank Color
        "energy_tank_r": lua_util.wrap_string(configuration["energy_tank_color"][0]),
        "energy_tank_g": lua_util.wrap_string(configuration["energy_tank_color"][1]),
        "energy_tank_b": lua_util.wrap_string(configuration["energy_tank_color"][2]),
        # Aeion Bar Color
        "aeion_bar_r": lua_util.wrap_string(configuration["aeion_bar_color"][0]),
        "aeion_bar_g": lua_util.wrap_string(configuration["aeion_bar_color"][1]),
        "aeion_bar_b": lua_util.wrap_string(configuration["aeion_bar_color"][2]),
        # Ammo HUD Color
        "ammo_hud_r": lua_util.wrap_string(configuration["ammo_hud_color"][0]),
        "ammo_hud_g": lua_util.wrap_string(configuration["ammo_hud_color"][1]),
        "ammo_hud_b": lua_util.wrap_string(configuration["ammo_hud_color"][2]),
    }

    return lua_util.replace_lua_template("cosmetics.lua", replacement)


def music_shuffle(editor: PatcherEditor, configuration: dict) -> None:
    if len(configuration["music_shuffle_dict"]) == 0:
        return

    temp_dict: dict = {}
    for f in list(editor.get_asset_names_in_folder("sounds/streams/music/")):
        temp_dict[f] = editor.get_raw_asset(f)

    for original, new in configuration["music_shuffle_dict"].items():
        original_track = f"sounds/streams/music/{original}.bcwav"
        new_track = temp_dict[f"sounds/streams/music/{new}.bcwav"]
        editor.replace_asset(original_track, new_track)
