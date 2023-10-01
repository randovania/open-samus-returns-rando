from open_samus_returns_rando.patcher_editor import PatcherEditor


def _get_actor(editor: PatcherEditor):
    actor_to_copy = {
        "scenario": "s000_surface",
        "layer": "9",
        "actor": "LE_PowerUP_Morphball",
    }
    baby_actor = editor.resolve_actor_reference(actor_to_copy)
    return baby_actor


def _create_baby_pickup(editor: PatcherEditor):
    name_of_scenario = "s100_area10"
    scenario_10 = editor.get_scenario(name_of_scenario)

    baby_actor = _get_actor(editor)
    editor.copy_actor(
        name_of_scenario, (-3400.0, 11225.0, 0.0), baby_actor, "LE_Baby_Hatchling", 9
    )

    group_cc22 = scenario_10.get_actor_group("eg_SubArea_collision_camera_022")
    group_cc22.names.insert(-1, "LE_Baby_Hatchling")


def patch_custom_pickups(editor: PatcherEditor):
    _create_baby_pickup(editor)
