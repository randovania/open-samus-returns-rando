from open_samus_returns_rando.lua_editor import LuaEditor


def patch_hints(lua_scripts: LuaEditor, hints: list) -> None:
    for hint in hints:
        if "baby_metroid_hint" in hint:
            continue
        lua_scripts.add_hint(hint)
