from mercury_engine_data_structures.formats import Bmsad, Bmsbk, Bmtun
from open_samus_returns_rando.patcher_editor import PatcherEditor

MULTI_ROOM_GAMMAS = [
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_A"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_Intro_A"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_B"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_Intro_B"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_A"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_Intro_A"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_C"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_Intro_C"},
    {"scenario": "s036_area3c", "layer": 4, "actor": "SP_Gamma_007_B"},
    {"scenario": "s036_area3c", "layer": 4, "actor": "SP_Gamma_007_Intro_B"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_B"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_Intro_B"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_C"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_Intro_C"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_B"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_Intro_B"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_C"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_Intro_C"},
]


def patch_multi_room_gammas(editor: PatcherEditor):
    for reference in MULTI_ROOM_GAMMAS:
        editor.remove_entity(reference)


def patch_pickup_rotation(editor: PatcherEditor):
    PICKUPS = {
        "s030_area3": ["LE_PowerUp_GrappleBeam"],
        "s050_area5": ["LE_PowerUp_SpaceJump"],
    }
    for scenario_name, pickups in PICKUPS.items():
        scenario = editor.get_scenario(scenario_name)
        for pickup in pickups:
            actor = scenario.raw.actors[9][pickup]
            actor["rotation"][1] = 0.0


def patch_pickup_position(editor: PatcherEditor):
    PICKUPS = {
        "s000_surface": ["LE_SpecialAbility_ScanningPulse"],
        "s010_area1": ["LE_PowerUp_SpiderBall"],
        "s028_area2c": ["LE_SpecialAbility_EnergyShield"],
        "s030_area3": ["LE_SpecialAbility_EnergyWave"],
        "s060_area6": ["LE_SpecialAbility_PhaseDisplacement"],
    }
    for scenario_name, pickups in PICKUPS.items():
        scenario = editor.get_scenario(scenario_name)
        for pickup in pickups:
            actor = scenario.raw.actors[9][pickup]
            if pickup != "LE_PowerUp_SpiderBall":
                actor["position"][1] -= 55.0
            else:
                actor["position"][1] -= 49.0


def remove_area7_grapple_block(editor: PatcherEditor):
    editor.remove_entity(
        {"scenario": "s090_area9", "layer": 9, "actor": "LE_GrappleDest_007"}
    )


def patch_a7_save_screw_blocks(editor: PatcherEditor):
    area7 = editor.get_file(
        "maps/levels/c10_samus/s090_area9/s090_area9.bmsbk", Bmsbk
    )
    area7.raw["block_groups"][56]["types"][0]["block_type"] = "power_beam"


def shoot_supers_without_missiles(editor: PatcherEditor):
    samus = editor.get_file(
        "actors/characters/samus/charclasses/samus.bmsad", Bmsad
    )
    gun = samus.raw["components"]["GUN"]["functions"]
    gun[20]["params"]["Param5"]["value"] = ""


def nerf_ridley_fight(editor: PatcherEditor):
    '''
    All beams (except Ice) will use the same factor as Plasma which is 0.12
    Power Beam: 25 -> 3
    Ice: 10
    Wave: 50 -> 6
    Spazer: 210 -> 25.2
    Plasma: 36 (default from ridley tunable)
    '''
    ridley_bmsad = editor.get_file("actors/characters/ridley/charclasses/ridley.bmsad", Bmsad)
    ridley_bmsad.components["LIFE"].raw["fields"]["fPowerBeamFactor"]["value"] = 0.12

    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    ridley_tunables = tunables.raw["classes"]["Ridley|CTunableCharClassRidleyAIComponent"]["tunables"]
    ridley_tunables["fPlasmaBeam"]["value"] = 1.0
    ridley_tunables["fPlasmaBeamCharge"]["value"] = 1.0
    ridley_tunables["fPlasmaBeamWeaponBoost"]["value"] = 1.1
    ridley_tunables["fPlasmaBeamWeaponBoostPhaseDisplacement"]["value"] = 1.1
    ridley_tunables["fGrabPlasmaBeam"]["value"] = 1.0
    ridley_tunables["fGrabPlasmaBeamCharge"]["value"] = 1.0
    ridley_tunables["fGrabPlasmaBeamWeaponBoost"]["value"] = 1.1
    ridley_tunables["fGrabPlasmaBeamWeaponBoostPhaseDisplacement"]["value"] = 1.1


def increase_pb_drop_chance(editor: PatcherEditor):
    ACTOR_FILES = [
        "alpha",
        "alphaevolved",
        "alphanewborn",
        "autoad",
        "autoadblack",
        "autrack",
        "autrackblack",
        "chuteleech",
        "drivel",
        "drivelstronger",
        "gamma",
        "gammaevolved",
        "gawron",
        "glowfly",
        "glowflypuzzle",
        "gravitt",
        "gravittadamant",
        "gullugg",
        "gulluggelectric",
        "gulluggstronger",
        "gunzoo",
        "halzyn",
        "hornoad",
        "hornoadstronger",
        "moheek",
        "moheekwall",
        "moto",
        "motostronger",
        "omega",
        "omegaevolved",
        "ramulken",
        "ramulkenstronger",
        "rockicicle",
        "tsumuri",
        "tsumurialternative",
        "wallfirefireball",
        "wallfirefireballblack",
        "wallfireflame",
        "wallfireflameblack",
        "zeta",
        "zetaevolved",
    ]
    for actor in ACTOR_FILES:
        actor_bmsad = editor.get_file(f"actors/characters/{actor}/charclasses/{actor}.bmsad", Bmsad)
        drop = actor_bmsad.raw["components"]["DROP"]["fields"]
        # Gamma is special as its DROP component is laid out differently
        if actor in ["gamma", "gammaevolved"]:
            drop[8]["value"]["value"] = 0.1
        # The rest of the Metroids
        elif drop["fPowerBombProbability"]["value"] == 0.0:
            drop["fPowerBombProbability"]["value"] = 0.1
        # All other enemies excluding Blobthrower
        else:
            drop["fPowerBombProbability"]["value"] *= 2


def apply_static_fixes(editor: PatcherEditor):
    patch_multi_room_gammas(editor)
    patch_pickup_rotation(editor)
    patch_pickup_position(editor)
    remove_area7_grapple_block(editor)
    patch_a7_save_screw_blocks(editor)
    shoot_supers_without_missiles(editor)
    nerf_ridley_fight(editor)
    increase_pb_drop_chance(editor)
