import re
from pathlib import Path

from mercury_engine_data_structures.file_tree_editor import FileTreeEditor


def _templates() -> Path:
    return Path(__file__).parent.joinpath("templates")


def _files() -> Path:
    return Path(__file__).parent.joinpath("files")


def replace_lua_template(file: str, replacement: dict[str, str]) -> str:
    code = _templates().joinpath(file).read_text()
    for key, content in replacement.items():
        code = code.replace(f'TEMPLATE("{key}")', lua_convert(content))

    unknown_templates = re.findall(r'TEMPLATE\("([^"]+)"\)', code)

    if unknown_templates:
        raise ValueError("The following templates were left unfulfilled: " + str(unknown_templates))

    return code


def lua_convert(data) -> str:
    if isinstance(data, list):
        return "{\n" + "\n".join(
            "{},".format(lua_convert(item))
            for item in data
        ) + "\n}"
    if isinstance(data, dict):
        return "{\n" + "\n".join(
            "{} = {},".format(key, lua_convert(value))
            for key, value in data.items()
        ) + "\n}"
    if isinstance(data, bool):
        return "true" if data else "false"
    return str(data)


def wrap_string(data: str) -> str:
    return f'"{data}"'


def create_script_copy(editor: FileTreeEditor, path: str):
    original = path + "_original.lc"
    if not editor.does_asset_exists(original):
        original_lc = editor.get_raw_asset(path + ".lc")
        editor.add_new_asset(
            original,
            original_lc,
            editor.find_pkgs(path + ".lc")
        )


def replace_script(editor: FileTreeEditor, path: str, replacement_path: str):
    create_script_copy(editor, path)
    editor.replace_asset(path + ".lc", _files().joinpath(replacement_path).read_bytes())


def replace_area_lua(editor: FileTreeEditor):

    ALL_AREAS = [
        "s000_surface",
        "s010_area1",
        "s020_area2",
        "s025_area2b",
        "s028_area2c",
        "s030_area3",
        "s033_area3b",
        "s036_area3c",
        "s040_area4",
        "s050_area5",
        "s060_area6",
        "s065_area6b",
        "s067_area6c",
        "s070_area7",
        "s090_area9",
        "s100_area10",
        "s110_surfaceb",
    ] 
    
    # ALL_PICKUPS = [
    #     "powerup_gravitysuit",
    #     "powerup_variasuit",
    #     "powerup_scanningpulse",
    # ]

    for x in ALL_AREAS:
        replace_script(
            editor,
            f"maps/levels/c10_samus/{x}/{x}",
            f"levels/{x}.lua"
            )
        
    # for x in ALL_PICKUPS:
    #     replace_script(
    #         editor,
    #         f"actors/items/{x}/scripts/{x}",
    #         f"pickups/{x}.lua"
    #         )