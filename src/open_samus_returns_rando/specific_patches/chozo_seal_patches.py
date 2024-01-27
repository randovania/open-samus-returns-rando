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


def _get_accesspoint(editor: PatcherEditor):
    accesspoint = {
        "scenario": "s000_surface",
        "layer": "16",
        "actor": "LE_ChozoUnlockAreaDNA",
    }
    ap = editor.resolve_actor_reference(accesspoint)
    return ap


def _get_accesspoint_platform(editor: PatcherEditor):
    accesspoint_platform = {
        "scenario": "s000_surface",
        "layer": "10",
        "actor": "LE_Platform_ChozoUnlockAreaDNA",
    }
    ap_platform = editor.resolve_actor_reference(accesspoint_platform)
    return ap_platform


def add_area3b_seal(editor: PatcherEditor):
    CHOZO_SEAL_ICON = Container({
        "actor_name": "LE_RandoDNA",
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer([
            -3800.0, -16800.0, 0.0
        ]),
    })

    scenario = "s033_area3b"
    area3b = editor.get_scenario(scenario)
    ap = "LE_RandoDNA"
    ap_platform = "LE_Platform_RandoDNA"

    accesspoint = _get_accesspoint(editor)
    accesspoint_platform = _get_accesspoint_platform(editor)

    editor.copy_actor(
        scenario, (-3800.0, -16800.0, 0.0), accesspoint, ap, 16,
    )

    editor.copy_actor(
        scenario, (-3800.0, -16800.0, 0.0), accesspoint_platform, ap_platform, 10,
    )

    area3b.add_actor_to_entity_groups("collision_camera_033", ap)
    area3b.add_actor_to_entity_groups("PostGamma_004", ap)
    area3b.add_actor_to_entity_groups("collision_camera_033", ap_platform)
    area3b.add_actor_to_entity_groups("PostGamma_004", ap_platform)

    area3b.raw.actors[10][ap_platform]["components"][0]["arguments"][4]["value"] = ap

    area3b_map = editor.get_file("gui/minimaps/c10_samus/s033_area3b.bmsmsd", Bmsmsd)
    area3b_map.raw["tiles"][22]["icons"] = ListContainer([CHOZO_SEAL_ICON])


def add_area5_seal(editor: PatcherEditor):
    CHOZO_SEAL_ICON = Container({
        "actor_name": "LE_RandoDNA",
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer([
            12250.0, 6700.0, 0.0
        ]),
    })

    scenario = "s050_area5"
    area5 = editor.get_scenario(scenario)
    ap = "LE_RandoDNA"
    ap_platform = "LE_Platform_RandoDNA"

    accesspoint = _get_accesspoint(editor)
    accesspoint_platform = _get_accesspoint_platform(editor)

    editor.copy_actor(
        scenario, (12250.0, 6700.0, 20.0), accesspoint, ap, 16,
    )

    editor.copy_actor(
        scenario, (12250.0, 6700.0, 0.0), accesspoint_platform, ap_platform, 10,
    )

    area5.add_actor_to_entity_groups("collision_camera_017", ap, True)
    area5.add_actor_to_entity_groups("017_PostGamma_002", ap, True)
    area5.add_actor_to_entity_groups("PostGamma_002", ap, True)
    area5.add_actor_to_entity_groups("collision_camera_017", ap_platform, True)
    area5.add_actor_to_entity_groups("017_PostGamma_002", ap_platform, True)
    area5.add_actor_to_entity_groups("PostGamma_002", ap_platform, True)

    area5.raw.actors[10][ap_platform]["components"][0]["arguments"][4]["value"] = ap

    area5_map = editor.get_file("gui/minimaps/c10_samus/s050_area5.bmsmsd", Bmsmsd)
    area5_map.raw["tiles"][238]["icons"] = ListContainer([CHOZO_SEAL_ICON])


def add_area6b_seal(editor: PatcherEditor):
    CHOZO_SEAL_ICON = Container({
        "actor_name": "LE_RandoDNA",
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer([
            500.0, 5700.0, 0.0
        ]),
    })

    scenario = "s065_area6b"
    area6b = editor.get_scenario(scenario)
    ap = "LE_RandoDNA"
    ap_platform = "LE_Platform_RandoDNA"

    accesspoint = _get_accesspoint(editor)
    accesspoint_platform = _get_accesspoint_platform(editor)

    editor.copy_actor(
        scenario, (500.0, 5700.0, 25.0), accesspoint, ap, 16,
    )

    editor.copy_actor(
        scenario, (500.0, 5700.0, 0.0), accesspoint_platform, ap_platform, 10,
    )

    area6b.add_actor_to_entity_groups("collision_camera_002", ap, True)
    area6b.add_actor_to_entity_groups("collision_camera_002", ap_platform, True)

    area6b.raw.actors[10][ap_platform]["components"][0]["arguments"][4]["value"] = ap

    area6b_map = editor.get_file("gui/minimaps/c10_samus/s065_area6b.bmsmsd", Bmsmsd)
    area6b_map.raw["tiles"][217]["icons"] = ListContainer([CHOZO_SEAL_ICON])


def add_area10_1_seal(editor: PatcherEditor):
    CHOZO_SEAL_ICON = Container({
        "actor_name": "LE_RandoDNA_001",
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer([
            -1000.0, -5125.0, 0.0
        ]),
    })

    scenario = "s100_area10"
    area10 = editor.get_scenario(scenario)
    ap = "LE_RandoDNA_001"
    ap_platform = "LE_Platform_RandoDNA_001"

    accesspoint = _get_accesspoint(editor)
    accesspoint_platform = _get_accesspoint_platform(editor)

    editor.copy_actor(
        scenario, (-1000.0, -5100.0, 0.0), accesspoint, ap, 16,
    )

    editor.copy_actor(
        scenario, (-1000.0, -5100.0, 0.0), accesspoint_platform, ap_platform, 10,
    )

    area10.add_actor_to_entity_groups("collision_camera_010", ap, True)
    area10.add_actor_to_entity_groups("collision_camera_010", ap_platform, True)

    area10.raw.actors[10][ap_platform]["components"][0]["arguments"][4]["value"] = ap

    area10_map = editor.get_file("gui/minimaps/c10_samus/s100_area10.bmsmsd", Bmsmsd)
    area10_map.raw["tiles"][94]["icons"] = ListContainer([CHOZO_SEAL_ICON])


def add_area10_2_seal(editor: PatcherEditor):
    CHOZO_SEAL_ICON = Container({
        "actor_name": "LE_RandoDNA_002",
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer([
            -4100.0, 11200.0, 0.0
        ]),
    })

    scenario = "s100_area10"
    area10 = editor.get_scenario(scenario)
    ap = "LE_RandoDNA_002"
    ap_platform = "LE_Platform_RandoDNA_002"

    accesspoint = _get_accesspoint(editor)
    accesspoint_platform = _get_accesspoint_platform(editor)

    editor.copy_actor(
        scenario, (-4100.0, 11200.0, 10.0), accesspoint, ap, 16,
    )

    editor.copy_actor(
        scenario, (-4100.0, 11200.0, 0.0), accesspoint_platform, ap_platform, 10,
    )

    area10.add_actor_to_entity_groups("collision_camera_022", ap)
    area10.add_actor_to_entity_groups("collision_camera_024", ap)
    area10.add_actor_to_entity_groups("collision_camera_022", ap_platform)
    area10.add_actor_to_entity_groups("collision_camera_024", ap_platform)

    area10.raw.actors[10][ap_platform]["components"][0]["arguments"][4]["value"] = ap

    area10_map = editor.get_file("gui/minimaps/c10_samus/s100_area10.bmsmsd", Bmsmsd)
    area10_map.raw["tiles"][253]["icons"] = ListContainer([CHOZO_SEAL_ICON])


def add_surfaceb_seal(editor: PatcherEditor):
    CHOZO_SEAL_ICON = Container({
        "actor_name": "LE_RandoDNA",
        "clear_condition": "",
        "icon": "systemmechdna",
        "icon_priority": 4,
        "coordinates": ListContainer([
            -28150.0, 300.0, 0.0
        ]),
    })

    scenario = "s110_surfaceb"
    surfaceb = editor.get_scenario(scenario)
    ap = "LE_RandoDNA"
    ap_platform = "LE_Platform_RandoDNA"

    accesspoint = _get_accesspoint(editor)
    accesspoint_platform = _get_accesspoint_platform(editor)

    editor.copy_actor(
        scenario, (-28150.0, 300.0, 0.0), accesspoint, ap, 16,
    )

    editor.copy_actor(
        scenario, (-28150.0, 300.0, 0.0), accesspoint_platform, ap_platform, 10,
    )

    surfaceb.add_actor_to_entity_groups("collision_camera_017", ap)
    surfaceb.add_actor_to_entity_groups("collision_camera_017", ap_platform)

    surfaceb.raw.actors[10][ap_platform]["components"][0]["arguments"][4]["value"] = ap

    surface_map = editor.get_file("gui/minimaps/c10_samus/s000_surface.bmsmsd", Bmsmsd)
    surface_map.raw["tiles"][145]["icons"] = ListContainer([CHOZO_SEAL_ICON])


def ensure_dependencies(editor: PatcherEditor) -> None:
    SCENARIOS = [
        "s033_area3b",
        "s050_area5",
        "s065_area6b",
        "s100_area10",
        "s110_surfaceb",
    ]
    for scenario in SCENARIOS:
        editor.ensure_present_in_scenario(scenario, "maps/textures/dnaemptyfx_d.bctex")
        for asset in editor.get_asset_names_in_folder("actors/props/systemmechdna"):
            editor.ensure_present_in_scenario(scenario, asset)


def patch_chozo_seals(editor: PatcherEditor):
    patch_dna_check(editor)
    ensure_dependencies(editor)
    add_area3b_seal(editor)
    add_area5_seal(editor)
    add_area6b_seal(editor)
    add_area10_1_seal(editor)
    add_area10_2_seal(editor)
    add_surfaceb_seal(editor)
