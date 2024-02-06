import typing

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad, Bmsmsd
from open_samus_returns_rando.patcher_editor import PatcherEditor

SCRIPT_COMPONENT = Container({
    "type": "CScriptComponent",
    "unk_1": 3000,
    "unk_2": -1.0,
    "functions": ListContainer([
        Container({
            "name": "SetParams",
            "unk1": True,
            "unk2": False,
            "params": Container({
                "Param1": Container({
                    "type": "s",
                    "value": "actors/props/chozoseal/scripts/chozoseal.lua",
                }),
                "Param2": Container({
                    "type" :"s",
                    "value":"ChozoSeal",
                }),
            }),
        }),
    ]),
    "fields": Container(),
    "dependencies": None,
})


def patch_dna_check(editor: PatcherEditor):
    file_name = "actors/props/systemmechdna/charclasses/systemmechdna.bmsad"
    save_station_name = "actors/props/savestation/charclasses/savestation.bmsad"
    systemmechdna = editor.get_file(file_name, Bmsad)
    save_station_bmsad = editor.get_file(save_station_name, Bmsad)

    systemmechdna.raw["components"]["SCRIPT"] = SCRIPT_COMPONENT
    # Changing the usable to a savestation works for the hints but now the chozo seal
    # blinks with all DNA. Looks like it is no problem besides the visual aspect
    systemmechdna.raw["components"]["USABLE"] = save_station_bmsad.raw["components"]["USABLE"]


class NewChozoSeal(typing.NamedTuple):
    scenario: str
    ap_coordinates: list[float]
    platform_coordinates: list[float]
    tile_index: int
    entity_groups: list[str]
    ap_name: str = "LE_RandoDNA"
    platform_name: str = "LE_Platform_RandoDNA"

new_seals = [
    NewChozoSeal(
        "s010_area1", [450.0, -700.0, 0.0], [450.0, -700.0, 0.0], 28, ["collision_camera_023"]
    ),
    NewChozoSeal(
        "s020_area2", [-10900.0, -8210.0, 0.0], [-10900.0, -8200.0, 0.0], 20, ["collision_camera_032"]
    ),
    NewChozoSeal(
        "s033_area3b", [-3800.0, -16800.0, 0.0], [-3800.0, -16800.0, 0.0], 22, ["collision_camera_033", "PostGamma_004"]
    ),
    NewChozoSeal(
        "s050_area5", [12250.0, 6700.0, 20.0], [12250.0, 6700.0, 0.0], 238,
        ["collision_camera_017", "017_PostGamma_002", "PostGamma_002"]
    ),
    NewChozoSeal(
        "s065_area6b", [-300.0, 5700.0, 25.0], [-300.0, 5700.0, 0.0], 216, ["collision_camera_002"]
    ),
    NewChozoSeal(
        "s070_area7", [-7100.0, -9550.0, 0.0], [-7100.0, -9500.0, 0.0], 12,
        ["collision_camera_042"], "LE_RandoDNA_001", "LE_Platform_RandoDNA_001"
    ),
    NewChozoSeal(
        "s070_area7", [-6550.0, 6900.0, 0.0], [-6550.0, 6900.0, 0.0], 304,
        ["collision_camera_038"], "LE_RandoDNA_002", "LE_Platform_RandoDNA_002"
    ),
    NewChozoSeal(
        "s090_area9", [-5550.0, -3000.0, 0.0], [-5550.0, -3000.0, 0.0], 206, ["collision_camera_016"]
    ),
    NewChozoSeal(
        "s100_area10", [-4100.0, 11200.0, 0.0], [-4100.0, 11200.0, 0.0], 253,
        ["collision_camera_022", "collision_camera_024"]
    ),
    # Currently breaks Ridley if added :(
    # NewChozoSeal(
    #     "s110_surfaceb", [-28150.0, 300.0, 0.0], [-28150.0, 300.0, 0.0], 145, ["collision_camera_017"]
    # ),
]

def add_chozo_seals(editor: PatcherEditor, new_seal: NewChozoSeal):
    template_ap = editor.get_scenario("s000_surface").raw.actors[16]["LE_ChozoUnlockAreaDNA"]
    template_platform = editor.get_scenario("s000_surface").raw.actors[10]["LE_Platform_ChozoUnlockAreaDNA"]

    CHOZO_SEAL_ICON = Container({
        "actor_name": new_seal.ap_name,
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer(new_seal.ap_coordinates),
    })

    scenario_name = new_seal.scenario
    scenario_file = editor.get_scenario(scenario_name)

    editor.copy_actor(scenario_name, new_seal.ap_coordinates, template_ap, new_seal.ap_name, 16)
    editor.copy_actor(scenario_name, new_seal.platform_coordinates, template_platform, new_seal.platform_name, 10)
    scenario_file.raw.actors[10][new_seal.platform_name]["components"][0]["arguments"][4]["value"] = new_seal.ap_name

    if scenario_name == "s110_surfaceb":
        scenario_map = editor.get_file("gui/minimaps/c10_samus/s000_surface.bmsmsd", Bmsmsd)
    else:
        scenario_map = editor.get_file(f"gui/minimaps/c10_samus/{scenario_name}.bmsmsd", Bmsmsd)

    scenario_map.raw["tiles"][new_seal.tile_index]["icons"] = ListContainer([CHOZO_SEAL_ICON])

    for entity_group in new_seal.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, new_seal.ap_name, True)
        scenario_file.add_actor_to_entity_groups(entity_group, new_seal.platform_name, True)

    # Dependencies
    editor.ensure_present_in_scenario(scenario_name, "maps/textures/dnaemptyfx_d.bctex")
    for asset in editor.get_asset_names_in_folder("actors/props/systemmechdna"):
        editor.ensure_present_in_scenario(scenario_name, asset)


def patch_chozo_seals(editor: PatcherEditor):
    patch_dna_check(editor)
    for new_seal in new_seals:
        add_chozo_seals(editor, new_seal)
