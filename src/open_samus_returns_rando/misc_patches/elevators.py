from construct import Container  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats.bmsld import ActorLayer
from mercury_engine_data_structures.formats.lua import Lua

from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor


def create_elevator_table(editor: PatcherEditor, configuration: dict) -> None:
    py_dict: dict = configuration["elevators"]

    file = lua_util.replace_lua_template("elevators.lua", {"elevator_dict": py_dict}, True)
    editor.add_new_asset(
        "system/scripts/elevators.lc",
        Lua(Container(lua_text=file), editor.target_game),
        []
    )


def update_elevators(editor: PatcherEditor, configuration: dict) -> None:
    for scenario_name, elevators in configuration["elevators"].items():
        scenario = editor.get_scenario(scenario_name)
        for elevator in elevators:
            actor = scenario.get_actor(ActorLayer.PLATFORM, elevator)
            actor.get_component_function().set_argument(1, "Scenario.RandoOnElevatorUse")


def patch_elevators(editor: PatcherEditor, configuration: dict) -> None:
    create_elevator_table(editor, configuration)
    update_elevators(editor, configuration)
