import typing

from construct import ListContainer  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsad
from open_samus_returns_rando.patcher_editor import PatcherEditor


def _patch_metroids(editor: PatcherEditor) -> None:
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

    for metroid_file in METROID_FILES:
        metroid_bmsad = editor.get_file(metroid_file, Bmsad)
        animations = metroid_bmsad.action_sets[0].raw["animations"]

        for animation in animations:
            events0 = animation["events0"]
            death_callbacks = [
                item
                for events in events0
                for parameter_name, item in events["args"].items()
                # check if this event defines a CallbackName
                if parameter_name == "CallbackName"
            ]
            for death_callback in death_callbacks:
                death_callback["value"] = "RemoveMetroid"

        drop_component = metroid_bmsad.raw["components"]["DROP"]
        # weird case where some fields are defined two times
        if type(drop_component["fields"]) is ListContainer:
            drop_component["fields"][0]["value"]["value"] = 0.0
        else:
            drop_component["fields"]["fADNProbability"]["value"] = 0.0

        ai_component = metroid_bmsad.raw["components"]["AI"]
        # weird case where some fields are defined two times
        if type(ai_component["fields"]) is ListContainer:
            ai_component["fields"][94]["value"]["value"] = False
        else:
            ai_component["fields"]["bRemovePlayerInputOnDeath"]["value"] = False

        # script component defines in which lua file the function names from "args" can be found
        script_component = metroid_bmsad.raw["components"]["SCRIPT"]
        script_component["functions"][0]["params"]["Param1"]["value"] = "actors/scripts/metroid.lc"
        script_component["functions"][0]["params"]["Param2"]["value"] = "Metroid"


class NewStartPoint(typing.NamedTuple):
    scenario: str
    tg_name: str | None
    tg_position: list[float] | None
    st_name: str | None
    st_position: list[float]
    st_rotation: int
    st_out_name: str | None
    entity_groups: list[str]


new_startpoints = [
    NewStartPoint(
        "s000_surface", "TG_SetCheckpoint_002_Alpha_001", [-1350.0, -10200.0, 0.0],
        "ST_SG_Alpha_001B", [-953.0, -9790.0, 0.0], -90, None, ["collision_camera_024"]
    ),
    NewStartPoint(
        "s020_area2", "TG_SetCheckpoint_002_Alpha_003", [-18550.0, -6100.0, 0.0],
        "ST_SG_Alpha_003B", [-18800.0, -6100.0, 0.0], 90, "ST_SG_Alpha_003B_Out", ["collision_camera_028"]
    ),
    NewStartPoint(
        "s025_area2b", "TG_SetCheckpoint_002_Gamma_001", [-1800.0, -4500.0, 0.0],
        "ST_SG_Gamma_001B", [-1550.0, -4500.0, 0.0], -90, "ST_SG_Gamma_001B_Out", ["collision_camera039"]
    ),
    NewStartPoint(
        "s060_area6", "TG_SetCheckpoint_002_Alpha_001", [3100.0, -6100.0, 0.0],
        "ST_SG_Alpha_001B", [2850.0, -6100.0, 0.0], 90, "ST_SG_Alpha_001B_Out", ["collision_camera_015"]
    ),
    NewStartPoint(
        "s070_area7", "TG_SetCheckpoint_002_Zeta_001", [6600.0, 7500.0, 0.0],
        "ST_SG_Zeta_001B", [6850.0, 7500.0, 0.0], -90, "ST_SG_Zeta_001B_Out", ["collision_camera_040"]
    ),
    NewStartPoint(
        "s070_area7", None, None,
        None, [2400.0, 7600.0, 0.0], 90, "ST_SG_Omega_001_Out", ["collision_camera_047"]
    ),
    NewStartPoint(
        "s070_area7", "TG_SetCheckpoint_002_Omega_001", [-2000.0, 7500.0, 0.0],
        "ST_SG_Omega_001B", [-2250.0, 7500.0, 0.0], 90, "ST_SG_Omega_001B_Out", ["collision_camera_046"]
    ),
    NewStartPoint(
        "s070_area7", "TG_SetCheckpoint_003_Omega_001", [-1025.0, 9700.0, 0.0],
        "ST_SG_Omega_001C", [-1025.0, 9700.0, 0.0], -90, None, ["collision_camera_061"]
    ),
]


def add_startpoints(editor: PatcherEditor, new_startpoint: NewStartPoint)  -> None:
    template_tg = editor.get_scenario("s025_area2b").raw.actors[0]["TG_SetCheckpoint_001_Gamma_001"]
    template_st = editor.get_scenario("s025_area2b").raw.actors[5]["ST_SG_Gamma_001"]

    scenario_name = new_startpoint.scenario
    scenario_file = editor.get_scenario(scenario_name)

    # Copy the actors
    if new_startpoint.tg_name is not None and new_startpoint.tg_position is not None :
        editor.copy_actor(scenario_name, new_startpoint.tg_position, template_tg, new_startpoint.tg_name, 0)
    if new_startpoint.st_name is not None:
        editor.copy_actor(scenario_name, new_startpoint.st_position, template_st, new_startpoint.st_name, 5)
    if new_startpoint.st_out_name is not None:
        editor.copy_actor(scenario_name, new_startpoint.st_position, template_st, new_startpoint.st_out_name, 5)

    # Add to the entity groups
    for entity_group in new_startpoint.entity_groups:
        for actor in [new_startpoint.tg_name, new_startpoint.st_name, new_startpoint.st_out_name]:
            if actor is not None:
                scenario_file.add_actor_to_entity_groups(entity_group, actor, True)

    # Rotate the startpoint actors
    if new_startpoint.st_name is not None:
        scenario_file.raw.actors[5][new_startpoint.st_name]["rotation"][1] = new_startpoint.st_rotation
        if new_startpoint.st_out_name is not None:
            scenario_file.raw.actors[5][new_startpoint.st_out_name]["rotation"][1] = (
                -90 if new_startpoint.st_rotation == 90 else 90
            )
    # Edge case where startpoint actors aren't being added but startpoint_out actors are
    if new_startpoint.st_out_name == "ST_SG_Omega_001_Out":
        scenario_file.raw.actors[5][new_startpoint.st_out_name]["rotation"][1] = new_startpoint.st_rotation

    # Update the trigger actor
    if new_startpoint.tg_name is not None:
        scenario_file.raw.actors[0][new_startpoint.tg_name]["components"][0][
            "arguments"
        ][3]["value"] = ("CurrentScenario.OnEnter_" + new_startpoint.tg_name[3:])


def patch_metroids(editor: PatcherEditor) -> None:
    _patch_metroids(editor)
    for new_startpoint in new_startpoints:
        add_startpoints(editor, new_startpoint)
