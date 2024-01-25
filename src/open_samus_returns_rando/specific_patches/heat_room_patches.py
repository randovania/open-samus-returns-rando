import copy

from construct import Container, ListContainer
from open_samus_returns_rando.patcher_editor import PatcherEditor


def _get_new_logic_shape(editor: PatcherEditor, points: int) -> Container:
    scenario_2b = editor.get_scenario("s025_area2b")
    ls_copy = copy.deepcopy(scenario_2b.raw["objects_c"]["LS_Heat_001"])
    example_point = ls_copy["data"]["polys"][0]["points"][0]
    ls_copy["data"]["polys"][0]["points"].clear()
    for i in range(points):
        ls_copy["data"]["polys"][0]["points"].append(copy.deepcopy(example_point))
    ls_copy["data"]["polys"][0]["num_points"] = points
    return ls_copy

def _get_heat_trigger(editor: PatcherEditor) -> Container:
    ht_to_copy = {"scenario": "s010_area1", "layer": "2", "actor": "TG_Heat_001"}
    heat_actor = editor.resolve_actor_reference(ht_to_copy)
    return heat_actor


def _patch_area_2b(editor: PatcherEditor):
    # area2b => shape is already correct but ms forgot to add one room
    heat_trigger_2b = {"scenario": "s025_area2b", "layer": "2", "actor": "TG_SP_Heat_001"}
    scenario_2b = editor.get_scenario(heat_trigger_2b["scenario"])
    scenario_2b.add_actor_to_entity_groups("collision_camera013", heat_trigger_2b["actor"])

def _patch_area_3b(editor: PatcherEditor):
    name_of_scenario = "s033_area3b"

    scenario_3b = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([-500.0, 3800.0, 3900.0, 6700.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = -500.0
    points[0]["y"] = 3800.0
    points[1]["x"] = 3900.0
    points[1]["y"] = 3800.0
    points[2]["x"] = 3900.0
    points[2]["y"] = 6700.0
    points[3]["x"] = -500.0
    points[3]["y"] = 6700.0

    scenario_3b.raw["objects_c"]["LS_Heat_001"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    editor.copy_actor(name_of_scenario, (1000.0, 5000.0, 0.0), heat_actor, "TG_Heat_003", 2)
    scenario_3b.add_actor_to_entity_groups("collision_camera_036", "TG_Heat_003")

def _patch_area_3c(editor: PatcherEditor):
    name_of_scenario = "s036_area3c"

    scenario_3c = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([10800.0, 1700.0, 21700.0, 5800.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = 10800.0
    points[0]["y"] = 1700.0
    points[1]["x"] = 21700.0
    points[1]["y"] = 1700.0
    points[2]["x"] = 21700.0
    points[2]["y"] = 5800.0
    points[3]["x"] = 10800.0
    points[3]["y"] = 5800.0

    scenario_3c.raw["objects_c"]["LS_Heat_001"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    editor.copy_actor(name_of_scenario, (19269.0, 3669.0, 0.0), heat_actor, "TG_Heat_003", 2)

    scenario_3c.add_actor_to_entity_groups("collision_camera_022", "TG_Heat_003")
    scenario_3c.add_actor_to_entity_groups("collision_camera_026", "TG_Heat_003")

def _patch_area_4(editor: PatcherEditor):
    name_of_scenario = "s040_area4"

    scenario_4 = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([-850.0, 300.0, 4250.0, 1950.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = -850.0
    points[0]["y"] = 300.0
    points[1]["x"] = 4250.0
    points[1]["y"] = 300.0
    points[2]["x"] = 4250.0
    points[2]["y"] = 1950.0
    points[3]["x"] = -850.0
    points[3]["y"] = 1950.0

    scenario_4.raw["objects_c"]["LS_Heat_001"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    editor.copy_actor(name_of_scenario, (1000.0, 1000.0, 0.0), heat_actor, "TG_Heat_003", 2)

    scenario_4.add_actor_to_entity_groups("collision_camera_005", "TG_Heat_003", True)
    scenario_4.add_actor_to_entity_groups("PostGamma_001", "TG_Heat_003", True)


def _patch_area_5_1(editor: PatcherEditor):
    name_of_scenario = "s050_area5"

    scenario_5 = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([-2400.0, 4400.0, -200.0, 6700.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = -2400.0
    points[0]["y"] = 4400.0
    points[1]["x"] = -200.0
    points[1]["y"] = 4400.0
    points[2]["x"] = -200.0
    points[2]["y"] = 6700.0
    points[3]["x"] = -2400.0
    points[3]["y"] = 6700.0

    scenario_5.raw["objects_c"]["LS_Heat_001"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    editor.copy_actor(name_of_scenario, (-2000.0, 5000.0, 0.0), heat_actor, "TG_Heat_003", 2)

    scenario_5.add_actor_to_entity_groups("collision_camera_006", "TG_Heat_003", True)


def _patch_area_5_2(editor: PatcherEditor):
    name_of_scenario = "s050_area5"

    scenario_5 = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([5500.0, 5900.0, 17700.0, 10700.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = 5500.0
    points[0]["y"] = 5900.0
    points[1]["x"] = 17700.0
    points[1]["y"] = 5900.0
    points[2]["x"] = 17700.0
    points[2]["y"] = 10700.0
    points[3]["x"] = 5500.0
    points[3]["y"] = 10700.0

    scenario_5.raw["objects_c"]["LS_Heat_002"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    new_actor = editor.copy_actor(name_of_scenario, (5600.0, 16000.0, 0.0), heat_actor, "TG_Heat_033", 2)
    new_actor["components"][0]["arguments"][16]["value"] = "LS_Heat_002"

    scenario_5.add_actor_to_entity_groups("collision_camera_009", "TG_Heat_033", True)
    scenario_5.add_actor_to_entity_groups("collision_camera_015", "TG_Heat_033", True)
    scenario_5.add_actor_to_entity_groups("collision_camera_017", "TG_Heat_033", True)
    scenario_5.add_actor_to_entity_groups("017_PostGamma_002", "TG_Heat_033", True)
    scenario_5.add_actor_to_entity_groups("PostGamma_002", "TG_Heat_033", True)

def _patch_area_6_b(editor: PatcherEditor):
    name_of_scenario = "s065_area6b"

    scenario_6b = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([7600.0, 5800.0, 14200.0, 7900.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = 7600.0
    points[0]["y"] = 5800.0
    points[1]["x"] = 14200.0
    points[1]["y"] = 5800.0
    points[2]["x"] = 14200.0
    points[2]["y"] = 7900.0
    points[3]["x"] = 7600.0
    points[3]["y"] = 7900.0

    scenario_6b.raw["objects_c"]["LS_Heat_001"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    editor.copy_actor(name_of_scenario, (6000.0, 9000.0, 0.0), heat_actor, "TG_Heat_003", 2)

    scenario_6b.add_actor_to_entity_groups("collision_camera_014", "TG_Heat_003", True)
    scenario_6b.add_actor_to_entity_groups("collision_camera_017", "TG_Heat_003", True)
    scenario_6b.add_actor_to_entity_groups("collision_camera_018", "TG_Heat_003", True)
    scenario_6b.add_actor_to_entity_groups("PostGamma_002", "TG_Heat_003", True)


def _patch_area_6_c(editor: PatcherEditor):
    name_of_scenario = "s067_area6c"

    scenario_6c = editor.get_scenario(name_of_scenario)

    total_boundings = ListContainer([-27100.0, 3400.0, -21900.0, 6000.0])
    new_logic_shape = _get_new_logic_shape(editor, 4)
    new_logic_shape["data"]["total_boundings"] =  total_boundings
    new_logic_shape["data"]["polys"][0]["boundings"] =  total_boundings
    points = new_logic_shape["data"]["polys"][0]["points"]

    points[0]["x"] = -27100.0
    points[0]["y"] = 3400.0
    points[1]["x"] = -21900.0
    points[1]["y"] = 3400.0
    points[2]["x"] = -21900.0
    points[2]["y"] = 6000.0
    points[3]["x"] = -27100.0
    points[3]["y"] = 6000.0

    scenario_6c.raw["objects_c"]["LS_Heat_001"] = new_logic_shape

    heat_actor = _get_heat_trigger(editor)
    editor.copy_actor(name_of_scenario, (1000.0, 2000.0, 0.0), heat_actor, "TG_Heat_003", 2)

    scenario_6c.add_actor_to_entity_groups("collision_camera_022", "TG_Heat_003", True)
    scenario_6c.add_actor_to_entity_groups("PostGamma_001", "TG_Heat_003", True)

def patch_heat_rooms(editor: PatcherEditor):
    _patch_area_2b(editor)
    _patch_area_3b(editor)
    _patch_area_3c(editor)
    _patch_area_4(editor)
    _patch_area_5_1(editor)
    _patch_area_5_2(editor)
    _patch_area_6_b(editor)
    _patch_area_6_c(editor)
