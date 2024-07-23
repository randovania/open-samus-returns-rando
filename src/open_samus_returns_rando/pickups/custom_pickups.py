import typing

from construct import Container, ListContainer  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsmsd
from open_samus_returns_rando.patcher_editor import PatcherEditor


class NewPickups(typing.NamedTuple):
    scenario: str
    name: str
    position: list[float]
    tile_index: int
    entity_groups: list[str]


new_pickups = [
    NewPickups(
        "s100_area10", "LE_Baby_Hatchling", [-3400.0, 11225.0, 0.0], 252, ["collision_camera_022"]
    )
]


def add_pickups(editor: PatcherEditor, new_pickup: NewPickups) -> None:
    template_pickup = editor.get_scenario("s000_surface").raw.actors[9]["LE_PowerUP_Morphball"]

    PICKUP_ICON = Container({
        "actor_name": new_pickup.name,
        "clear_condition": "",
        "icon": "itemenabled",
        "icon_priority": 0,
        "coordinates": ListContainer(new_pickup.position),
    })

    scenario_name = new_pickup.scenario
    scenario_file = editor.get_scenario(scenario_name)

    editor.copy_actor(scenario_name, new_pickup.position, template_pickup, new_pickup.name, 9)

    scenario_map = editor.get_file(f"gui/minimaps/c10_samus/{scenario_name}.bmsmsd", Bmsmsd)
    scenario_map.raw["tiles"][new_pickup.tile_index]["icons"] = ListContainer([PICKUP_ICON])

    for entity_group in new_pickup.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, new_pickup.name, True)


def patch_custom_pickups(editor: PatcherEditor) -> None:
    for new_pickup in new_pickups:
        add_pickups(editor, new_pickup)
