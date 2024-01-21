from mercury_engine_data_structures.formats.bmtun import Bmtun
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_cosmetics(editor: PatcherEditor, configuration: dict):
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)

    aim = tunables.raw["classes"]["CTunableAim"]["tunables"]
    aim["vLaserLockedColor0"]["value"] = configuration["laser_locked_color"]
    aim["vLaserUnlockedColor0"]["value"] = configuration["laser_unlocked_color"]
    aim["vGrappleLaserLockedColor0"]["value"] = configuration["grapple_laser_locked_color"]
    aim["vGrappleLaserUnlockedColor0"]["value"] = configuration["grapple_laser_unlocked_color"]
