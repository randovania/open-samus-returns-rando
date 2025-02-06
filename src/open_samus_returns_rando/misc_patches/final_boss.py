import typing

from construct import Container  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsad, Bmtun

from open_samus_returns_rando.patcher_editor import PatcherEditor


class BossTrigger(typing.NamedTuple):
    scenario: str
    name: str
    position: list[float]
    size: list[float]
    entity_groups: list[str]


boss_triggers = [
    BossTrigger(
        "s070_area7", "TG_Diggernaut_Access", [-20900.0, -7700.0, 0.0], [50, 700, 300], ["collision_camera_045"]
    ),
    BossTrigger(
        "s070_area7",
        "TG_SetCheckpoint_002_ManicMiner",
        [-21450.0, -7600.0, 0.0],
        [50, 700, 300],
        ["collision_camera_045"],
    ),
    BossTrigger("s100_area10", "TG_Queen_Access", [1000.0, 12050.0, 0.0], [500, 300, 300], ["PostMetroids_001"]),
]

ridley_trigger = BossTrigger(
    "s110_surfaceb", "TG_Ridley_Access", [-22800.0, 4400.0, 0.0], [150, 800, 800], ["collision_camera_017"]
)


def add_boss_triggers(editor: PatcherEditor, boss_trigger: BossTrigger) -> None:
    template_tg = editor.get_scenario("s110_surfaceb").raw.actors[0]["TG_Activation_Teleport_00b_01"]

    scenario_name = boss_trigger.scenario
    scenario_file = editor.get_scenario(scenario_name)

    editor.copy_actor(scenario_name, boss_trigger.position, template_tg, boss_trigger.name, 0)

    arguments = scenario_file.raw.actors[0][boss_trigger.name]["components"][0]["arguments"]
    arguments[3]["value"] = "CurrentScenario.OnEnter_" + boss_trigger.name[3:]
    # Set the size of the trigger to fill the opening
    arguments[16]["value"] = boss_trigger.size[0]
    arguments[17]["value"] = boss_trigger.size[1]
    arguments[18]["value"] = boss_trigger.size[2]

    for entity_group in boss_trigger.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, boss_trigger.name, True)


def patch_final_boss(editor: PatcherEditor, configuration: dict) -> None:
    final_boss = configuration["objective"]["final_boss"]
    game_patches = configuration["game_patches"]

    # Always add the trigger for Ridley
    add_boss_triggers(editor, ridley_trigger)

    if final_boss != "Ridley":
        # Add the trigger that corresponds with the final boss
        for boss_trigger in boss_triggers:
            add_boss_triggers(editor, boss_trigger)
        if final_boss == "Arachnus":
            # Buff Arachnus so the fight isn't trivial
            arachnus = editor.get_file("actors/characters/arachnus/charclasses/arachnus.bmsad", Bmsad)
            bmsad_life = arachnus.raw["components"]["LIFE"]["fields"]
            # Disable Power Bombs because of the instant kill
            bmsad_life["bShouldDieWithPowerBomb"] = Container({"type": "bool", "value": False})

            '''All beams (except Ice) will use the same factor of 0.33 for balancing with the new health
            Power Beam: 25 -> 8.25
            Ice: 10
            Wave: 50 -> 16.5
            Spazer: 210 -> 69.3
            Plasma: 300 -> 99
            '''
            bmsad_life["fPowerBeamFactor"]["value"] = 0.33
            # 1000 -> 500
            bmsad_life["fScrewAttackFactor"]["value"] = 0.5

            tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
            damage = tunables.raw["classes"]["Damage|CTunableCharClassAttackComponent"]["tunables"]
            # 50 -> 150
            damage["fDamageArachnusDefault"]["value"] *= 3
            damage["fDamageArachnusEnergyWave"]["value"] *= 3
            damage["fDamageArachnusFireSplash"]["value"] *= 3

            tunables_life = tunables.raw["classes"]["Life|CTunableCharClassAIComponent"]["tunables"]
            # Original health is 3000
            tunables_life["fLifeArachnus"]["value"] = 10000
        elif final_boss == "Diggernaut":
            # Move the grapple block by the elevator regardless if the grapple config is set
            if not game_patches["remove_elevator_grapple_blocks"]:
                scenario = editor.get_scenario("s070_area7")
                scenario.raw.actors[9]["LE_GrappleMov_001"]["position"][0] = -15250.0
            # Remove the breakable Grapple block to allow access to Diggernaut backwards
            editor.remove_entity({"scenario": "s070_area7", "layer": 9, "actor": "LE_GrappleDest_012"})
        elif final_boss == "Queen":
            # Remove the Queen wall regardless if the config is set
            if not game_patches["reverse_area8"]:
                editor.remove_entity({"scenario": "s100_area10", "layer": 9, "actor": "LE_ValveQueen"})
