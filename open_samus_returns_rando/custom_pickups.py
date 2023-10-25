from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsmsd

from open_samus_returns_rando.patcher_editor import PatcherEditor

BABY_ICON = Container({
    "actor_name": "LE_Baby_Hatchling",
    "clear_condition": "",
    "icon": "itemsphere",
    "icon_priority": 0,
    "coordinates": ListContainer([
        -3400.0,
        11225.0,
        0.0
    ]),
})


def _get_actor(editor: PatcherEditor):
    actor_to_copy = {
        "scenario": "s000_surface",
        "layer": "9",
        "actor": "LE_PowerUP_Morphball",
    }
    reference_actor = editor.resolve_actor_reference(actor_to_copy)
    return reference_actor


def _create_baby_pickup(editor: PatcherEditor):
    name_of_scenario = "s100_area10"
    scenario_10 = editor.get_scenario(name_of_scenario)
    name_of_pickup = "LE_Baby_Hatchling"

    reference_actor = _get_actor(editor)

    editor.copy_actor(
        name_of_scenario, (-3400.0, 11225.0, 0.0), reference_actor, name_of_pickup, 9,
    )

    scenario_10.add_actor_to_entity_groups("collision_camera_022", name_of_pickup)

    area10 = editor.get_file("gui/minimaps/c10_samus/s100_area10.bmsmsd", Bmsmsd)
    mapicon = area10.raw["tiles"][252]
    mapicon["icons"] = ListContainer([BABY_ICON])


def patch_custom_pickups(editor: PatcherEditor):
    _create_baby_pickup(editor)
