from open_samus_returns_rando.patcher_editor import PatcherEditor


def unpack_new_actor(new_actor: dict) -> tuple[str, str, str, list[float]]:
    scenario_name = new_actor["new_actor"]["scenario"]
    new_actor_name = new_actor["new_actor"]["actor"]
    collision_camera_name = new_actor["collision_camera_name"]
    new_pos = [new_actor["location"]["x"], new_actor["location"]["y"], new_actor["location"]["z"]]
    return scenario_name,new_actor_name,collision_camera_name,new_pos


def debug_spawn_points(editor: PatcherEditor, spawn_config: list[dict]) -> None:
    # create custom spawn point
    _EXAMPLE_SP = {"scenario": "s010_area1", "layer": "5", "actor": "StartPoint0"}
    base_actor = editor.resolve_actor_reference(_EXAMPLE_SP)
    for new_spawn in spawn_config:
        scenario_name, new_actor_name, collision_camera_name, new_spawn_pos = unpack_new_actor(new_spawn)
        scenario = editor.get_scenario(scenario_name)
        editor.copy_actor(scenario_name, new_spawn_pos, base_actor, new_actor_name, 5)
        scenario.add_actor_to_entity_groups(collision_camera_name, new_actor_name)


def debug_custom_pickups(editor: PatcherEditor, pickup_config: list[dict]) -> None:
    # create custom pickup
    _EXAMPLE_PICKUP = {"scenario": "s000_surface", "layer": "9", "actor": "LE_PowerUP_Morphball"}
    base_actor = editor.resolve_actor_reference(_EXAMPLE_PICKUP)
    for new_pickup in pickup_config:
        scenario_name, new_actor_name, collision_camera_name, new_pos = unpack_new_actor(new_pickup)
        scenario = editor.get_scenario(scenario_name)
        editor.copy_actor(scenario_name, new_pos, base_actor, new_actor_name, 9)
        scenario.add_actor_to_entity_groups(collision_camera_name, new_actor_name)
