from construct import Container
from mercury_engine_data_structures.formats.lua import Lua
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def create_elevator_table(editor: PatcherEditor, configuration: dict):
    py_dict: dict = configuration["elevators"]

    file = lua_util.replace_lua_template("elevators.lua", {"elevator_dict": py_dict}, True)
    editor.add_new_asset(
        "system/scripts/elevators.lc",
        Lua(Container(lua_text=file), editor.target_game),
        []
    )


def update_elevators(editor: PatcherEditor, configuration: dict):
    ELEVATORS = {
        "s000_surface": ["LE_Platform_Elevator_FromArea01"],
        "s010_area1": [
            "LE_Platform_Elevator_FromArea00",
            "LE_Platform_Elevator_FromArea02",
        ],
        "s020_area2": [
            "LE_Platform_Elevator_FromArea02B",
            "LE_Platform_Elevator_FromArea02C",
        ],
        "s025_area2b": ["LE_Platform_Elevator_FromArea02A"],
        "s028_area2c": [
            "LE_Platform_Elevator_FromArea01",
            "LE_Platform_Elevator_FromArea02A",
            "LE_Platform_Elevator_FromArea03",
        ],
        "s030_area3": [
            "LE_Platform_Elevator_FromArea02",
            "LE_Platform_Elevator_FromArea03B_01",
            "LE_Platform_Elevator_FromArea03B_02",
            "LE_Platform_Elevator_FromArea03C",
            "LE_Platform_Elevator_FromArea04",
        ],
        "s033_area3b": [
            "LE_Platform_Elevator_FromArea03A_01",
            "LE_Platform_Elevator_FromArea03A_02",
            "LE_Platform_Elevator_FromArea03C",
        ],
        "s036_area3c": [
            "LE_Platform_Elevator_FromArea03A",
            "LE_Platform_Elevator_FromArea03B",
        ],
        "s040_area4": [
            "LE_Platform_Elevator_FromArea03",
            "LE_Platform_Elevator_FromArea05",
            "LE_Platform_Elevator_FromArea06",
        ],
        "s050_area5": ["LE_Platform_Elevator_FromArea04"],
        "s060_area6": [
            "LE_Platform_Elevator_FromArea04",
            "LE_Platform_Elevator_FromArea06C_01",
            "LE_Platform_Elevator_FromArea06C_02",
            "LE_Platform_Elevator_FromArea07",
        ],
        "s065_area6b": [
            "LE_Platform_Elevator_FromArea06C_01",
            "LE_Platform_Elevator_FromArea06C_02",
        ],
        "s067_area6c": [
            "LE_Platform_Elevator_FromArea06A_01",
            "LE_Platform_Elevator_FromArea06A_02",
            "LE_Platform_Elevator_FromArea06B_01",
            "LE_Platform_Elevator_FromArea06B_02",
        ],
        "s070_area7": [
            "LE_Platform_Elevator_FromArea06",
            "LE_Platform_Elevator_FromArea09",
        ],
        "s090_area9": [
            "LE_Platform_Elevator_FromArea07",
            "LE_Platform_Elevator_FromArea10",
        ],
        "s100_area10": [
            "LE_Platform_Elevator_FromArea09",
            "LE_Platform_Elevator_FromAreaSurfaceB",
        ],
        "s110_surfaceb": ["LE_Platform_Elevator_FromArea10"],
    }

    for scenario_name, elevators in ELEVATORS.items():
        scenario = editor.get_scenario(scenario_name)
        for elevator in elevators:
            platform = scenario.raw.actors[10][elevator]["components"][0]
            platform["arguments"][1]["value"] = "Scenario.RandoOnElevatorUse"


def patch_elevators(editor: PatcherEditor, configuration: dict):
    create_elevator_table(editor, configuration)
    update_elevators(editor, configuration)
