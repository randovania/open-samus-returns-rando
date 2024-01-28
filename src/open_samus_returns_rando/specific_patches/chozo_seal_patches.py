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
    systemmechdna = editor.get_parsed_asset(
        file_name, type_hint=Bmsad
    )
    save_station_bmsad = editor.get_parsed_asset(
        save_station_name, type_hint=Bmsad
    )

    systemmechdna.raw["components"]["SCRIPT"] = SCRIPT_COMPONENT
    # Changing the usable to a savestation works for the hints but now the chozo seal
    # blinks with all DNA. Looks like it is no problem besides the visual aspect
    systemmechdna.raw["components"]["USABLE"] = save_station_bmsad.raw["components"]["USABLE"]

    editor.replace_asset(file_name, systemmechdna)


def add_chozo_seals(editor: PatcherEditor):
    SCENARIOS = {
        "s033_area3b": [[-3800.0, -16800.0, 0.0]],
        "s050_area5": [[12250.0, 6700.0, 0.0]],
        "s065_area6b": [[-300.0, 5700.0, 0.0]],
        "s100_area10": [[-1000.0, -5100.0, 0.0], [-4100.0, 11200.0, 0.0]],
        "s110_surfaceb": [[-28150.0, 300.0, 0.0]],
    }
    for scenario, actor_coordinates in SCENARIOS.items():
        template_ap = editor.get_scenario("s000_surface").raw.actors[16]["LE_ChozoUnlockAreaDNA"]
        template_platform = editor.get_scenario("s000_surface").raw.actors[10]["LE_Platform_ChozoUnlockAreaDNA"]

        scenario_name = scenario
        scenario_file = editor.get_scenario(scenario_name)

        if scenario == "s110_surfaceb":
            scenario_map = editor.get_file("gui/minimaps/c10_samus/s000_surface.bmsmsd", Bmsmsd)
        else:
            scenario_map = editor.get_file(f"gui/minimaps/c10_samus/{scenario}.bmsmsd", Bmsmsd)

        # Dependencies
        editor.ensure_present_in_scenario(scenario, "maps/textures/dnaemptyfx_d.bctex")
        for asset in editor.get_asset_names_in_folder("actors/props/systemmechdna"):
            editor.ensure_present_in_scenario(scenario, asset)

        if scenario != "s100_area10":
            new_ap = "LE_RandoDNA"
            new_platform = "LE_Platform_RandoDNA"
            for position in actor_coordinates:
                coordinates = position
                CHOZO_SEAL_ICON = Container({
                    "actor_name": "LE_RandoDNA",
                    "clear_condition": "",
                    "icon": "systemmechdna",
                    "icon_priority": 4,
                    "coordinates": ListContainer(coordinates),
                })
                editor.copy_actor(scenario, coordinates, template_platform, new_platform, 10)
                # Scenarios that need to adjust the position of the Chozo Seal are listed first
                if scenario == "s050_area5":
                    editor.copy_actor(scenario, (12250.0, 6700.0, 20.0), template_ap, new_ap, 16)
                elif scenario == "s065_area6b":
                    editor.copy_actor(scenario, (-300.0, 5700.0, 25.0), template_ap, new_ap, 16)
                else:
                    editor.copy_actor(scenario, coordinates, template_ap, new_ap, 16)

                scenario_file.raw.actors[10][new_platform]["components"][0]["arguments"][4]["value"] = new_ap

                if scenario == "s033_area3b":
                    scenario_map.raw["tiles"][22]["icons"] = ListContainer([CHOZO_SEAL_ICON])
                    scenario_file.add_actor_to_entity_groups("collision_camera_033", new_ap)
                    scenario_file.add_actor_to_entity_groups("PostGamma_004", new_ap)
                    scenario_file.add_actor_to_entity_groups("collision_camera_033", new_platform)
                    scenario_file.add_actor_to_entity_groups("PostGamma_004", new_platform)
                if scenario == "s050_area5":
                    scenario_map.raw["tiles"][238]["icons"] = ListContainer([CHOZO_SEAL_ICON])
                    scenario_file.add_actor_to_entity_groups("collision_camera_017", new_ap, True)
                    scenario_file.add_actor_to_entity_groups("017_PostGamma_002", new_ap, True)
                    scenario_file.add_actor_to_entity_groups("PostGamma_002", new_ap, True)
                    scenario_file.add_actor_to_entity_groups("collision_camera_017", new_platform, True)
                    scenario_file.add_actor_to_entity_groups("017_PostGamma_002", new_platform, True)
                    scenario_file.add_actor_to_entity_groups("PostGamma_002", new_platform, True)
                if scenario == "s065_area6b":
                    scenario_map.raw["tiles"][216]["icons"] = ListContainer([CHOZO_SEAL_ICON])
                    scenario_file.add_actor_to_entity_groups("collision_camera_002", new_ap, True)
                    scenario_file.add_actor_to_entity_groups("collision_camera_002", new_platform, True)
                if scenario == "s110_surfaceb":
                    scenario_map.raw["tiles"][145]["icons"] = ListContainer([CHOZO_SEAL_ICON])
                    scenario_file.add_actor_to_entity_groups("collision_camera_017", new_ap)
                    scenario_file.add_actor_to_entity_groups("collision_camera_017", new_platform)
        else:
            # Area 8 is separate due to having two new seals
            new_ap_001 = "LE_RandoDNA_001"
            new_platform_001 = "LE_Platform_RandoDNA_001"
            new_ap_002 = "LE_RandoDNA_002"
            new_platform_002 = "LE_Platform_RandoDNA_002"

            coordinates_001 = actor_coordinates[0]
            coordinates_002 = actor_coordinates[1]

            editor.copy_actor(scenario, (-1000.0, -5125.0, 0.0), template_ap, new_ap_001, 16)
            editor.copy_actor(scenario, coordinates_001, template_platform, new_platform_001, 10)
            editor.copy_actor(scenario, coordinates_002, template_ap, new_ap_002, 16)
            editor.copy_actor(scenario, coordinates_002, template_platform, new_platform_002, 10)

            scenario_file.raw.actors[10][new_platform_001]["components"][0]["arguments"][4]["value"] = new_ap_001
            scenario_file.raw.actors[10][new_platform_002]["components"][0]["arguments"][4]["value"] = new_ap_002

            scenario_file.add_actor_to_entity_groups("collision_camera_010", new_ap_001, True)
            scenario_file.add_actor_to_entity_groups("collision_camera_010", new_platform_001, True)
            scenario_file.add_actor_to_entity_groups("collision_camera_022", new_ap_002)
            scenario_file.add_actor_to_entity_groups("collision_camera_024", new_ap_002)
            scenario_file.add_actor_to_entity_groups("collision_camera_022", new_platform_002)
            scenario_file.add_actor_to_entity_groups("collision_camera_024", new_platform_002)

            scenario_map.raw["tiles"][94]["icons"] = ListContainer([
                Container({
                    "actor_name": "LE_RandoDNA_001",
                    "clear_condition": "",
                    "icon": "systemmechdna",
                    "icon_priority": 4,
                    "coordinates": ListContainer(coordinates_001),
                })
            ])

            scenario_map.raw["tiles"][253]["icons"] = ListContainer([
                Container({
                    "actor_name": "LE_RandoDNA_002",
                    "clear_condition": "",
                    "icon": "systemmechdna",
                    "icon_priority": 4,
                    "coordinates": ListContainer(coordinates_002),
                })
            ])


def patch_chozo_seals(editor: PatcherEditor):
    patch_dna_check(editor)
    add_chozo_seals(editor)
