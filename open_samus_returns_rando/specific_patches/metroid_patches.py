import logging

from construct import ListContainer
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.patcher_editor import PatcherEditor

LOG = logging.getLogger("metroid_patches")

def _patch_metroids(editor: PatcherEditor):
    METROID_FILES = [
        "actors/characters/alpha/charclasses/alpha.bmsad",
        "actors/characters/alphaevolved/charclasses/alphaevolved.bmsad",
        "actors/characters/alphanewborn/charclasses/alphanewborn.bmsad",
        "actors/characters/gamma/charclasses/gamma.bmsad",
        "actors/characters/gammaevolved/charclasses/gammaevolved.bmsad",
        "actors/characters/omega/charclasses/omega.bmsad",
        "actors/characters/omegaevolved/charclasses/omegaevolved.bmsad",
        "actors/characters/zeta/charclasses/zeta.bmsad",
        "actors/characters/zetaevolved/charclasses/zetaevolved.bmsad",
    ]

    for area_name in ALL_AREAS:
        editor.ensure_present_in_scenario(area_name, "actors/scripts/metroid.lc")

    for metroid_file in METROID_FILES:
        metroid_bmsad = editor.get_parsed_asset(metroid_file, type_hint=Bmsad)
        animations = metroid_bmsad.action_sets[0].raw["animations"]

        for animation in animations:
            events0 = animation["events0"]
            death_callbacks = [
                item
                for events in events0
                for magic_number, item in events["args"].items()
                # arguments with this number  defines the function to call
                if magic_number == 601445949
            ]
            for death_callback in death_callbacks:
                death_callback["value"] = "RemoveMetroid"

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

        # script component defines in which lua file the function names from "args" can be found
        script_component = metroid_bmsad.raw["components"]["SCRIPT"]
        script_component["functions"][0]["params"]["Param1"]["value"] = "actors/scripts/metroid.lc"
        script_component["functions"][0]["params"]["Param2"]["value"] = "Metroid"

        editor.replace_asset(metroid_file, metroid_bmsad)


def _get_trigger(editor: PatcherEditor):
    actor_to_copy = {
        "scenario": "s025_area2b",
        "layer": "0",
        "actor": "TG_SetCheckpoint_001_Gamma_001",
    }
    checkpoint_trigger = editor.resolve_actor_reference(actor_to_copy)
    return checkpoint_trigger


def _get_spawnpoint(editor: PatcherEditor):
    actor_to_copy = {
        "scenario": "s025_area2b",
        "layer": "5",
        "actor": "ST_SG_Gamma_001",
    }
    spawnpoint = editor.resolve_actor_reference(actor_to_copy)
    return spawnpoint


def _create_checkpoint_gamma_2b(editor: PatcherEditor):
    name_of_scenario = "s025_area2b"
    scenario_2b = editor.get_scenario(name_of_scenario)
    name_of_trigger = "TG_SetCheckpoint_002_Gamma_001"
    name_of_spawnpoint = "ST_SG_Gamma_001_2"
    name_of_spawnpoint_out = "ST_SG_Gamma_001_2_Out"

    trigger = _get_trigger(editor)
    spawnpoint = _get_spawnpoint(editor)

    editor.copy_actor(
        name_of_scenario, (-1650.0, -4500.0, 0.0), trigger, name_of_trigger, 0,
    )

    spawnpoint_actor = editor.copy_actor(
        name_of_scenario, (-1500.0, -4500.0, 0.0), spawnpoint, name_of_spawnpoint, 5,
    )

    editor.copy_actor(
        name_of_scenario, (-1500.0, -4500.0, 0.0), spawnpoint, name_of_spawnpoint_out, 5,
    )

    scenario_2b.add_actor_to_entity_groups("collision_camera039", name_of_trigger)
    scenario_2b.add_actor_to_entity_groups("collision_camera039", name_of_spawnpoint)
    scenario_2b.add_actor_to_entity_groups("collision_camera039", name_of_spawnpoint_out)

    trigger_actor = scenario_2b.raw.actors[0][name_of_trigger]["components"][0]["arguments"]
    trigger_actor[3]["value"] = "CurrentScenario.OnEnter_SetCheckpoint_002_Gamma_001"

    spawnpoint_actor["rotation"][1] = -90

def patch_metroids(editor: PatcherEditor):
    _patch_metroids(editor)
    _create_checkpoint_gamma_2b(editor)
