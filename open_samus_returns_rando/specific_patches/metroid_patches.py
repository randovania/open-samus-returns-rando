
import logging

from construct import ListContainer
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.patcher_editor import PatcherEditor

LOG = logging.getLogger("metroid_patches")

def patch_metroids(editor: PatcherEditor):
    METROID_DICTS = [
        {
            "file": "actors/characters/alpha/charclasses/alpha.bmsad",
            "death_index": 22,
            "function_index": 3
        },
        {
            "file": "actors/characters/alphaevolved/charclasses/alphaevolved.bmsad",
            "death_index": 22,
            "function_index": 3
        },
        {
            "file": "actors/characters/alphanewborn/charclasses/alphanewborn.bmsad",
            "death_index": 22,
            "function_index": 3
        },
        {
            "file": "actors/characters/gamma/charclasses/gamma.bmsad",
            "death_index": 54,
            "function_index": 16
        },
        {
            "file": "actors/characters/gammaevolved/charclasses/gammaevolved.bmsad",
            "death_index": 54,
            "function_index": 16
        },
        {
            "file": "actors/characters/omega/charclasses/omega.bmsad",
            "death_index": 74,
            "function_index": 13
        },
        {
            "file": "actors/characters/omegaevolved/charclasses/omegaevolved.bmsad",
            "death_index": 74,
            "function_index": 13
        },
        {
            "file": "actors/characters/zeta/charclasses/zeta.bmsad",
            "death_index": 56,
            "function_index": 9
        },
        {
            "file": "actors/characters/zetaevolved/charclasses/zetaevolved.bmsad",
            "death_index": 56,
            "function_index": 9
        },
    ]

    for area_name in ALL_AREAS:
        editor.ensure_present_in_scenario(area_name, "actors/scripts/metroid.lc")

    for metroid_dict in METROID_DICTS:
        metroid_file = metroid_dict["file"]
        death_index = metroid_dict["death_index"]
        function_index = metroid_dict["function_index"]

        metroid_bmsad = editor.get_parsed_asset(metroid_file, type_hint=Bmsad)
        action_set_anim = metroid_bmsad.action_sets[0].raw["animations"][death_index]
        action_set_anim["events0"][function_index]["args"][601445949]["value"] = "RemoveMetroid"

        drop_component = metroid_bmsad.raw["components"]["DROP"]
        # weird case where some fields are defined two times
        if type(drop_component["fields"]) == ListContainer:
            drop_component["fields"][0]["value"]["value"] = 0.0
        else:
            drop_component["fields"]["fADNProbability"]["value"] = 0.0

        ai_component = metroid_bmsad.raw["components"]["AI"]
        # weird case where some fields are defined two times
        if type(ai_component["fields"]) == ListContainer:
            ai_component["fields"][94]["value"]["value"] = False
            ai_component["fields"][95]["value"]["value"] = False
        else:
            ai_component["fields"]["bRemovePlayerInputOnDeath"]["value"] = False
            ai_component["fields"]["bSetPlayerInvulnerableWithReactionOnDeath"]["value"] = False


        script_component = metroid_bmsad.raw["components"]["SCRIPT"]
        script_component["functions"][0]["params"]["Param1"]["value"] = "actors/scripts/metroid.lc"
        script_component["functions"][0]["params"]["Param2"]["value"] = "Metroid"

        editor.replace_asset(metroid_file, metroid_bmsad)
