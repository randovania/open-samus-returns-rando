from construct import Container  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats.lua import Lua
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def create_collision_camera_table(editor: PatcherEditor, configuration: dict) -> None:
    py_dict: dict = configuration["cosmetic_patches"]["camera_names_dict"]

    # Surface
    py_dict["s000_surface"]["collision_camera_017"] = "Transport to Area 8"
    py_dict["s110_surfaceb"]["collision_camera_018"] = "Surface Stash"
    py_dict["s110_surfaceb"]["collision_camera_019"] = "Surface Crumble Block Challenge"
    py_dict["s110_surfaceb"]["collision_camera_021"] = "Landing Site"

    # Area 2
    py_dict["s025_area2b"]["collision_camera020"] = "High Jump Boots Chamber"

    # Area 3
    py_dict["s033_area3b"]["collision_camera_030"] = "Quarry Shaft"

    # Area 4
    py_dict["s050_area5"]["collision_camera_AfterChase_002"] = "Diggernaut Excavation Tunnels"
    py_dict["s050_area5"]["collision_camera_AfterChase_003"] = "Diggernaut Excavation Tunnels"

    file = lua_util.replace_lua_template("cc_to_room_name.lua", {"room_dict": py_dict}, True)
    editor.add_new_asset(
        "system/scripts/cc_to_room_name.lc",
        Lua(Container(lua_text=file), editor.target_game),
        []
    )
