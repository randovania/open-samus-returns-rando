import copy
import functools
import json
from enum import Enum
from pathlib import Path

from construct import Container
from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando import model_data
from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.samus_returns_patcher import PatcherEditor
from open_samus_returns_rando.text_patches import patch_text

EXPANSION_ITEM_IDS = {
    "ITEM_ENERGY_TANKS",
    "ITEM_WEAPON_MISSILE_MAX",
    "ITEM_WEAPON_SUPER_MISSILE_MAX",
    "ITEM_WEAPON_SUPER_MISSILE",
    "ITEM_WEAPON_POWER_BOMB_MAX",
    "ITEM_WEAPON_POWER_BOMB",

    # For multiworld
    "ITEM_NONE",
}

@functools.cache
def _read_template_powerup():
    with Path(__file__).parent.joinpath("templates", "template_powerup_bmsad.json").open() as f:
        return json.load(f)

class PickupType(Enum):
    ACTOR = "actor"

class BasePickup:
    def __init__(self, lua_editor: LuaEditor, pickup: dict, pickup_id: int, configuration: dict):
        self.lua_editor = lua_editor
        self.pickup = pickup
        self.pickup_id = pickup_id
        self.configuration = configuration

    def patch(self, editor: PatcherEditor):
        raise NotImplementedError()
    
class ActorPickup(BasePickup):
    def patch_single_item_pickup(self, bmsad: dict) -> dict:
        pickable: dict = bmsad["property"]["components"]["PICKABLE"]
        script: dict = bmsad["property"]["components"]["SCRIPT"]

        set_custom_params: dict = pickable["functions"][0]["params"]
        item_id: str = self.pickup["resources"][0][0]["item_id"]
        quantity: float = self.pickup["resources"][0][0]["quantity"]

        if item_id == "ITEM_ENERGY_TANKS":
            quantity *= self.configuration["energy_per_tank"]
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fCurrentLife"
            set_custom_params["Param6"]["value"] = "LIFE"

            item_id = "fMaxLife"

        elif item_id == "ITEM_SENERGY_TANKS":
            quantity *= self.configuration["aeion_per_tank"]
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fEnergy"
            set_custom_params["Param6"]["value"] = "SPECIALENERGY"

            item_id = "fMaxEnergy,"

        elif item_id in {"ITEM_WEAPON_MISSILE_MAX", "ITEM_WEAPON_SUPER_MISSILE_MAX", "ITEM_WEAPON_SUPER_MISSILE",
                         "ITEM_WEAPON_POWER_BOMB_MAX", "ITEM_WEAPON_POWER_BOMB"}:
            current = item_id.replace("_MAX", "_CURRENT")
            if item_id == current:
                current += "_CURRENT"

            set_custom_params["Param4"]["value"] = "Custom"
            set_custom_params["Param5"]["value"] = current
            set_custom_params["Param8"]["value"] = "guicallbacks.OnSecondaryGunsFire"
            set_custom_params["Param13"] = {
                "type": "f",
                "value": quantity,
            }

        script["functions"][0]["params"]["Param2"]["value"] = self.lua_editor.get_script_class(self.pickup)

        set_custom_params["Param1"]["value"] = item_id
        set_custom_params["Param2"]["value"] = quantity

        return bmsad
    
    def patch_multi_item_pickup(self, bmsad: dict) -> dict:
        pickable: dict = bmsad["property"]["components"]["PICKABLE"]
        script: dict = bmsad["property"]["components"]["SCRIPT"]

        set_custom_params: dict = pickable["functions"][0]["params"]
        set_custom_params["Param1"]["value"] = "ITEM_NONE"

        script["functions"][0]["params"]["Param2"]["value"] = self.lua_editor.get_script_class(self.pickup,
                                                                                               actordef_name=bmsad[
                                                                                                   "name"])

        return bmsad

    def patch_model(self, editor: PatcherEditor, model_names: list[str], actor: Container,
                    new_template: dict):
        if len(model_names) == 1:
            selected_model_data = model_data.get_data(model_names[0])

            # Update used model
            new_template["property"]["model_name"] = selected_model_data.bcmdl_path
            model_updater = new_template["property"]["components"]["MODELUPDATER"]
            model_updater["functions"][0]["params"]["Param1"]["value"] = selected_model_data.bcmdl_path

            if selected_model_data.transform is not None:
                model_updater["fields"] = {
                    "empty_string": "",
                    "root": "Root",
                    "fields": {
                        "vInitScale": list(selected_model_data.transform.scale),
                        "vInitPosWorldOffset": list(selected_model_data.transform.position),
                        "vInitAngWorldOffset": list(selected_model_data.transform.angle),
                    }
                }
        else:
            default_model_data = model_data.get_data(model_names[0])
            model_updater = new_template["property"]["components"]["MODELUPDATER"]

            new_template["property"]["model_name"] = default_model_data.bcmdl_path
            model_updater["type"] = "CMultiModelUpdaterComponent"
            model_updater["fields"] = {
                "empty_string": "",
                "root": "Root",
                "fields": {
                    "dctModels": {
                        name: model_data.get_data(name).bcmdl_path
                        for name in model_names
                    }
                }
            }
            model_updater["functions"] = []

            new_template["property"]["binaries"][:0] = [model_data.get_data(name).bmsas for name in model_names]

            actor.pComponents.MODELUPDATER["@type"] = "CMultiModelUpdaterComponent"
            actor.pComponents.MODELUPDATER.sModelAlias = model_names[0]

    def patch(self, editor: PatcherEditor):
        template_bmsad = _read_template_powerup()

        pickup_actor = self.pickup["pickup_actor"]
        pkgs_for_level = editor.get_level_pkgs(pickup_actor["scenario"])
        actor = editor.resolve_actor_reference(pickup_actor)

        new_template = copy.deepcopy(template_bmsad)
        new_template["name"] = f"randomizer_powerup_{self.pickup_id}"

        # Update model
        model_names: list[str] = self.pickup["model"]
        self.patch_model(editor, model_names, actor, new_template)

        # Update caption
        pickable = new_template["property"]["components"]["PICKABLE"]
        pickable["fields"]["fields"]["sOnPickCaption"] = self.pickup["caption"]
        pickable["fields"]["fields"]["sOnPickTankUnknownCaption"] = self.pickup["caption"]

        # Update given item
        if len(self.pickup["resources"]) == 1 and len(self.pickup["resources"][0]) == 1:
            new_template = self.patch_single_item_pickup(new_template)
        else:
            new_template = self.patch_multi_item_pickup(new_template)

        new_path = f"actors/items/randomizer_powerup/charclasses/randomizer_powerup_{self.pickup_id}.bmsad"
        editor.add_new_asset(new_path, Bmsad(new_template, editor.target_game), in_pkgs=pkgs_for_level)
        actor.oActorDefLink = f"actordef:{new_path}"

        # Powerup is in plain sight (except for the part we're using the sphere model)
        actor.pComponents.pop("LIFE", None)

        actor.bEnabled = True
        actor.pComponents.MODELUPDATER.bWantsEnabled = True

        # Dependencies
        for level_pkg in pkgs_for_level:
            editor.ensure_present(level_pkg, "system/animtrees/base.bmsat")

            for name in model_names:
                selected_model_data = model_data.get_data(name)
                editor.ensure_present(level_pkg, selected_model_data.bmsas)
                for dep in selected_model_data.dependencies:
                    editor.ensure_present(level_pkg, dep)

            editor.ensure_present(level_pkg, "actors/items/randomizer_powerup/scripts/randomizer_powerup.lc")


class ActorDefPickup(BasePickup):
    def _patch_actordef_pickup_script_help(self, editor: PatcherEditor):
        return self.lua_editor.patch_actordef_pickup_script(
            editor,
            self.pickup,
            self.pickup["pickup_lua_callback"],
        )

    def _patch_actordef_pickup(self, editor: PatcherEditor, item_id_field: str) -> tuple[str, Bmsad]:
        self._patch_actordef_pickup_script_help(editor)

        bmsad_path: str = self.pickup["pickup_actordef"]
        actordef = editor.get_file(bmsad_path, Bmsad)

        ai_component = actordef.raw["property"]["components"]["AI"]
        ai_component["fields"]["fields"][item_id_field] = "ITEM_NONE"

        patch_text(editor, self.pickup["pickup_string_key"], self.pickup["caption"])

        return bmsad_path, actordef

    def patch(self, editor: PatcherEditor):
        raise NotImplementedError()


_PICKUP_TYPE_TO_CLASS: dict[PickupType, type[BasePickup]] = {
    PickupType.ACTOR: ActorPickup,
}


def pickup_object_for(lua_scripts: LuaEditor, pickup: dict, pickup_id: int, configuration: dict) -> "BasePickup":
    pickup_type = PickupType(pickup["pickup_type"])
    return _PICKUP_TYPE_TO_CLASS[pickup_type](lua_scripts, pickup, pickup_id, configuration)