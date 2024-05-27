import copy
import re
import typing
from enum import Enum

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad, Bmsld, Bmsmsd, Lua
from mercury_engine_data_structures.formats.bmsmsd import IconPriority
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
        "CallbackName": Container({
            "type": "s",
            "value": "RemoveDoors",
        }),
    }),
})


def _patch_missile_covers(editor: PatcherEditor) -> None:
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


def _patch_beam_bmsads(editor: PatcherEditor) -> None:
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
            cr_bmsad.components["COLLISION"].functions[1].params["Param7"].value = 148.0 # type: ignore
            # Param9 and Param10 are a rectangular
            cr_bmsad.components["COLLISION"].functions[1].params["Param9"].value = 370.0 # type: ignore
            cr_bmsad.components["COLLISION"].functions[1].params["Param10"].value = 300.0 # type: ignore

    editor.add_new_asset(
        "actors/props/doors/scripts/doors.lc",
        Lua(Container(lua_text=files_path().joinpath("custom", "doors.lua").read_text()), editor.target_game),
        []
    )


def _patch_beam_covers(editor: PatcherEditor) -> None:
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
                scenario_name, [actor["position"][0], actor["position"][1], actor["position"][2]],
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


def _patch_charge_doors(editor: PatcherEditor) -> None:
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


def _patch_one_way_doors(editor: PatcherEditor) -> None:
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


def _static_door_patches(editor: PatcherEditor) -> None:
    _patch_one_way_doors(editor)
    _patch_missile_covers(editor)
    _patch_beam_bmsads(editor)
    _patch_beam_covers(editor)
    _patch_charge_doors(editor)


class ActorData(Enum):
    """
    Enum containing data on actors

    actordef: the actordef for the actor
    """
    DOOR_POWER = (["doorpowerpower", "doorpowerclosed", "doorclosedpower"])
    DOOR_CHARGE = (["doorchargecharge", "doorchargeclosed", "doorclosedcharge"])
    SHIELD_WAVE_BEAM = (["doorwave"])
    SHIELD_SPAZER_BEAM = (["doorspazerbeam"])
    SHIELD_PLASMA_BEAM = (["doorcreature"])
    SHIELD_MISSILE = (["doorshieldmissile"])
    SHIELD_SUPER_MISSILE = (["doorshieldsupermissile"])
    SHIELD_POWER_BOMB = (["doorshieldpowerbomb"])
    SHIELD_ICE_BEAM = (["doorshieldicebeam"])
    SHIELD_GRAPPLE_BEAM = (["doorshieldgrapplebeam"])
    SHIELD_BEAM_BURST = (["doorshieldbeamburst"])
    SHIELD_BOMB = (["doorshieldbomb"])
    SHIELD_LOCKED = (["doorshieldlocked"])

class DoorType(Enum):
    """
    Enum containing info on each door type

    type: the name Randovania calls the door
    door: the door's ActorData
    need_shield: whether the actor needs a shield
    shield: the shield's ActorData
    """
    POWER = ("power_beam", ActorData.DOOR_POWER, "doorpower")
    CHARGE = ("charge_beam", ActorData.DOOR_CHARGE, "doorcharge", False, None, [
        "actors/props/doorchargecharge", "actors/props/door/fx", "sounds/props/doorchargecharge"
    ])
    WAVE_BEAM = ("wave_beam", ActorData.DOOR_POWER, "doorwave", True, ActorData.SHIELD_WAVE_BEAM, [
        "actors/props/doorwave", "sounds/props/doorwave", "system/fx/textures/blood_gray.bctex",
    ], 180.0)
    SPAZER_BEAM = ("spazer_beam", ActorData.DOOR_POWER, "doorspazer", True, ActorData.SHIELD_SPAZER_BEAM, [
        "actors/props/doorspazerbeam", "sounds/props/spazerdoor"
    ])
    PLASMA_BEAM = ("plasma_beam", ActorData.DOOR_POWER, "doorplasma", True, ActorData.SHIELD_PLASMA_BEAM, [
        "actors/props/doorcreature", "sounds/props/creaturedoor", "system/fx/textures/blood_gray.bctex",
    ], 180.0)
    MISSILE = ("missile", ActorData.DOOR_POWER, "doormissile", True, ActorData.SHIELD_MISSILE, [
        "actors/props/doorshield", "actors/props/doorshieldmissile",
        "sounds/props/doorchargecharge/missiledoor_hum.bcwav"
    ])
    SUPER_MISSILE = ("super_missile", ActorData.DOOR_POWER, "doorsupermissile", True, ActorData.SHIELD_SUPER_MISSILE, [
        "actors/props/doorshield", "actors/props/doorshieldsupermissile",
        "sounds/props/doorchargecharge/smissiledoor_hum.bcwav"
    ])
    POWER_BOMB = ("power_bomb", ActorData.DOOR_POWER, "doorpowerbomb", True, ActorData.SHIELD_POWER_BOMB, [
        "actors/props/doorshield", "actors/props/doorshieldpowerbomb",
        "sounds/props/doorchargecharge/powerbombdoor_hum.bcwav"
    ])
    ICE_BEAM = ("ice_beam", ActorData.DOOR_POWER, "doorice", True, ActorData.SHIELD_ICE_BEAM, [
        "actors/props/doorshield", "actors/props/doorcreature", "actors/props/doorshieldicebeam",
        "sounds/props/creaturedoor", "system/fx/textures/blood_gray.bctex",
    ], 180.0)
    GRAPPLE_BEAM = ("grapple_beam", ActorData.DOOR_POWER, "doorgrapple", True, ActorData.SHIELD_GRAPPLE_BEAM, [
        "actors/props/doorshield", "actors/props/doorshieldgrapplebeam",
        "sounds/props/doorchargecharge/missiledoor_hum.bcwav"
    ])
    BOMB = ("bomb", ActorData.DOOR_POWER, "doorbomb", True, ActorData.SHIELD_BOMB, [
        "actors/props/doorshield", "actors/props/doorshieldsupermissile", "actors/props/doorshieldbomb",
        "sounds/props/doorchargecharge/smissiledoor_hum.bcwav"
    ])
    BEAM_BURST = ("beam_burst", ActorData.DOOR_POWER, "doorbeamburst", True, ActorData.SHIELD_BEAM_BURST, [
        "actors/props/doorshield", "actors/props/doorshieldpowerbomb", "actors/props/doorshieldbeamburst",
        "sounds/props/doorchargecharge/powerbombdoor_hum.bcwav"
    ])
    LOCKED = ("locked", ActorData.DOOR_POWER, "doorlocked", True, ActorData.SHIELD_LOCKED, [
        "actors/props/doorshield", "actors/props/doorshieldlocked", "actors/props/doorspazerbeam",
        "sounds/props/spazerdoor"
    ])

    def __init__(self, rdv_door_type: str, door_data: ActorData, minimap_name: str,
                 need_shield: bool = False, shield_data: ActorData | None = None,
                 additional_asset_folders: list[str] | None = None, rotation: float = 0):
        self.type = rdv_door_type
        self.need_shield = need_shield
        self.door = door_data
        self.shield = shield_data
        self.required_asset_folders = [] if additional_asset_folders is None else additional_asset_folders
        self.minimap_name = minimap_name
        self.rotation = rotation

    @classmethod
    def get_type(cls, type: str) -> typing.Self:
        for e in cls:
            if e.type == type:
                return e

        raise ValueError(f"{type} is not a patchable door!")

class DoorPatcher:
    def __init__(self, editor: PatcherEditor):
        self.editor = editor
        self._example_shield = editor.get_scenario("s000_surface").raw.actors[9]["LE_PlasmaShield_Door_008"]
        self._index_per_scenario: dict[str, int] = {}

    def _patch_to_power(self, door_actor: Container, scenario: Bmsld) -> None:
        for life_component in door_actor.components:
            shield = life_component["arguments"][3]["value"]
            if shield != "":
                scenario.remove_actor_from_all_groups(shield)
                scenario.raw.actors[9].pop(shield)
        # pop a life component from our static door patches
        if len(door_actor.components) > 1:
            door_actor.components.pop()
        door_actor.components[0]["arguments"][2]["value"] = False
        door_actor.components[0]["arguments"][3]["value"] = ""
        door_actor["type"] = ActorData.DOOR_POWER.value[0]

    def _create_shield(
            self, scenario_name: str, position: tuple[float, float, float], shield_name: str, new_type: str
        ) -> Container:
        new_actor = self.editor.copy_actor(
                scenario_name, [position[0], position[1], position[2]],
                self._example_shield, shield_name, 9
            )

        new_actor["type"] = new_type
        return new_actor

    def _fix_surfaceb_door012(
                self,
                door_actor: Container,
                left_shield_name: str, left_shield_actor: Container,
                right_shield_name: str, right_shield_actor: Container,
                new_door: DoorType
            ) -> None:
        scenario_name = "s110_surfaceb"
        scenario = self.editor.get_scenario(scenario_name)

        # remove door and shield
        scenario.raw.actors[15].pop("Door012")
        self.editor.remove_entity({
            "scenario": scenario_name, "layer": 9, "actor": "LE_SpazerShield_Door_012"
        })

        # copy door
        self.editor.copy_actor(
            scenario_name, door_actor.position,
            door_actor, "Door012", 15
        )

        # if shield exists
        if left_shield_actor is not None and right_shield_actor is not None:
            # copy left
            self.editor.copy_actor(
                scenario_name, left_shield_actor.position,
                left_shield_actor, left_shield_name, 9
            )
            # copy right
            self.editor.copy_actor(
                scenario_name, right_shield_actor.position,
                right_shield_actor, right_shield_name, 9
            )

            # add to entity groups
            entity_groups = [group for group_name, group in scenario.all_actor_groups()
                if group_name in list(scenario.all_actor_group_names_for_actor("Door012"))]
            for group in entity_groups:
                scenario.insert_into_entity_group(group,  left_shield_name)
                scenario.insert_into_entity_group(group,  right_shield_name)

        # ensure required files
        for folder in new_door.required_asset_folders:
            for asset in self.editor.get_asset_names_in_folder(folder):
                self.editor.ensure_present_in_scenario(scenario_name, asset)

    def patch_door(self, editor: PatcherEditor, actor_ref: dict, door_type_str: str) -> None:
        scenario_name = actor_ref["scenario"]
        actor_name = actor_ref["actor"]
        scenario = self.editor.get_scenario(scenario_name)
        door_actor = scenario.raw.actors[15].get(actor_name, None)
        index = self._index_per_scenario.get(scenario_name, 0)
        left_shield_name = f"Shield_{index}"
        right_shield_name = f"Shield_{index}_o"
        new_door: DoorType = DoorType.get_type(door_type_str)
        if door_actor is not None:
            self.patch_actor(
                new_door, scenario_name, actor_name, scenario, door_actor, index, left_shield_name, right_shield_name
            )
        if scenario_name == "s000_surface" and actor_name == "Door012":
            left_shield_actor = scenario.raw.actors[9].get(left_shield_name, None)
            right_shield_actor = scenario.raw.actors[9].get(right_shield_name, None)
            self._fix_surfaceb_door012(
                door_actor, left_shield_name, left_shield_actor, right_shield_name, right_shield_actor, new_door
            )

        self.patch_minimap(editor, scenario_name, actor_name, left_shield_name, right_shield_name, new_door)

    def patch_minimap(
            self, editor: PatcherEditor, scenario_name:str, actor_name:str,
            left_shield_name:str, right_shield_name:str, new_door: DoorType
            ) -> None:
        scenario_minimap = editor.get_file(f"gui/minimaps/c10_samus/{scenario_name}.bmsmsd", Bmsmsd)
        tiles = scenario_minimap.raw["tiles"]

        # find left and right tile
        tiles_for_door = [
            x
            for x in tiles
            if len(x.icons) and next((y for y in x.icons if actor_name in y.actor_name), 0)
        ]

        # single sided shields can have different names.
        # if we only found the left or right tile, get the left / right one manually by using the coordinates
        if len(tiles_for_door) == 1:
            l_or_r_tile = tiles_for_door[0]
            if next((x for x in l_or_r_tile.icons if "left" in x.actor_name), False):
                right_x_coordinates = [l_or_r_tile.tile_coordinates[0] + 1, l_or_r_tile.tile_coordinates[1]]
                right_tile = next((x for x in tiles if x.tile_coordinates == right_x_coordinates), None)
                tiles_for_door.append(right_tile)
            elif next((x for x in l_or_r_tile.icons if "right" in x.actor_name), False):
                left_x_coordinates = [l_or_r_tile.tile_coordinates[0] - 1, l_or_r_tile.tile_coordinates[1]]
                left_tile = next((x for x in tiles if x.tile_coordinates == left_x_coordinates), None)
                tiles_for_door.insert(0, left_tile)
            else:
                raise ValueError("Cannot find other side of the door")

        # two Shields have mismatched names in both cases the first object needs to be removed
        if len(tiles_for_door) == 3:
            tiles_for_door.remove(tiles_for_door[0])
        elif len(tiles_for_door) != 2:
            raise ValueError("Found not exactly two tiles")

        # sometimes it finds right tile first and left second, so flip it because
        # tiles_for_door[0] should always be left and tiles_for_door[1] always be right

        if tiles_for_door[0].tile_coordinates[0] > tiles_for_door[1].tile_coordinates[0]:
            tiles_for_door.insert(0, tiles_for_door.pop())

        # find the icons of the tile
        left_tile_icon =  next(
            (y for y in tiles_for_door[0].icons if "Door" in y.actor_name or "Shield" in y.actor_name), None
        )
        right_tile_icon =  next(
            (y for y in tiles_for_door[1].icons if "Door" in y.actor_name or "Shield" in y.actor_name), None
        )

        if not left_tile_icon:
            raise ValueError("No matching left icon found")
        if not right_tile_icon:
            raise ValueError("No matching right icon found")

        # change the icons to their new door type
        left_tile_icon.icon = f"{new_door.minimap_name}left"
        left_tile_icon.clear_condition = ""
        right_tile_icon.icon = f"{new_door.minimap_name}right"
        right_tile_icon.clear_condition = ""
        if not new_door.need_shield:
            left_tile_icon.actor_name = f"{actor_name}left"
            left_tile_icon.icon_priority = IconPriority.DOOR
            right_tile_icon.actor_name = f"{actor_name}right"
            right_tile_icon.icon_priority = IconPriority.DOOR
        else:
            left_tile_icon.actor_name = left_shield_name
            left_tile_icon.icon_priority = IconPriority.ACTOR
            right_tile_icon.actor_name = right_shield_name
            right_tile_icon.icon_priority = IconPriority.ACTOR

        # bad special case to force DoorManicMinerBot to doorclosed...
        if actor_name == "DoorManicMinerBot":
            left_tile_icon.icon = 'doorclosedleft'
            # breaks minimap updating when shooting it from the left side but fixes itself after scan or reload
            left_tile_icon.actor_name = ''

        # special case for the single tile save station in area 1
        if scenario_name == "s010_area1" and actor_name in {"RandoDoor_004", "RandoDoor_005", "RandoDoor006"}:
            # FIXME: can't have both door icons be shown inside, so don't show either door pair
            left_tile_icon.icon = ""
            right_tile_icon.icon = ""


    def patch_actor(
            self, new_door: DoorType, scenario_name: str, actor_name: str, scenario: Bmsld,
            door_actor: Container, index: int, left_shield_name: str, right_shield_name: str
        ) -> None:
        if door_actor is None:
            raise ValueError(f"Actor {actor_name} not found in scenario {scenario_name}")

        self._patch_to_power(door_actor, scenario)

        # patch to desired type
        if not new_door.need_shield:
            door_actor["type"] = new_door.door.value[0]
        # all other use shields
        else:
            assert new_door.shield is not None
            shield_position = (door_actor["position"][0], door_actor["position"][1],  door_actor["position"][2])
            new_actor_l = self._create_shield(
                scenario_name, shield_position, left_shield_name, new_door.shield.value[0]
            )
            new_actor_r = self._create_shield(
                scenario_name, shield_position, right_shield_name, new_door.shield.value[0]
            )
            new_actor_l["rotation"] = (0.0, new_door.rotation, 0.0)
            new_actor_r["rotation"] = (0.0, 0.0 if new_door.rotation > 0 else 180.0, 0.0)

            # change life component
            door_actor.components.append(copy.deepcopy(door_actor.components[0]))
            door_actor.components[0]["arguments"][3]["value"] = left_shield_name
            door_actor.components[1]["arguments"][3]["value"] = right_shield_name

            # add to entity groups
            entity_groups = [group for group_name, group in scenario.all_actor_groups()
                if group_name in list(scenario.all_actor_group_names_for_actor(actor_name))]
            for group in entity_groups:
                scenario.insert_into_entity_group(group,  left_shield_name)
                scenario.insert_into_entity_group(group,  right_shield_name)
            self._index_per_scenario[scenario_name] = index + 1

        # bad special case to force DoorManicMinerBot to doorclosed...
        if actor_name == "DoorManicMinerBot":
            door_actor["type"] = re.sub("(doorpower|doorcharge)", "doorclosed", door_actor.type)

        # ensure required files
        for folder in new_door.required_asset_folders:
            for asset in self.editor.get_asset_names_in_folder(folder):
                self.editor.ensure_present_in_scenario(scenario_name, asset)


def patch_doors(editor: PatcherEditor, door_patches: list[dict]) -> None:
    _static_door_patches(editor)
    door_patcher = DoorPatcher(editor)

    # small hack to eliminate duplicates (randovania exports everything duplicated)
    import json

    set_of_jsons = {json.dumps(d, sort_keys=True) for d in door_patches}
    door_patches_set = [json.loads(t) for t in set_of_jsons]

    for door in door_patches_set:
        door_patcher.patch_door(editor, door["actor"], door["door_type"])
