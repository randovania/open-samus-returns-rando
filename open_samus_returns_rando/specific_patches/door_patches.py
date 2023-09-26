
import copy
import logging

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.patcher_editor import PatcherEditor

# TODO: Remove it if we don't log anything after tests
LOG = logging.getLogger("door_patches")

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
    missile_types = {"doorshieldmissile", "doorshieldpowerbomb", "doorshieldsupermissile"}
    for area in ALL_AREAS:
        scenario = editor.get_scenario(area)
        for layer, actor_name, actor in scenario.all_actors():
            if actor.type in missile_types:
                actor["rotation"][1] = 90

def _patch_beam_covers(editor: PatcherEditor):
    EXCLUDES_PER_AREA = {
        "s010_area1": [
            "LE_DoorShieldPlasma011"
        ]
    }

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

    # TODO: remove it
    test_door = True
    beam_types = {"doorwave", "doorspazerbeam", "doorcreature"}
    for area_name in ALL_AREAS:
        editor.ensure_present_in_scenario(area_name, "actors/props/doors/scripts/doors.lc")
        scenario = editor.get_scenario(area_name)
        actor_list_copy = {actor_name: actor for layer, actor_name, actor in scenario.all_actors()}
        excludes_of_area = EXCLUDES_PER_AREA.get(area_name, [])
        for actor_name, actor in actor_list_copy.items():
            if actor.type in beam_types and actor_name not in excludes_of_area:
                new_actor_name = f"{actor_name}_o"
                new_actor = editor.copy_actor(
                    area_name, (actor["position"][0], actor["position"][1],  actor["position"][2]),
                    actor, new_actor_name, 9
                )
                if new_actor["rotation"][1] == 0.0:
                    new_actor["rotation"][0] = 0
                    new_actor["rotation"][1] = 180
                    new_actor["rotation"][2] = 0
                elif new_actor["rotation"][1] == 180.0:
                    new_actor["rotation"][0] = 0
                    new_actor["rotation"][1] = 0
                    new_actor["rotation"][2] = 0
                else:
                    # that one is weird (because of fake surface west ?)
                    if area_name == "s000_surface" and actor_name == "LE_SpazerShield_Door_012":
                        continue
                    raise Exception

                # no idea if this really gets the right door
                door_name = actor_name[actor_name.find("Door"):]
                door_name = door_name.replace("ShieldPlasma", "").replace("ShieldWave", "")
                door_actor = actor_list_copy.get(door_name, None)
                if door_actor is None:
                    door_actor = actor_list_copy[door_name.replace("_", "")]
                door_actor.components.append(copy.deepcopy(door_actor.components[0]))
                door_actor.components[1]["arguments"][3]["value"] = new_actor_name

            if actor.type == "doorwave" and test_door:
                test_door = False
                editor.copy_actor(area_name, (-15900.000, 1350.0, 0.0), actor, "COPY", 9)

def patch_shields(editor: PatcherEditor):
    editor.add_new_asset("actors/props/doors/scripts/doors.lc", files_path().joinpath("doors.lua").read_bytes(), [])

    _patch_missile_covers(editor)
    _patch_beam_covers(editor)
