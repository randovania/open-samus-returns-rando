import copy
import typing

from construct import Container, ListContainer  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsad, Bmsbk, Bmscc, Bmssd, Bmtun
from open_samus_returns_rando.patcher_editor import PatcherEditor

MULTI_ROOM_GAMMAS = [
    {"scenario": "s030_area3", "layer": 0, "actor": "TG_Gamma_005_A"},
    {"scenario": "s030_area3", "layer": 3, "actor": "SG_Gamma_005_A"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_A"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_Intro_A"},
    {"scenario": "s030_area3", "layer": 0, "actor": "TG_Gamma_005_B"},
    {"scenario": "s030_area3", "layer": 3, "actor": "SG_Gamma_005_B"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_B"},
    {"scenario": "s030_area3", "layer": 4, "actor": "SP_Gamma_005_Intro_B"},
    {"scenario": "s033_area3b", "layer": 0, "actor": "TG_Gamma_004_A"},
    {"scenario": "s033_area3b", "layer": 3, "actor": "SG_Gamma_004_A"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_A"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_Intro_A"},
    {"scenario": "s033_area3b", "layer": 0, "actor": "TG_Gamma_004_C"},
    {"scenario": "s033_area3b", "layer": 3, "actor": "SG_Gamma_004_C"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_C"},
    {"scenario": "s033_area3b", "layer": 4, "actor": "Gamma_004_Intro_C"},
    {"scenario": "s036_area3c", "layer": 0, "actor": "TG_Gamma_006_Dead_003"},
    {"scenario": "s036_area3c", "layer": 0, "actor": "TG_Gamma_007_B"},
    {"scenario": "s036_area3c", "layer": 3, "actor": "SG_Gamma_007_B"},
    {"scenario": "s036_area3c", "layer": 4, "actor": "SP_Gamma_007_B"},
    {"scenario": "s036_area3c", "layer": 4, "actor": "SP_Gamma_007_Intro_B"},
    {"scenario": "s040_area4", "layer": 0, "actor": "TG_Gamma_001_B"},
    {"scenario": "s040_area4", "layer": 3, "actor": "SG_Gamma_001_B"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_B"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_Intro_B"},
    {"scenario": "s040_area4", "layer": 0, "actor": "TG_Gamma_001_C"},
    {"scenario": "s040_area4", "layer": 3, "actor": "SG_Gamma_001_C"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_C"},
    {"scenario": "s040_area4", "layer": 4, "actor": "SP_Gamma_001_Intro_C"},
    {"scenario": "s050_area5", "layer": 0, "actor": "TG_Gamma_002_B"},
    {"scenario": "s050_area5", "layer": 3, "actor": "SG_Gamma_002_B"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_B"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_Intro_B"},
    {"scenario": "s050_area5", "layer": 0, "actor": "TG_Gamma_002_C"},
    {"scenario": "s050_area5", "layer": 3, "actor": "SG_Gamma_002_C"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_C"},
    {"scenario": "s050_area5", "layer": 4, "actor": "Gamma_002_Intro_C"},
]


def patch_multi_room_gammas(editor: PatcherEditor) -> None:
    for reference in MULTI_ROOM_GAMMAS:
        editor.remove_entity(reference)

    gamma_actors = [
        ("s030_area3", "SG_Gamma_005_C", "SP_Gamma_005_C", "TG_Gamma_005_C"),
        ("s033_area3b", "SG_Gamma_004_B", "Gamma_004_Intro_B", "TG_Gamma_004_B"),
        ("s036_area3c", "SG_Gamma_007_A", "SP_Gamma_007_Intro_A", "TG_Gamma_007_A"),
        ("s040_area4", "SG_Gamma_001_A", "SP_Gamma_001_Intro_A", "TG_Gamma_001_A"),
        ("s050_area5", "SG_Gamma_002_A", "Gamma_002_A", "TG_Gamma_002_A"),
    ]

    for scenario_name, spawngroup, spawnpoint, trigger in gamma_actors:
        scenario = editor.get_scenario(scenario_name)
        # remove the gamma name ¯\_(ツ)_/¯
        scenario.raw["actors"][3][spawngroup]["components"][0]["arguments"][27]["value"] = ""
        # ¯\_(ツ)_/¯
        scenario.raw["actors"][4][spawnpoint]["components"][0]["arguments"][11]["value"] = True
        # make the trigger active
        scenario.raw["actors"][0][trigger]["components"][0]["arguments"][0]["value"] = True
        # move Gamma_002_A so it doesn't just poof into existence when it spawns
        if scenario_name == "s050_area5":
            scenario.raw["actors"][4]["Gamma_002_A"]["position"][0] = 17100.0


def patch_pickup_rotation(editor: PatcherEditor) -> None:
    PICKUPS = {
        "s030_area3": ["LE_PowerUp_GrappleBeam"],
        "s050_area5": ["LE_PowerUp_SpaceJump"],
    }
    for scenario_name, pickups in PICKUPS.items():
        scenario = editor.get_scenario(scenario_name)
        for pickup in pickups:
            actor = scenario.raw.actors[9][pickup]
            actor["rotation"][1] = 0.0


def patch_pickup_position(editor: PatcherEditor) -> None:
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


def remove_area7_grapple_block(editor: PatcherEditor) -> None:
    editor.remove_entity(
        {"scenario": "s090_area9", "layer": 9, "actor": "LE_GrappleDest_007"}
    )


def patch_a7_save_screw_blocks(editor: PatcherEditor) -> None:
    area7 = editor.get_file(
        "maps/levels/c10_samus/s090_area9/s090_area9.bmsbk", Bmsbk
    )
    area7.raw["block_groups"][56]["types"][0]["block_type"] = "power_beam"


def shoot_supers_without_missiles(editor: PatcherEditor) -> None:
    samus_bmsad = editor.get_file(
        "actors/characters/samus/charclasses/samus.bmsad", Bmsad
    )
    samus_bmsad.raw["components"]["GUN"]["functions"][20]["params"]["Param5"]["value"] = "ITEM_MISSILE_CHECK"


def rebalance_bosses(editor: PatcherEditor) -> None:
    BOSSES = [
        ("manicminerbot", 0.19),
        ("ridley", 0.12),
    ]

    for boss, factor in BOSSES:
        bmsad = editor.get_file(f"actors/characters/{boss}/charclasses/{boss}.bmsad", Bmsad)
        bmsad.components["LIFE"].raw["fields"]["fPowerBeamFactor"]["value"] = factor

    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)

    '''
    Diggernaut

    Wave and Spazer will use the same factor as Plasma which is 0.19
    Wave: 50 -> 9.5
    Spazer: 210 -> 39.9
    Plasma: 57 (default from diggernaut tunable)
    '''
    diggernaut = tunables.raw["classes"]["ManicMinerBot|CTunableCharClassManicMinerBotAIComponent"]["tunables"]
    diggernaut["fHeadPlasmaBeamDamageFactor"]["value"] = 1.0
    diggernaut["fHeadPlasmaBeamChargeDamageFactor"]["value"] = 0.6
    diggernaut["fHeadPlasmaBeamWeaponBoostDamageFactor"]["value"] = 0.8
    diggernaut["fHeadPlasmaBeamWeaponBoostPhaseDisplacementDamageFactor"]["value"] = 1.0

    '''
    Ridley

    All beams (except Ice) will use the same factor as Plasma which is 0.12
    Power Beam: 25 -> 3
    Ice: 10
    Wave: 50 -> 6
    Spazer: 210 -> 25.2
    Plasma: 36 (default from ridley tunable)
    '''
    ridley = tunables.raw["classes"]["Ridley|CTunableCharClassRidleyAIComponent"]["tunables"]
    ridley["fPlasmaBeam"]["value"] = 1.0
    ridley["fPlasmaBeamCharge"]["value"] = 1.0
    ridley["fPlasmaBeamWeaponBoost"]["value"] = 1.1
    ridley["fPlasmaBeamWeaponBoostPhaseDisplacement"]["value"] = 1.1
    ridley["fGrabPlasmaBeam"]["value"] = 1.0
    ridley["fGrabPlasmaBeamCharge"]["value"] = 1.0
    ridley["fGrabPlasmaBeamWeaponBoost"]["value"] = 1.1
    ridley["fGrabPlasmaBeamWeaponBoostPhaseDisplacement"]["value"] = 1.1


def increase_pb_drop_chance(editor: PatcherEditor) -> None:
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
            drop[8]["value"]["value"] = 0.2
        # All other enemies and Metroid excluding Blobthrower
        else:
            drop["fPowerBombProbability"]["value"] = 0.2


def fix_wrong_cc_actor_deletions(editor: PatcherEditor) -> None:
    # Prevents hidden item actors from being deleted when its block is broken from an adjacent cc
    CUSTOM_BLOCK = Container({
        "pos": ListContainer([
            -10350.0,
            -1850.0,
            0.0,
        ]),
        "unk2": 0,
        "unk3": 0,
        "respawn_time": 0.0,
        "model_name": "sg_casca38",
        "vignette_name": ""
    })
    BOMB_GROUP = Container(
        unk_bool=True,
        types=ListContainer([Container(block_type='bomb', blocks=ListContainer([]))])
    )
    BEAM_GROUP = Container(
        unk_bool=True,
        types=ListContainer([Container(block_type='powerbeam', blocks=ListContainer([]))])
    )
    BMSBK_GROUP = Container(
        name="bg_SubArea_collision_camera_023", entries=ListContainer([])
    )

    scenario_powerup_eg = {
        "s000_surface": [
            {"powerup_name": "HiddenPowerup001", "cc": "collision_camera_023"},
        ],
        "s010_area1": [
            {"powerup_name": "HiddenPowerup001", "cc": "collision_camera_018"},
        ],
        "s025_area2b": [
            {"powerup_name": "HP_Item_001", "cc": "collision_camera012"},
        ],
        "s050_area5": [
            {"powerup_name": "HiddenPowerup002", "cc": "collision_camera_001"},
        ],
        "s067_area6c": [
            {"powerup_name": "HiddenPowerup002", "cc": "collision_camera_007"},
            {"powerup_name": "HiddenPowerup003", "cc": "collision_camera_011"},
        ]
    }

    for scenario_name, powerup_objs in scenario_powerup_eg.items():
        scenario = editor.get_scenario(scenario_name)
        for powerup_obj in powerup_objs:
            powerup_name = powerup_obj["powerup_name"]
            cc_name = powerup_obj["cc"]

            powerup_actor = next(
                actor for layer, actor_name, actor in scenario.all_actors() if actor_name == powerup_name
            )
            # Make actor freestanding
            powerup_actor["components"][0]["arguments"][0]["value"] = ""

            # Add block on top of item
            bmsbk = editor.get_file(
                f"maps/levels/c10_samus/{scenario_name}/{scenario_name}.bmsbk", Bmsbk
            )
            sg_casca = powerup_actor.components[0].arguments[2].value
            pos = powerup_actor.position
            # Edge case for the beam block in Surface
            if scenario_name == "s000_surface":
                new_group = copy.deepcopy(BEAM_GROUP)
                # Add the missing collision_camera entry
                bmsbk.raw.collision_cameras.append(BMSBK_GROUP)
            else:
                new_group = copy.deepcopy(BOMB_GROUP)
            new_block = copy.deepcopy(CUSTOM_BLOCK)
            new_block["pos"] = pos
            new_block["model_name"] = sg_casca
            types: ListContainer = typing.cast(ListContainer, new_group["types"])
            types[0]["blocks"].append(new_block)
            bmsbk.raw.block_groups.append(new_group)
            bmsbk_cc_obj = next(cc_obj for cc_obj in bmsbk.raw.collision_cameras if cc_name in cc_obj.name)
            bmsbk_cc_obj.entries.append(len(bmsbk.raw.block_groups) - 1)


def patch_area7_item(editor: PatcherEditor) -> None:
    area7 = editor.get_scenario("s090_area9")
    area7.add_actor_to_entity_groups("PostOmega_003", "LE_Item_009")


def patch_a4_collision(editor: PatcherEditor) -> None:
    # Extends the collision cc11 -> cc1 to allow for the upper path to be included in DLR
    area4 = editor.get_file("maps/levels/c10_samus/s050_area5/s050_area5.bmscd", Bmscc)
    area4.raw["layers"][0]["entries"][0]["data"]["polys"][0]["points"][327]["x"] = 750.0


def patch_a1_teleporter_crumbles(editor: PatcherEditor) -> None:
    # Prevents a possible softlock in DLR if a door is added to the teleporter room
    area1 = editor.get_file("maps/levels/c10_samus/s010_area1/s010_area1.bmsbk", Bmsbk)
    area1.raw["block_groups"][15]["types"][0]["blocks"][0]["respawn_time"] = 0.0


def disable_vignettes(editor: PatcherEditor) -> None:
    scenario_block_sg: dict[str, list[dict[str, typing.Any]]] = {
        # Exterior Alpha Bomb Block
        "s010_area1": [
            {"block_group": 6, "cc": ["017", "018"], "vignette_models": [2177967912]},
        ],
        # Beam Burst Shot Blocks
        "s030_area3": [
            {"block_group": 5, "cc": ["036"], "vignette_models": [1239739760, 2986218869]},
        ],
        # Lower Chozo Seal Bomb Blocks
        "s040_area4": [
            {"block_group": 27, "cc": ["006"], "vignette_models": [46617345, 354988048]}
        ],
        # Diggernaut Bomb Blocks
        "s070_area7": [
            {"block_group": 52, "cc": ["034"], "vignette_models": [1941338226]}
        ],
        # Middle Save Station Water Bomb Blocks
        "s090_area9": [
            {"block_group": 66, "cc": ["007"], "vignette_models": [3224282959, 1]}
        ],
    }
    for scenario_name, vignette_objects in scenario_block_sg.items():
        for vignette_object in vignette_objects:
            block_group = vignette_object["block_group"]

            bmsbk = editor.get_file(f"maps/levels/c10_samus/{scenario_name}/{scenario_name}.bmsbk", Bmsbk)
            blocks = bmsbk.raw["block_groups"][block_group]["types"][0]["blocks"]
            for block in blocks:
                # Separate the vignette from the block
                block["vignette_name"] = ""

            bmssd = editor.get_file(f"maps/levels/c10_samus/{scenario_name}/{scenario_name}.bmssd", Bmssd)
            sg_group = bmssd.raw["scene_groups"]
            vignette_models = vignette_object["vignette_models"]
            for camera in vignette_object["cc"]:
                cc_name = "sg_SubArea_collision_camera_" + camera
                for sg in sg_group:
                    # Check for the cc_name
                    if sg["sg_name"] == cc_name:
                        for cc_group in sg["model_groups"]:
                            model_group = cc_group["models"]
                            for idx, model in reversed(list(enumerate(model_group))):
                                if any(model["model_id"] == vignette for vignette in vignette_models):
                                    # Remove the model to prevent it from loading
                                    model_group.pop(idx)


def apply_static_fixes(editor: PatcherEditor) -> None:
    patch_multi_room_gammas(editor)
    patch_pickup_rotation(editor)
    patch_pickup_position(editor)
    remove_area7_grapple_block(editor)
    patch_a7_save_screw_blocks(editor)
    shoot_supers_without_missiles(editor)
    rebalance_bosses(editor)
    increase_pb_drop_chance(editor)
    fix_wrong_cc_actor_deletions(editor)
    patch_area7_item(editor)
    patch_a4_collision(editor)
    patch_a1_teleporter_crumbles(editor)
    disable_vignettes(editor)
