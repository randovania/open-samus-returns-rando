from mercury_engine_data_structures.formats.bmsld import ActorLayer

from open_samus_returns_rando.patcher_editor import PatcherEditor


def unpack_new_actor(new_actor: dict) -> tuple[str, str, str, list[float]]:
    scenario_name = new_actor["new_actor"]["scenario"]
    new_actor_name = new_actor["new_actor"]["actor"]
    collision_camera_name = new_actor["collision_camera_name"]
    new_pos = [new_actor["location"]["x"], new_actor["location"]["y"], new_actor["location"]["z"]]
    return scenario_name, new_actor_name, collision_camera_name, new_pos


def debug_spawn_points(editor: PatcherEditor, spawn_config: list[dict]) -> None:
    # create custom spawn point
    example_sp = editor.get_scenario("s010_area1").get_actor(ActorLayer.STARTPOINT, "StartPoint0")
    for new_spawn in spawn_config:
        scenario_name, new_actor_name, collision_camera_name, new_spawn_pos = unpack_new_actor(new_spawn)
        scenario = editor.get_scenario(scenario_name)
        scenario.copy_actor(new_spawn_pos, example_sp, new_actor_name, ActorLayer.STARTPOINT)
        scenario.add_actor_to_entity_groups(collision_camera_name, new_actor_name)


def debug_custom_pickups(editor: PatcherEditor, pickup_config: list[dict]) -> None:
    # create custom pickup
    example_pickup = editor.get_scenario("s000_surface").get_actor(ActorLayer.PASSIVE, "LE_PowerUP_Morphball")
    for new_pickup in pickup_config:
        scenario_name, new_actor_name, collision_camera_name, new_pos = unpack_new_actor(new_pickup)
        scenario = editor.get_scenario(scenario_name)
        scenario.copy_actor(new_pos, example_pickup, new_actor_name, ActorLayer.PASSIVE)
        scenario.add_actor_to_entity_groups(collision_camera_name, new_actor_name)
