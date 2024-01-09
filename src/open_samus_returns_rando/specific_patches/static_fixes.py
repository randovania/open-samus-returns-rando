from mercury_engine_data_structures.formats import Bmsad, Bmsbk
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
    # Power Beam: 3 (25 * 0.12)
    # Ice: 10
    # Wave: 14 (50 * 0.28)
    # Spazer: 25,2 (210 * 0.12)
    # Plasma: 36 (default of 300 * 0.12 in tunable of ridley)
    ridley_bmsad = editor.get_file("actors/characters/ridley/charclasses/ridley.bmsad", Bmsad)
    ridley_bmsad.components["LIFE"].raw["fields"]["fPowerBeamFactor"]["value"] = 0.12
    ridley_bmsad.components["LIFE"].raw["fields"]["fWaveBeamFactor"]["value"] = 0.28
    ridley_bmsad.components["LIFE"].raw["fields"]["fSpazerBeamFactor"]["value"] = 0.12


def apply_static_fixes(editor: PatcherEditor):
    patch_multi_room_gammas(editor)
    patch_pickup_rotation(editor)
    patch_pickup_position(editor)
    remove_area7_grapple_block(editor)
    patch_a7_save_screw_blocks(editor)
    shoot_supers_without_missiles(editor)
    nerf_ridley_fight(editor)
