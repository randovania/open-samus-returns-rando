
import copy

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.files import files_path
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
                    "value": "actors/props/doors/scripts/doors.lua",
                }),
                "Param2": Container({
                    "type" :"s",
                    "value":"Doors",
                }),
            }),
        }),
    ]),
    "fields": Container(),
    "dependencies": None,
})

ON_DEAD_CB = Container({
    "unk1": 22,
    "unk2": 1,
    "unk3": 0,
    "args": Container({
        601445949: Container({
            "type": "s",
            "value": "RemoveDoors",
        }),
    }),
})


def _patch_missile_covers(editor: PatcherEditor):
    ALL_MISSILE_SHIELDS = {
        "s000_surface": ["LE_MissileShield_Door_002", "LE_MissileShield_Door_006"],
        "s010_area1": ["LE_DoorShieldMissile", "LE_DoorShieldMissile001"],
        "s020_area2": ["LE_MissileShield_Door004", "LE_Shield_Door012"],
        "s025_area2b": ["LE_MissileShield_Door006", "LE_MissileShield_Door009",
                        "LE_MissileShield_Door013", "LE_PowerBombShield_Door015"],
        "s030_area3": ["LE_MissileShield_Door003"],
        "s036_area3c": ["LE_PowerBombShield_Door_007", "LE_SuperMissileShield_Door004"],
        "s040_area4": ["LE_MissileShield_Door_002"],
        "s050_area5": ["LE_MissileShield_Door004", "LE_MissileShield_Door013", "LE_SuperMissileShield_Door002",
                    "LE_SuperMissileShield_Door005", "LE_SuperMissileShield_Door010"],
        "s065_area6b": ["LE_MissileShield_Door002", "LE_PowerBombShield_Door005","LE_SuperMissileShield_Door004"],
        "s067_area6c": ["LE_MissileShield_Door006", "LE_MissileShield_Door009",
                        "LE_PowerBombShield_Door012", "LE_SuperMissileShield_Door011"],
        "s070_area7": ["LE_MissileShield_Door012", "LE_PowerBombShield_Door007", "LE_PowerBomb_Shield_017"],
    }

    for area_name, shield in ALL_MISSILE_SHIELDS.items():
        scenario = editor.get_scenario(area_name)
        for door in shield:
            actor = scenario.raw.actors[9][door]
            actor["rotation"][1] = 90


def _patch_beam_bmsads(editor: PatcherEditor):
    creature_bmsad_files = [
        "actors/props/doorspazerbeam/charclasses/doorspazerbeam.bmsad",
        "actors/props/doorcreature/charclasses/doorcreature.bmsad",
        "actors/props/doorwave/charclasses/doorwave.bmsad",
    ]
    for i, creature_bmsad_file in enumerate(creature_bmsad_files):
        cr_bmsad = editor.get_parsed_asset(creature_bmsad_file, type_hint=Bmsad)
        # add the script component, which defines the lua file where it finds functions
        cr_bmsad.raw["components"]["SCRIPT"] = SCRIPT_COMPONENT
        # add the callback to the first animation (which is "death" for the bmsad's)
        action_set_anim = cr_bmsad.action_sets[0].raw["animations"][0]
        action_set_anim.event_counts[0] = action_set_anim.event_counts[0] + 1
        action_set_anim["events0"].append(ON_DEAD_CB)
        # wave cb didn't work and it has animation id 21.it's maybe a bitmask? because it works
        # with 29 and also with 30 (which the other two are using) and both are setting 2^3 bit
        action_set_anim["animation_id"] = 30
        # modify doorwave collision
        if i == 2:
            # Param6 and Param7 seems to be a position
            cr_bmsad.components["COLLISION"].functions[1].params["Param7"].value = 148.0
            # Param9 and Param10 are a rectangular
            cr_bmsad.components["COLLISION"].functions[1].params["Param9"].value = 370.0
            cr_bmsad.components["COLLISION"].functions[1].params["Param10"].value = 300.0
        editor.replace_asset(creature_bmsad_file, cr_bmsad)

    editor.add_new_asset("actors/props/doors/scripts/doors.lc", files_path().joinpath("doors.lua").read_bytes(), [])
    for area_name in ALL_AREAS:
        editor.ensure_present_in_scenario(area_name, "actors/props/doors/scripts/doors.lc")


def _patch_beam_covers(editor: PatcherEditor):
    ALL_BEAM_COVERS = {
        "s000_surface": ["LE_PlasmaShield_Door_008"],
        "s010_area1": ["LE_DoorShieldWave008", "LE_SpazerShield_Door007"],
        "s020_area2": ["LE_WaveShield_Door010"],
        "s025_area2b": ["LE_PlasmaShield_Door017", "LE_WaveShield_Door008",
                        "LE_WaveShield_Door016", "LE_WaveShield_Door019"],
        "s033_area3b": ["LE_SpazerShield_Door_010", "LE_WaveShield_Door_007"],
        "s036_area3c": ["LE_WaveShield_Door_006"],
        "s040_area4": ["LE_SpazerShield_Door_001", "LE_SpazerShield_Door_004"],
        "s050_area5": ["LE_SpazerShield_Door008"],
        "s065_area6b": ["LE_PlasmaShield_Door003"],
        "s067_area6c": ["LE_PlasmaShield_Door005", "LE_PlasmaShield_Door014",
                        "LE_PlasmaShield_Door016", "LE_SpazerShield_Door018"],
        "s090_area9": ["LE_PlasmaShield_Door003", "LE_Shield_Door006", "LE_Shield_Door015"],
    }

    for area_name, beam_covers in ALL_BEAM_COVERS.items():
        scenario = editor.get_scenario(area_name)
        for cover_name in beam_covers:
            actor = scenario.raw.actors[9][cover_name]
            new_actor_name = f"{cover_name}_o"
            new_actor = editor.copy_actor(
                area_name, (actor["position"][0], actor["position"][1],  actor["position"][2]),
                actor, new_actor_name, 9
            )
            new_actor["rotation"][0] = 0
            new_actor["rotation"][2] = 0
            current_rotation = new_actor["rotation"][1]
            new_actor["rotation"][1] = 180 if current_rotation == 0.0 else 0.0

            door_name = cover_name[cover_name.find("Door"):]
            door_name = door_name.replace("ShieldPlasma", "").replace("ShieldWave", "")
            door_actor = scenario.raw.actors[15].get(door_name, None)
            if door_actor is None:
                door_actor = scenario.raw.actors[15][door_name.replace("_", "")]
            door_actor.components.append(copy.deepcopy(door_actor.components[0]))
            door_actor.components[1]["arguments"][3]["value"] = new_actor_name

            entity_groups = [group for group_name, group in scenario.all_actor_groups()
                    if group_name in list(scenario.all_actor_group_names_for_actor(cover_name))]
            for group in entity_groups:
                scenario.insert_into_entity_group(group, new_actor_name)



def _patch_charge_doors(editor: PatcherEditor):
    CHARGE_DOORS = {
        "s000_surface": ["Door004", "Door011"],
        "s010_area1": ["Door002"],
        "s028_area2c": ["Door001", "Door007"],
        "s030_area3": ["Door002", "Door008"],
        "s040_area4": ["Door006", "Door014"],
        "s050_area5": ["Door006"],
        "s060_area6": ["Door001"],
        "s070_area7": ["Door010"],
        "s090_area9": ["Door012"]
    }

    for area_name, doors in CHARGE_DOORS.items():
        scenario = editor.get_scenario(area_name)
        for door in doors:
            scenario.raw.actors[15][door].type = "doorpowerpower"


def _patch_one_way_doors(editor: PatcherEditor):
    ONE_WAY_DOORS = {
        # Bombs, Right Exterior Door -> Interior, Exterior Alpha
        "s010_area1": ["Door004", "Door012", "Door016"],
        # Below Wave Beam
        "s025_area2b": ["Door008"],
        # Below Chozo Seal
        "s030_area3": ["Door003", "Door006"],
        # Chozo Seal Spazer Door
        "s040_area4": ["Door001"],
        # Plasma Room Plasma and Missile doors, Gravity Room Missile Door
        "s067_area6c": ["Door005", "Door006", "Door009"]
    }

    for area_name, doors in ONE_WAY_DOORS.items():
        scenario = editor.get_scenario(area_name)
        for door in doors:
            properties = scenario.raw.actors[15][door]
            properties.type = "doorpowerpower"
            properties.components[0]["arguments"][2]["value"] = False


def patch_doors(editor: PatcherEditor):
    _patch_one_way_doors(editor)
    _patch_missile_covers(editor)
    _patch_beam_bmsads(editor)
    _patch_beam_covers(editor)
    _patch_charge_doors(editor)
