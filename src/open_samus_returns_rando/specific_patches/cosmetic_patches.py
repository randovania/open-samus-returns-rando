from mercury_engine_data_structures.formats import Bmdefs, Bmses, Bmtun

from open_samus_returns_rando.constants import ALL_SCENARIOS
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_cosmetics(editor: PatcherEditor, configuration: dict) -> None:
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    tunable_cosmetics(tunables, configuration)
    music_shuffle(editor, configuration)
    volume_patches(editor, configuration)


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

    bmdefs = editor.get_file("system/snd/scenariomusicdefs.bmdefs", Bmdefs)
    sounds = bmdefs.raw["sounds"]

    # Create a dictionary of all sounds using the volumes as the values
    sound_dict: dict = {}
    for sound in sounds:
        sound_name = sound["file_path"][14:].split(".")[0]
        sound_dict[sound_name] = sound["volume"]

    # Assign the new sounds with their respective volumes
    for original, new in configuration["music_shuffle_dict"].items():
        for sound in sounds:
            # Only change the sound if it matches to prevent changing it back when iterating
            if original in sound["file_path"] and sound["sound_name"] in original:
                sound["file_path"] = f"streams/music/{new}.wav"
                sound["volume"] = sound_dict.get(new)
                break


def volume_patches(editor: PatcherEditor, configuration: dict) -> None:
    music = configuration["volume_adjustments"]["music"]
    environment_sfx = configuration["volume_adjustments"]["environment_sfx"]

    # Music Adjustments
    if music != 1:
        sound_defs = editor.get_file("system/snd/scenariomusicdefs.bmdefs", Bmdefs)
        sounds = sound_defs.raw["sounds"]
        for sound in sounds:
            # Apply the music values to each track's music volume
            sound["volume"] *= music

        enemies_list = sound_defs.raw["enemies_list"]
        for enemy in enemies_list:
            for area in enemy["areas"]:
                for layer in area["layers"]:
                    for state in layer["states"]:
                        state["properties"]["volume"] *= music

    # Environment Sound Adjustments
    if environment_sfx != 1:
        for scenario in ALL_SCENARIOS:
            scenario_file = editor.get_file(f"maps/levels/c10_samus/{scenario}/{scenario}.bmses", Bmses)
            env_sounds = scenario_file.raw["sounds"]
            for env_sound in env_sounds:
                # Apply the enviroment_sfx values to each track's enviroment_sfx volume
                env_sound["properties"]["volume"] *= environment_sfx
