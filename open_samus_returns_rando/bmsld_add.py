# FIXME: Can be moved later to MEDS as methods of Bmsld!
import logging
from collections.abc import Iterator

from construct import Container
from mercury_engine_data_structures.formats.bmsld import Bmsld

LOG = logging.getLogger("bmsld_add")

def all_actor_groups(scenario: Bmsld) -> Iterator[tuple[str, Container]]:
    for sub_area in scenario.raw.sub_areas:
        yield sub_area.name, sub_area

def add_actor_to_group(group: Container, actor_name: str, pos: int = -1):
    group.names.insert(pos, actor_name)

def get_actor_group(scenario: Bmsld, group_name: str) -> Container:
    group = next(
        (sub_area for sub_area_name, sub_area in all_actor_groups(scenario)
        if sub_area_name == group_name),
        None
    )
    if group is None:
        raise Exception(f"No group found with name for {group_name}")
    return group

def add_actor_to_entity_groups(scenario: Bmsld, collision_camera_name: str, actor_name: str, all_groups: bool = False):
    def compare_func(first: str, second: str) -> bool:
        if all_groups:
            return first.startswith(f"eg_SubArea_{second}")
        else:
            return first == f"eg_SubArea_{second}"

    collision_camera_groups = [group for group_name, group in all_actor_groups(scenario)
                                if compare_func(group_name, collision_camera_name)]
    if len(collision_camera_groups) == 0:
        raise Exception(f"No entity group found for {collision_camera_name}")
    for group in collision_camera_groups:
        LOG.debug("Add actor %s to group %s", actor_name, group.name)
        add_actor_to_group(group, actor_name)

def all_actor_group_names_for_actor(scenario: Bmsld, actor_name: str) -> list[str]:
    return [
        actor_group_name
        for actor_group_name, actor_group in all_actor_groups(scenario)
        if actor_name in actor_group.names
    ]

def remove_actor_from_group(scenario: Bmsld, group_name: str, actor_name: str):
    LOG.debug("Remove actor %s from group %s", actor_name, group_name)
    group = get_actor_group(scenario, group_name)
    group.names.remove(actor_name)

def remove_actor_from_all_groups(scenario: Bmsld, actor_name: str):
    group_names = all_actor_group_names_for_actor(scenario, actor_name)
    for group_name in group_names:
        remove_actor_from_group(scenario, group_name, actor_name)
