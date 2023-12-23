
import copy
from enum import Enum

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad, Bmsld, Lua
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

    for scenario_name, shield in ALL_MISSILE_SHIELDS.items():
        scenario = editor.get_scenario(scenario_name)
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
        cr_bmsad = editor.get_file(creature_bmsad_file, Bmsad)
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

    editor.add_new_asset(
        "actors/props/doors/scripts/doors.lc",
        Lua(Container(lua_text=files_path().joinpath("custom", "doors.lua").read_text()), editor.target_game),
        []
    )


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

    for scenario_name, beam_covers in ALL_BEAM_COVERS.items():
        scenario = editor.get_scenario(scenario_name)
        for cover_name in beam_covers:
            actor = scenario.raw.actors[9][cover_name]
            new_actor_name = f"{cover_name}_o"
            new_actor = editor.copy_actor(
                scenario_name, (actor["position"][0], actor["position"][1], actor["position"][2]),
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
        "s060_area6": ["Door001"],
        "s090_area9": ["Door012"]
    }

    for scenario_name, doors in CHARGE_DOORS.items():
        scenario = editor.get_scenario(scenario_name)
        for door in doors:
            scenario.raw.actors[15][door].type = "doorpowerpower"


def _patch_one_way_doors(editor: PatcherEditor):
    ONE_WAY_DOORS = {
        # Bombs, Right Exterior Door -> Interior, Exterior Alpha
        "s010_area1": ["Door004", "Door012", "Door016"],
        # Below Wave Beam
        "s025_area2b": ["Door008"],
        # Below Chozo Seal
        "s030_area3": ["Door005", "Door006"],
        # Chozo Seal Spazer Door
        "s040_area4": ["Door001"],
        # Super Missile Room Super Door
        "s050_area5": ["Door005"],
        # Plasma Room Plasma and Missile Doors, Gravity Room Missile Door
        "s067_area6c": ["Door005", "Door006", "Door009"]
    }

    for scenario_name, doors in ONE_WAY_DOORS.items():
        scenario = editor.get_scenario(scenario_name)
        for door in doors:
            properties = scenario.raw.actors[15][door]
            properties.type = "doorpowerpower"
            properties.components[0]["arguments"][2]["value"] = False


class ActorData(Enum):
    """
    Enum containing data on actors

    actordef: the actordef for the actor
    minimapData: the MinimapIconData for this type
    """
    DOOR_POWER = (["doorpowerpower", "doorpowerclosed", "doorclosedpower"])
    DOOR_CHARGE = (["doorchargecharge", "doorchargeclosed", "doorclosedcharge"])
    SHIELD_WAVE_BEAM = (["doorwave"])
    SHIELD_SPAZER_BEAM = (["doorspazerbeam"])
    SHIELD_PLASMA_BEAM = (["doorcreature"])
    SHIELD_MISSILE = (["doorshieldmissile"])
    SHIELD_SUPER_MISSILE = (["doorshieldsupermissile"])
    SHIELD_POWER_BOMB = (["doorshieldpowerbomb"])

class DoorType(Enum):
    """
    Enum containing info on each door type

    type: the name Randovania calls the door
    door: the door's ActorData
    need_shield: whether the actor needs a shield
    shield: the shield's ActorData
    """
    POWER = ("power_beam", ActorData.DOOR_POWER)
    # s067_area6c
    CHARGE = ("charge_beam", ActorData.DOOR_CHARGE, False, None, ["actors/props/doorchargecharge",
                # still not working :-S
                "actors/props/door/fx", "sounds/props/doorchargecharge"])
    WAVE_BEAM = ("wave_beam", ActorData.DOOR_POWER, True,
                 ActorData.SHIELD_WAVE_BEAM,["actors/props/doorwave"])
    SPAZER_BEAM = ("spazer_beam", ActorData.DOOR_POWER, True,
                    ActorData.SHIELD_SPAZER_BEAM, ["actors/props/doorspazerbeam"])
    PLASMA_BEAM = ("plasma_beam", ActorData.DOOR_POWER, True,
                    ActorData.SHIELD_PLASMA_BEAM, ["actors/props/doorcreature"])
    # s033_area3b, s036_area3c, s090_area9
    MISSILE = ("missile", ActorData.DOOR_POWER, True, ActorData.SHIELD_MISSILE, ["actors/props/doorshieldmissile"])
    SUPER_MISSILE = ("super_missile", ActorData.DOOR_POWER, True,
                      ActorData.SHIELD_SUPER_MISSILE, ["actors/props/doorshieldsupermissile"])
    POWER_BOMB = ("power_bomb", ActorData.DOOR_POWER, True,
                   ActorData.SHIELD_POWER_BOMB, ["actors/props/doorshieldpowerbomb"])

    def __init__(self, rdv_door_type: str, door_data: ActorData, need_shield: bool = False,
                 shield_data: ActorData = None, additional_asset_folders: list[str] = None):
        self.type = rdv_door_type
        self.need_shield = need_shield
        self.door = door_data
        self.shield = shield_data
        self.required_asset_folders = [] if additional_asset_folders is None else additional_asset_folders

    @classmethod
    def get_type(cls, type: str):
        for e in cls:
            if e.type == type:
                return e

        raise ValueError(f"{type} is not a patchable door!")

class DoorPatcher:
    def __init__(self, editor: PatcherEditor):
        self.editor = editor
        self._example_shield = editor.get_scenario("s000_surface").raw.actors[9]["LE_PlasmaShield_Door_008"]
        self._index_per_scenario = {}

    def _patch_to_power(self, door_actor: Container, scenario: Bmsld):
        for life_component in door_actor.components:
            shield = life_component["arguments"][3]["value"]
            if shield != "":
                scenario.remove_actor_from_all_groups(shield)
                scenario.raw.actors[9].pop(shield)
        # pop a life component from our static door patches
        if len(door_actor.components) > 1:
            door_actor.components.pop()
        door_actor.components[0]["arguments"][3]["value"] = ""
        door_actor.type = ActorData.DOOR_POWER.value[0]

    def _create_shield(
            self, scenario_name: str, position: tuple[float, float, float], shield_name: str, new_type: str
        ) -> Container:
        new_actor = self.editor.copy_actor(
                scenario_name, (position[0], position[1], position[2]),
                self._example_shield, shield_name, 9
            )

        new_actor["type"] = new_type
        return new_actor

    def patch_door(self, actor_ref: dict, door_type_str: str):
        scenario_name = actor_ref["scenario"]
        actor_name = actor_ref["actor"]
        scenario = self.editor.get_scenario(scenario_name)
        door_actor = scenario.raw.actors[15].get(actor_name, None)
        index = self._index_per_scenario.get(scenario_name, 0)
        if door_actor is None:
            raise ValueError(f"Actor {actor_name} not found in scenario {scenario_name}")

        self._patch_to_power(door_actor, scenario)

        # patch to desired type
        new_door: DoorType = DoorType.get_type(door_type_str)
        if not new_door.need_shield:
            door_actor.type = new_door.door.value[0]
        # all other use shields
        else:
            shield_position = (door_actor["position"][0], door_actor["position"][1],  door_actor["position"][2])
            new_actor_l = self._create_shield(
                scenario_name, shield_position, f"Shield_{index}", new_door.shield.value[0]
            )
            new_actor_r = self._create_shield(
                scenario_name, shield_position, f"Shield_{index}_o", new_door.shield.value[0]
            )
            new_actor_l["rotation"] = (0.0, 0.0, 0.0)
            new_actor_r["rotation"] = (0.0, 180.0, 0.0)

            # change life component
            door_actor.components.append(copy.deepcopy(door_actor.components[0]))
            door_actor.components[0]["arguments"][3]["value"] = f"Shield_{index}"
            door_actor.components[1]["arguments"][3]["value"] = f"Shield_{index}_o"

            # add to entity groups
            entity_groups = [group for group_name, group in scenario.all_actor_groups()
                if group_name in list(scenario.all_actor_group_names_for_actor(actor_name))]
            for group in entity_groups:
                scenario.insert_into_entity_group(group,  f"Shield_{index}")
                scenario.insert_into_entity_group(group,  f"Shield_{index}_o")

            # ensure required files
            for folder in new_door.required_asset_folders:
                for asset in self.editor.get_asset_names_in_folder(folder):
                    self.editor.ensure_present_in_scenario(scenario_name, asset)
            self._index_per_scenario[scenario_name] = index + 1


def _static_door_patches(editor: PatcherEditor):
    _patch_one_way_doors(editor)
    _patch_missile_covers(editor)
    _patch_beam_bmsads(editor)
    _patch_beam_covers(editor)
    _patch_charge_doors(editor)

def patch_doors(editor: PatcherEditor, door_patches: list[dict]):
    _static_door_patches(editor)

    door_patcher = DoorPatcher(editor)
    for door in door_patches:
        door_patcher.patch_door(door["actor"], door["door_type"])
