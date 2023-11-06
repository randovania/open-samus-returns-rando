from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad

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
    # FIXME: Changing the usable to a savestation works for the hints but now the chozo seal
    # blinks with all DNA...which is maybe not really a good thing / sign?
    systemmechdna.raw["components"]["USABLE"] = save_station_bmsad.raw["components"]["USABLE"]

    # TODO: Filter the areas which really have a chozoseal instead of using all
    all_pkgs = editor.get_all_level_pkgs()
    editor.add_new_asset(
        "actors/props/chozoseal/scripts/chozoseal.lc",
        b'',
        all_pkgs
    )
    editor.replace_asset(file_name, systemmechdna)


# TODO: Remove if not required
# def test(editor: PatcherEditor):
#     # PLATFORMS = {
#     #     "s000_surface": ["LE_Platform_ChozoUnlockAreaDNA"],
#     #     "s010_area1": ["LE_Platform_ChozoUnlockAreaDNA"]
#     # }
#     SEAL = {
#        "s000_surface": ["LE_ChozoUnlockAreaDNA"]
#     }
#     TRIGGER = {
#        "s010_area1": ["TG_Activation_DNA"]
#     }
#     # for area_name, chozo_seals in PLATFORMS.items():
#     #     scenario = editor.get_scenario(area_name)
#     #     for chozo_seal in chozo_seals:
#     #         actor = scenario.raw.actors[10][chozo_seal]
#             # actor["components"][0]["arguments"][0]["value"] = False
#             # actor["components"][0]["arguments"][4]["value"] = "LE_EnergyCharge"
#             # actor["components"][0]["arguments"][5]["value"] = "usestationinit"
#             # actor["components"][0]["arguments"][5]["value"] = "useinit"
#             # actor["components"][0]["arguments"][6]["value"] = "usestationend"
#     for area_name, chozo_seals in SEAL.items():
#         scenario = editor.get_scenario(area_name)
#         for chozo_seal in chozo_seals:
#             actor = scenario.raw.actors[16][chozo_seal]
#             actor["components"][0]["arguments"][0]["value"] = 0
#             actor["components"][0]["arguments"][1]["value"] = ""
#     for area_name, chozo_seals in TRIGGER.items():
#         scenario = editor.get_scenario(area_name)
#         for chozo_seal in chozo_seals:
#             actor = scenario.raw.actors[0][chozo_seal]
#             actor["components"][0]["arguments"][8]["value"] = False

def patch_chozo_seals(editor: PatcherEditor):
    patch_dna_check(editor)
    # test(editor)
