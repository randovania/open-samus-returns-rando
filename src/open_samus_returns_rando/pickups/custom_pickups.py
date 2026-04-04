import typing

from construct import Container, ListContainer  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsmsd
from mercury_engine_data_structures.formats.bmsld import ActorLayer
from mercury_engine_data_structures.formats.bmsmsd import IconPriority

from open_samus_returns_rando.patcher_editor import PatcherEditor


class NewPickups(typing.NamedTuple):
    scenario: str
    name: str
    position: list[float]
    tile_index: int
    entity_groups: list[str]


new_pickups = [
    NewPickups("s000_surface", "LE_Item_Ridley", [-8000.0, 1900.0, 0.0], 168, ["collision_camera_000"]),
    NewPickups("s100_area10", "LE_Baby_Hatchling", [-3400.0, 11225.0, 0.0], 252, ["collision_camera_022"]),
]


def add_pickups(editor: PatcherEditor, new_pickup: NewPickups) -> None:
    template_pickup = editor.get_scenario("s000_surface").get_actor(ActorLayer.PASSIVE, "LE_PowerUP_Morphball")

    PICKUP_ICON = Container(
        {
            "actor_name": new_pickup.name,
            "clear_condition": "",
            "icon": "itemenabled",
            "icon_priority": IconPriority.ACTOR,
            "coordinates": ListContainer(new_pickup.position),
        }
    )

    scenario_name = new_pickup.scenario
    scenario_file = editor.get_scenario(scenario_name)

    scenario_file.copy_actor(new_pickup.position, template_pickup, new_pickup.name, ActorLayer.PASSIVE)

    scenario_map = editor.get_file(f"gui/minimaps/c10_samus/{scenario_name}.bmsmsd", Bmsmsd)
    scenario_map.raw["tiles"][new_pickup.tile_index]["icons"] = ListContainer([PICKUP_ICON])

    for entity_group in new_pickup.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, new_pickup.name, True)


def patch_custom_pickups(editor: PatcherEditor, configuration: dict) -> None:
    for new_pickup in new_pickups:
        # Memory errors occur if the custom boss pickup is added and the pickup is not in the config
        # TODO: Generalize this so it's not duplicated statements
        if configuration["objective"]["final_boss"] == "Ridley" and new_pickup.name == "LE_Item_Ridley":
            continue
        if configuration["objective"]["final_boss"] == "Queen" and new_pickup.name == "LE_Baby_Hatchling":
            continue
        add_pickups(editor, new_pickup)
