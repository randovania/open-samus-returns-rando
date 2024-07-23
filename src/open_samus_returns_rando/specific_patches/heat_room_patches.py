import copy
import typing

from construct import Container, ListContainer  # type: ignore[import-untyped]
from open_samus_returns_rando.patcher_editor import PatcherEditor


def _patch_area_2b(editor: PatcherEditor) -> None:
    # area2b => shape is already correct but ms forgot to add one room
    heat_trigger_2b = {"scenario": "s025_area2b", "layer": "2", "actor": "TG_SP_Heat_001"}
    scenario_2b = editor.get_scenario(heat_trigger_2b["scenario"])
    scenario_2b.add_actor_to_entity_groups("collision_camera013", heat_trigger_2b["actor"])


class NewHeatActor(typing.NamedTuple):
    scenario: str
    position: list[float]
    total_boundings: list[float]
    points: list[tuple[float, float]]
    entity_groups: list[str]
    trigger_name: str = "TG_Heat_Rando_001"
    logic_shape_name: str = "LS_Heat_Rando_001"

new_heat_actors = [
    NewHeatActor(
        "s033_area3b", [1000.0, 5000.0, 0.0], [-500.0, 3800.0, 3900.0, 6700.0],
        [(-500.0, 3800.0), (3900.0, 3800.0), (3900.0, 6700.0), (-500.0, 6700.0)],
        ["collision_camera_036"]
    ),
    NewHeatActor(
        "s036_area3c", [19269.0, 3669.0, 0.0], [10800.0, 1700.0, 21700.0, 5800.0],
        [(10800.0, 1700.0), (21700.0, 1700.0), (21700.0, 5800.0), (10800.0, 5800.0)],
        ["collision_camera_022", "collision_camera_026"]
    ),
    NewHeatActor(
        "s040_area4", [1000.0, 1000.0, 0.0], [-850.0, 300.0, 4250.0, 1950.0],
        [(-850.0, 300.0), (4250.0, 300.0), (4250.0, 1950.0), (-850.0, 1950.0)],
        ["collision_camera_005", "PostGamma_001"]
    ),
    NewHeatActor(
        "s050_area5", [-2000.0, 5000.0, 0.0], [-2400.0, 4400.0, -200.0, 6700.0],
        [(-2400.0, 4400.0), (-200.0, 4400.0), (-200.0, 6700.0), (-2400.0, 6700.0)],
        ["collision_camera_006"]
    ),
    NewHeatActor(
        "s050_area5", [5600.0, 16000.0, 0.0], [5500.0, 5900.0, 17700.0, 10700.0],
        [(5500.0, 5900.0), (17700.0, 5900.0), (17700.0, 10700.0), (5500.0, 10700.0)],
        ["collision_camera_009", "collision_camera_015", "collision_camera_017", "017_PostGamma_002", "PostGamma_002"],
        "TG_Heat_Rando_002", "LS_Heat_Rando_002"
    ),
    NewHeatActor(
        "s065_area6b", [6000.0, 9000.0, 0.0], [7600.0, 5800.0, 14200.0, 7900.0],
        [(7600.0, 5800.0), (14200.0, 5800.0), (14200.0, 7900.0), (7600.0, 7900.0)],
        ["collision_camera_014", "collision_camera_017", "collision_camera_018", "PostGamma_002"]
    ),
    NewHeatActor(
        "s067_area6c", [1000.0, 2000.0, 0.0], [-27100.0, 3400.0, -21900.0, 6000.0],
        [(-27100.0, 3400.0), (21900.0, 3400.0), (21900.0, 6000.0), (-27100.0, 6000.0)],
        ["collision_camera_022", "PostGamma_001"]
    ),
]


def _get_new_logic_shape(editor: PatcherEditor, new_actor: NewHeatActor) -> Container:
    scenario_2b = editor.get_scenario("s025_area2b")
    ls_copy = copy.deepcopy(scenario_2b.raw["objects_c"]["LS_Heat_001"])
    example_point = ls_copy["data"]["polys"][0]["points"][0]
    ls_copy["data"]["polys"][0]["points"].clear()
    for point in new_actor.points:
        new_point = copy.deepcopy(example_point)
        new_point["x"] = point[0]
        new_point["y"] = point[1]
        ls_copy["data"]["polys"][0]["points"].append(new_point)
    ls_copy["data"]["polys"][0]["num_points"] = len(new_actor.points)
    return ls_copy


def add_heat_actors(editor: PatcherEditor, new_heat_actor: NewHeatActor)-> None:
    template_ht = editor.get_scenario("s010_area1").raw.actors[2]["TG_Heat_001"]

    scenario_name = new_heat_actor.scenario
    scenario_file = editor.get_scenario(scenario_name)

    total_boundings = ListContainer(new_heat_actor.total_boundings)
    new_logic_shape = _get_new_logic_shape(editor, new_heat_actor)
    new_logic_shape["data"]["total_boundings"] = total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] = total_boundings

    scenario_file.raw["objects_c"][new_heat_actor.logic_shape_name] = new_logic_shape

    new_actor = editor.copy_actor(scenario_name, new_heat_actor.position, template_ht, new_heat_actor.trigger_name, 2)
    new_actor["components"][0]["arguments"][16]["value"] = new_heat_actor.logic_shape_name

    for entity_group in new_heat_actor.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, new_heat_actor.trigger_name, True)


def patch_heat_rooms(editor: PatcherEditor)-> None:
    _patch_area_2b(editor)
    for new_heat_actor in new_heat_actors:
        add_heat_actors(editor, new_heat_actor)
