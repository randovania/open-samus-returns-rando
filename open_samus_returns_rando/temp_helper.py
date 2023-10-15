from bisect import bisect

from construct import Container
from mercury_engine_data_structures.crc import crc32
from mercury_engine_data_structures.formats import Bmsld

# TODO: Integrate to MEDS

def insert_into_sub_area(sub_area: Container, name_to_add: str) -> None:
    crcs_list = [
        crc32(name)
        for name in sub_area.names
    ]
    crc_to_add = crc32(name_to_add)
    index = bisect(crcs_list, crc_to_add)
    sub_area.names.insert(index, name_to_add)

def add_actor_to_entity_groups(scenario: Bmsld, collision_camera_name: str, actor_name: str, all_groups: bool = False):
    def compare_func(first: str, second: str) -> bool:
        if all_groups:
            return first.startswith(f"eg_SubArea_{second}")
        else:
            return first == f"eg_SubArea_{second}"

    collision_camera_groups = [group for group_name, group in scenario.all_actor_groups()
                                if compare_func(group_name, collision_camera_name)]
    if len(collision_camera_groups) == 0:
        raise Exception(f"No entity group found for {collision_camera_name}")
    for group in collision_camera_groups:
        insert_into_sub_area(group, actor_name)
