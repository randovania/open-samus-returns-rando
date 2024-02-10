from construct import Container
from mercury_engine_data_structures.formats.lua import Lua
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def create_collision_camera_table(editor: PatcherEditor, configuration: dict):
    py_dict: dict = configuration["cosmetic_patches"]["camera_names_dict"]

    file = lua_util.replace_lua_template("cc_to_room_name.lua", {"room_dict": py_dict}, True)
    print(file)
    editor.add_new_asset(
        "system/scripts/cc_to_room_name.lc",
        Lua(Container(lua_text=file), editor.target_game),
        ["packs/system/system.pkg"]
    )
