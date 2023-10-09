import copy
import functools
import json
import logging
from enum import Enum

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.files import templates_path
from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.model_data import get_data
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level

LOG = logging.getLogger("pickup")

TANK_ITEMS = {
    "ITEM_ENERGY_TANKS",
    "ITEM_AEION_TANKS",
    "ITEM_WEAPON_MISSILE_MAX",
    "ITEM_RANDO_LOCKED_SUPERS",
    "ITEM_RANDO_LOCKED_PBS",
}

ITEM_TO_OFFSET = {
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": 50,
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": 50,
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": 50,
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": 50,
    "ITEM_SPIDER_BALL": 40,
    "ITEM_ENERGY_TANKS": 0,
    "ITEM_AEION_TANKS": 0,
    "ITEM_WEAPON_MISSILE_MAX": 0,
    "ITEM_RANDO_LOCKED_SUPERS": 0,
    "ITEM_RANDO_LOCKED_PBS": 0,
    "ITEM_ADN": 50,
    "ITEM_BABY_HATCHLING": 50,
}

OFFSET =  Container({
    "vInitPosWorldOffset": Container({
        "type": "vec3",
        "value": ListContainer([
            0.0,
            50.0,
            0.0,
        ])
    }),
        "vInitAngWorldOffset": Container({
        "type": "vec3",
        "value": ListContainer([
            0.0,
            0.0,
            0.0,
        ])
    })
})

@functools.cache
def _read_template_powerup():
    with templates_path().joinpath("template_powerup_bmsad.json").open() as f:
        return json.load(f)


class PickupType(Enum):
    ACTOR = "actor"
    METROID = "metroid"

class BasePickup:
    def __init__(self, lua_editor: LuaEditor, pickup: dict, pickup_id: int, configuration: dict):
        self.lua_editor = lua_editor
        self.pickup = pickup
        self.pickup_id = pickup_id
        self.configuration = configuration

    def patch(self, editor: PatcherEditor):
        raise NotImplementedError

class ActorPickup(BasePickup):
    def patch_single_item_pickup(self, bmsad: dict) -> dict:
        pickable = bmsad["components"]["PICKABLE"]
        script: dict = bmsad["components"]["SCRIPT"]

        set_custom_params: dict = pickable["functions"][0]["params"]
        set_custom_params["Param1"]["value"] = "ITEM_NONE"
        set_custom_params["Param2"]["value"] = 0

        script["functions"][0]["params"]["Param1"]["value"] = \
            'actors/items/randomizer_powerup/scripts/randomizer_powerup.lc'
        script["functions"][0]["params"]["Param2"]["value"] = self.lua_editor.get_script_class(
            self.pickup, actordef_name=bmsad["name"]
        )
        return bmsad


    def patch_multi_item_pickup(self, bmsad: dict) -> dict:
        pickable: dict = bmsad["components"]["PICKABLE"]
        script: dict = bmsad["components"]["SCRIPT"]

        set_custom_params: dict = pickable["functions"][0]["params"]
        set_custom_params["Param1"]["value"] = "ITEM_NONE"
        set_custom_params["Param2"]["value"] = 0

        script["functions"][0]["params"]["Param1"]["value"] = \
            'actors/items/randomizer_powerup/scripts/randomizer_powerup.lc'
        script["functions"][0]["params"]["Param2"]["value"] = self.lua_editor.get_script_class(
            self.pickup, actordef_name=bmsad["name"]
            )
        return bmsad


    def patch_model(self, model_names: list[str], bmsad: dict) -> None:
        MODELUPDATER = bmsad["components"]["MODELUPDATER"]
        item_id: str = self.pickup["resources"][0][0]["item_id"]
        y_offset = ITEM_TO_OFFSET.get(item_id, 20)
        if len(model_names) == 1:
            model_data = get_data(model_names[0])
            action_sets: dict = bmsad["action_sets"][0]["animations"][0]
            bmsad["header"]["model_name"] = model_data.bcmdl_path
            fx_create_and_link: dict = bmsad["components"]["FX"]["functions"][0]["params"]


            MODELUPDATER["functions"][0]["params"]["Param1"]["value"] = model_data.bcmdl_path
            # tank items
            if item_id in TANK_ITEMS:
                action_sets["animation_id"] = 150
                action_sets["action"]["bcskla"] = "actors/items/itemtank/animations/relax.bcskla"
                if item_id != "ITEM_ENERGY_TANKS":
                    energytank_bcmdl = "actors/items/item_energytank/models/item_energytank.bcmdl"
                    MODELUPDATER["functions"][0]["params"]["Param2"]["value"] = energytank_bcmdl
                else:
                    MODELUPDATER["functions"][0]["params"].pop("Param2")
            # aeion abilities
            elif item_id.startswith("ITEM_SPECIAL_ENERGY"):
                fx_create_and_link["Param8"]["value"] = y_offset

                scanningpulse_bcmdl = "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl"
                MODELUPDATER["functions"][0]["params"]["Param2"]["value"] = scanningpulse_bcmdl
                fx_create_and_link["Param13"]["value"] = True
                if item_id == "ITEM_SPECIAL_ENERGY_SCANNING_PULSE":
                    fx_create_and_link["Param1"]["value"] = "orb"
                    fx_create_and_link["Param2"]["value"] = "actors/items/powerup_scanningpulse/fx/orb.bcptl"
                if item_id == "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD":
                    fx_create_and_link["Param1"]["value"] = "orb"
                    fx_create_and_link["Param2"]["value"] = "actors/items/powerup_energyshield/fx/orb.bcptl"
                if item_id == "ITEM_SPECIAL_ENERGY_ENERGY_WAVE":
                    fx_create_and_link["Param1"]["value"] = "yelloworb"
                    fx_create_and_link["Param2"]["value"] = "actors/items/powerup_energywave/fx/yelloworb.bcptl"
                elif item_id == "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT":
                    fx_create_and_link["Param1"]["value"] = "purpleorb"
                    fx_create_and_link["Param2"]["value"] = "actors/items/powerup_phasedisplacement/fx/purpleorb.bcptl"
            elif item_id == "ITEM_ADN":
                fx_create_and_link["Param8"]["value"] = y_offset
                fx_create_and_link["Param1"]["value"] = "leak"
                fx_create_and_link["Param2"]["value"] = "actors/items/adn/fx/adnleak.bcptl"
                fx_create_and_link["Param13"]["value"] = True
        else:
            MODELUPDATER["type"] = "CMultiModelUpdaterComponent"
            # no idea what this is
            MODELUPDATER["unk_1"] = 2500
            MODELUPDATER["unk_2"] = 0.0

            for idx, model_name in enumerate(model_names):
                model_data = get_data(model_name)
                if idx != 0:
                    MODELUPDATER["functions"].append(copy.deepcopy(MODELUPDATER["functions"][0]))
                MODELUPDATER["functions"][idx]["name"] = "AddModel"
                MODELUPDATER["functions"][idx]["unk1"] = True
                MODELUPDATER["functions"][idx]["unk2"] = False
                # this is just the alias which needs to be used in the update functions of lua
                # we are simply using the model name as alias
                MODELUPDATER["functions"][idx]["params"]["Param1"]["value"] = model_name
                MODELUPDATER["functions"][idx]["params"]["Param2"] = copy.deepcopy(
                    MODELUPDATER["functions"][idx]["params"]["Param1"]
                )
                MODELUPDATER["functions"][idx]["params"]["Param2"]["value"] = model_data.bcmdl_path

        # offset for single and multimodels
        if item_id not in TANK_ITEMS:
            MODELUPDATER["fields"] = OFFSET
            MODELUPDATER["fields"]["vInitPosWorldOffset"]["value"][1] = y_offset


    def patch(self, editor: PatcherEditor):
        template_bmsad = _read_template_powerup()

        actor_reference = self.pickup["pickup_actor"]
        pkgs_for_level = set(editor.find_pkgs(path_for_level(self.pickup["pickup_actor"]["scenario"]) + ".bmsld"))
        actor_name = actor_reference["actor"]

        scenario = editor.get_scenario(actor_reference["scenario"])
        actor = next((layer[actor_name] for layer in scenario.raw.actors if actor_name in layer), None)
        if actor is None:
            raise KeyError(f"No actor named '{actor_name}' found in {actor_reference['scenario']}")

        new_template = copy.deepcopy(template_bmsad)
        actordef_id = f"randomizer_powerup_{self.pickup_id}"
        new_template["name"] = actordef_id

        # Update model
        model_names: list[str] = self.pickup["model"]
        self.patch_model(model_names, new_template)

        # TODO Update minimap

        # Update caption
        pickable = new_template["components"]["PICKABLE"]
        # this actually wants an #GUI identifier but it works
        pickable["functions"][0]["params"]["Param7"]["value"] = self.pickup["caption"]

        # Update given item
        if len(self.pickup["resources"]) == 1 and len(self.pickup["resources"][0]) == 1:
            new_template = self.patch_single_item_pickup(new_template)
        else:
            new_template = self.patch_multi_item_pickup(new_template)

        # new_path = f"actors/items/randomizer_powerup/charclasses/randomizer_powerup_{self.pickup_id}.bmsad"
        new_path = f"actors/items/{actordef_id}/charclasses/{actordef_id}.bmsad"
        editor.add_new_asset(new_path, Bmsad(new_template, editor.target_game), in_pkgs=pkgs_for_level)
        actor.type = actordef_id

        # Dependencies
        for level_pkg in pkgs_for_level:
            for model_name in model_names:
                model_data = get_data(model_name)
                for dep in model_data.dependencies:
                    editor.ensure_present(level_pkg, dep)

        # For debugging, write the bmsad we just created
        # Path("custom_bmsad", f"randomizer_powerup_{i}.bmsad.json").write_text(
        #     json.dumps(new_template, indent=4)
        # )

class MetroidPickup(BasePickup):
    def patch(self, editor: PatcherEditor):
        lua_class = self.lua_editor.get_script_class(self.pickup)
        self.lua_editor.add_metroid_pickup(self.pickup["metroid_callback"], lua_class)


def ensure_base_models(editor: PatcherEditor) -> None:
    for level_pkg in editor.get_all_level_pkgs():
        # ensure base stuff
        editor.ensure_present(level_pkg, "system/animtrees/base.bmsat")
        editor.ensure_present(level_pkg, "sounds/generic/obtencion.bcwav")
        editor.ensure_present(level_pkg, "actors/items/randomizer_powerup/scripts/randomizer_powerup.lc")
        editor.ensure_present(level_pkg, "actors/scripts/metroid.lc")

        # ensure itemsphere stuff (base for many majors)
        editor.ensure_present(level_pkg, "actors/items/itemsphere/animations/relax.bcskla")
        model_data = get_data("itemsphere")
        for dep in model_data.dependencies:
            editor.ensure_present(level_pkg, dep)

        # ensure energytank stuff (base for all tanks)
        editor.ensure_present(level_pkg, "actors/items/itemtank/animations/relax.bcskla")
        model_data = get_data("item_energytank")
        for dep in model_data.dependencies:
            editor.ensure_present(level_pkg, dep)


def patch_pickups(editor: PatcherEditor, lua_scripts: LuaEditor, pickups_config: list[dict], configuration: dict):
    editor.add_new_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc", b'', [])
    editor.add_new_asset("actors/scripts/metroid.lc", b'', [])
    ensure_base_models(editor)

    for i, pickup in enumerate(pickups_config):
        LOG.debug("Writing pickup %d: %s", i, pickup["caption"])
        try:
            pickup_object_for(lua_scripts, pickup, i, configuration).patch(editor)
        except NotImplementedError as e:
            LOG.warning(e)

_PICKUP_TYPE_TO_CLASS: dict[PickupType, type[BasePickup]] = {
    PickupType.ACTOR: ActorPickup,
    PickupType.METROID: MetroidPickup,
}

def pickup_object_for(lua_scripts: LuaEditor, pickup: dict, pickup_id: int, configuration: dict) -> "BasePickup":
    pickup_type = PickupType(pickup["pickup_type"])
    return _PICKUP_TYPE_TO_CLASS[pickup_type](lua_scripts, pickup, pickup_id, configuration)
