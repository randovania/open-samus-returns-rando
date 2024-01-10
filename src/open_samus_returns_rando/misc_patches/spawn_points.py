from open_samus_returns_rando.patcher_editor import PatcherEditor


def _get_spawnpoint(editor: PatcherEditor):
    actor_to_copy = {
        "scenario": "s000_surface",
        "layer": "5",
        "actor": "ST_SG_Alpha_001",
    }
    spawnpoint = editor.resolve_actor_reference(actor_to_copy)
    return spawnpoint


def _surface_east_connector(editor: PatcherEditor):
    name_of_scenario = "s000_surface"
    scenario_surface = editor.get_scenario(name_of_scenario)
    name_of_spawnpoint = "ST_Surface_Connector"

    spawnpoint = _get_spawnpoint(editor)

    editor.copy_actor(
        name_of_scenario, (-22800.0, 4450.0, 0.0), spawnpoint, name_of_spawnpoint, 5,
    )

    scenario_surface.add_actor_to_entity_groups("collision_camera_000", name_of_spawnpoint)


def _surface_west_connector(editor: PatcherEditor):
    name_of_scenario = "s110_surfaceb"
    scenario_surfaceb = editor.get_scenario(name_of_scenario)
    name_of_spawnpoint = "ST_SurfaceB_Connector"

    spawnpoint = _get_spawnpoint(editor)

    spawnpoint_actor = editor.copy_actor(
        name_of_scenario, (-23179.0, 4500.0, 0.0), spawnpoint, name_of_spawnpoint, 5,
    )

    scenario_surfaceb.add_actor_to_entity_groups("collision_camera_017", name_of_spawnpoint)

    spawnpoint_actor["rotation"][1] = -90


def _diggernaut_chase_respawn(editor: PatcherEditor):
    name_of_scenario = "s050_area5"
    scenario_area5 = editor.get_scenario(name_of_scenario)
    name_of_spawnpoint = "ST_Diggernaut_Chase_Respawn"

    spawnpoint = _get_spawnpoint(editor)

    editor.copy_actor(
        name_of_scenario, (-2100.0, -4800.0, 0.0), spawnpoint, name_of_spawnpoint, 5,
    )

    scenario_area5.add_actor_to_entity_groups("collision_camera_AfterChase_001", name_of_spawnpoint)


def patch_custom_spawn_points(editor: PatcherEditor):
    _surface_east_connector(editor)
    _surface_west_connector(editor)
    _diggernaut_chase_respawn(editor)
