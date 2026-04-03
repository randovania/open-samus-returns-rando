import typing

from mercury_engine_data_structures.formats.bmsld import ActorLayer

from open_samus_returns_rando.patcher_editor import PatcherEditor


class NewSpawnPoint(typing.NamedTuple):
    scenario: str
    name: str
    position: list[float]
    rotation: float
    entity_groups: list[str]


new_spawnpoints = [
    NewSpawnPoint(
        "s000_surface", "ST_Surface_Connector", [-22800.0, 4450.0, 0.0], 90.0, ["collision_camera_000"]
    ),
    NewSpawnPoint(
        "s050_area5", "ST_Diggernaut_Chase_Respawn", [-2100.0, -4800.0, 0.0], 90.0, ["collision_camera_AfterChase_001"]
    ),
    NewSpawnPoint(
        "s070_area7", "ST_SG_Diggernaut_Checkpoint", [-21450.0, -7600.0, 0.0], 90.0, ["collision_camera_045"]
    ),
    NewSpawnPoint(
        "s110_surfaceb", "ST_SurfaceB_Connector", [-23179.0, 4500.0, 0.0], -90.0, ["collision_camera_017"]
    ),
]


def add_spawnpoints(editor: PatcherEditor, new_spawnpoint: NewSpawnPoint) -> None:
    template_sp = editor.get_scenario("s000_surface").get_actor(ActorLayer.STARTPOINT, "ST_SG_Alpha_001")
    template_sp.rotation.y = new_spawnpoint.rotation

    scenario_name = new_spawnpoint.scenario
    scenario_file = editor.get_scenario(scenario_name)

    scenario_file.copy_actor(new_spawnpoint.position, template_sp, new_spawnpoint.name, ActorLayer.STARTPOINT)

    actor = scenario_file.get_actor(ActorLayer.STARTPOINT, new_spawnpoint.name)
    actor.rotation.y = new_spawnpoint.rotation

    for entity_group in new_spawnpoint.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, new_spawnpoint.name, True)


def patch_custom_spawn_points(editor: PatcherEditor) -> None:
    for new_spawnpoint in new_spawnpoints:
        add_spawnpoints(editor, new_spawnpoint)
