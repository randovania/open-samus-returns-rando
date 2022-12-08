import json
import logging
import typing
from pathlib import Path

import jsonschema
from mercury_engine_data_structures.file_tree_editor import FileTreeEditor, OutputFormat
from mercury_engine_data_structures.formats import Bmsld, BaseResource
from mercury_engine_data_structures.game_check import Game
from open_samus_returns_rando import lua_util
# from mercury_engine_data_structures.formats.samus_returns_types import EBreakableTileType

T = typing.TypeVar("T")
LOG = logging.getLogger("samus_returns_patcher")
game = Game.SAMUS_RETURNS

def _read_schema():
    with Path(__file__).parent.joinpath("schema.json").open() as f:
        return json.load(f)


def path_for_level(level_name: str) -> str:
    return f"maps/levels/c10_samus/{level_name}/{level_name}"


def create_init_copy(editor: FileTreeEditor):
    original_init = "system/scripts/original_init.lc"
    if not editor.does_asset_exists(original_init):
        original_lc = editor.get_raw_asset("system/scripts/init.lc")
        editor.add_new_asset(
            original_init,
            original_lc,
            editor.find_pkgs("system/scripts/init.lc")
        )

def create_scenario_copy(editor: FileTreeEditor):
    original_scenario = "system/scripts/original_scenario.lc"
    if not editor.does_asset_exists(original_scenario):
        original_lc = editor.get_raw_asset("system/scripts/scenario.lc")
        editor.add_new_asset(
            original_scenario,
            original_lc,
            editor.find_pkgs("system/scripts/scenario.lc")
        )



def create_custom_init(inventory: dict[str, int], starting_location: dict):
    def _wrap(v: str):
        return f'"{v}"'

    replacement = {
        "new_game_inventory": "\n".join(
            "{} = {},".format(key, value)
            for key, value in inventory.items()
        ),
        "starting_scenario": _wrap(starting_location["scenario"]),
        "starting_actor": _wrap(starting_location["actor"]),
    }

    code = Path(__file__).parent.joinpath("custom_init.lua").read_text()
    for key, content in replacement.items():
        code = code.replace(f'TEMPLATE("{key}")', content)

    return code

def create_custom_scenario():
    def _wrap(v: str):
        return f'"{v}"'

    code = Path(__file__).parent.joinpath("custom_scenario.lua").read_text()
    return code


class PatcherEditor(FileTreeEditor):
    memory_files: dict[str, BaseResource]

    def __init__(self, root: Path):
        super().__init__(root, game)
        self.memory_files = {}

    def get_file(self, path: str, type_hint: typing.Type[T] = BaseResource) -> T:
        if path not in self.memory_files:
            self.memory_files[path] = self.get_parsed_asset(path, type_hint=type_hint)
        return self.memory_files[path]

    def get_scenario(self, name: str) -> Bmsld:
        return self.get_file(path_for_level(name) + ".bmsld", Bmsld)

    def flush_modified_assets(self):
        for name, resource in self.memory_files.items():
            self.replace_asset(name, resource)
        self.memory_files = {}


# def patch_elevators(editor: PatcherEditor, elevators_config: list[dict]):
#     for elevator in elevators_config:
#         level = editor.get_scenario(elevator["teleporter"]["scenario"])
#         actor = level.actors_for_layer(elevator["teleporter"]["layer"])[elevator["teleporter"]["actor"]]
#         try:
#             usable = actor.pComponents.USABLE
#         except AttributeError:
#             raise ValueError(f'Actor {elevator["teleporter"]} is not a teleporter')
#         usable.sScenarioName = elevator["destination"]["scenario"]
#         usable.sTargetSpawnPoint = elevator["destination"]["actor"]


def patch(input_path: Path, output_path: Path, configuration: dict):
    LOG.info("Will patch files at %s", input_path)

    jsonschema.validate(instance=configuration, schema=_read_schema())

    out_romfs = output_path.joinpath("romfs")
    editor = PatcherEditor(input_path)
    create_init_copy(editor)
    create_scenario_copy(editor)

    editor.replace_asset(
        "system/scripts/init.lc",
        create_custom_init(configuration["starting_items"],
                           configuration["starting_location"]
                           ).encode("ascii"))
    
    editor.replace_asset(
        "system/scripts/scenario.lc",
        create_custom_scenario().encode("ascii")
    )
    
    
    areas = [
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
                "s110_surfaceb"
            ]

    for x in areas:
        lua_util.replace_script(
            editor,
            f"maps/levels/c10_samus/{x}/{x}",
            f"levels/{x}.lc.lua"
            )


    # actor = level.actors_for_layer("default")[configuration["starting_location"]["actor"]]
    # old_on_teleport = actor.pComponents["STARTPOINT"]["sOnTeleport"]
    # if old_on_teleport not in ("", "Game.HUDIdleScreenLeave"):
    #     raise ValueError("Starting actor at {} with unexpected sOnTeleport: {}".format(
    #         configuration["starting_location"], old_on_teleport,
    #     ))
    # actor.pComponents["STARTPOINT"]["sOnTeleport"] = "Game.HUDIdleScreenLeave"

    # if "elevators" in configuration:
    #     patch_elevators(editor, configuration["elevators"])

    editor.flush_modified_assets()
    editor.save_modifications(out_romfs, OutputFormat.PKG)
    logging.info("Done")
