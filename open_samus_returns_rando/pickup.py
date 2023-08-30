import copy
import logging
from enum import Enum

from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.lua_editor import LuaEditor
from open_samus_returns_rando.model_data import get_data
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level

LOG = logging.getLogger("pickup")

class PickupType(Enum):
    ACTOR = "actor"

class BasePickup:
    def __init__(self, lua_editor: LuaEditor, pickup: dict, pickup_id: int, configuration: dict):
        self.lua_editor = lua_editor
        self.pickup = pickup
        self.pickup_id = pickup_id
        self.configuration = configuration

    def patch(self, editor: PatcherEditor):
        raise NotImplementedError

# Note: MSR has a lot of customised Lua for Pickups. We maybe need to add them / take the logic into account?
class ActorPickup(BasePickup):
    def patch_single_item_pickup(self, bmsad: dict) -> dict:
        pickable = bmsad["components"]["PICKABLE"]
        script: dict = bmsad["components"]["SCRIPT"]

        item_id: str = self.pickup["resources"][0][0]["item_id"]
        quantity: float = self.pickup["resources"][0][0]["quantity"]
        set_custom_params: dict = pickable["functions"][0]["params"]

        if item_id == "ITEM_ENERGY_TANKS":
            item_id = "fMaxLife"
            quantity *= self.configuration["energy_per_tank"]
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fCurrentLife"
            set_custom_params["Param6"]["value"] = "LIFE"

        elif item_id == "ITEM_AEION_TANKS":
            item_id = "fMaxEnergy"
            quantity *= self.configuration["aeion_per_tank"]
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fEnergy"
            set_custom_params["Param6"]["value"] = "SPECIALENERGY"

        set_custom_params["Param1"]["value"] = item_id
        set_custom_params["Param2"]["value"] = quantity

        script["functions"][0]["params"]["Param1"]["value"] = \
            'actors/items/randomizer_powerup/scripts/randomizer_powerup.lc'
        script["functions"][0]["params"]["Param2"]["value"] = self.lua_editor.get_script_class(self.pickup,
                                                                                               actordef_name=bmsad[
                                                                                                   "name"])
        return bmsad


    def patch_multi_item_pickup(self, bmsad: dict) -> dict:
        pickable: dict = bmsad["components"]["PICKABLE"]
        script: dict = bmsad["components"]["SCRIPT"]

        set_custom_params: dict = pickable["functions"][0]["params"]
        # FIXME: Better would be a nothing item but the game is crashing if you pick up a second progressive when
        # it tries to show the item on the inventory screen. Now it always shows the first progressive.
        set_custom_params["Param1"]["value"] = self.pickup["resources"][0][0]["item_id"]
        set_custom_params["Param2"]["value"] = 0

        script["functions"][0]["params"]["Param1"]["value"] = \
            'actors/items/randomizer_powerup/scripts/randomizer_powerup.lc'
        script["functions"][0]["params"]["Param2"]["value"] = self.lua_editor.get_script_class(self.pickup,
                                                                                               actordef_name=bmsad[
                                                                                                   "name"])

        return bmsad

    def patch_model(self, editor: PatcherEditor, model_names: list[str], new_template: dict):
        # TODO: Add MulitModel / Progressive model logic
        model_data = get_data(model_names[0])
        new_template["model_name"] = model_data.bcmdl_path
        MODELUPDATER = new_template["components"]["MODELUPDATER"]
        MODELUPDATER["functions"][0]["params"]["Param1"]["value"] = model_data.bcmdl_path


    def patch(self, editor: PatcherEditor):
        template_bmsad = editor.get_parsed_asset(
            "actors/items/powerup_spiderball/charclasses/powerup_spiderball.bmsad"
            ).raw

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
        self.patch_model(editor, model_names, new_template)

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
        model_data = get_data(model_names[0])
        for level_pkg in pkgs_for_level:
            editor.ensure_present(level_pkg, "system/animtrees/base.bmsat")
            editor.ensure_present(level_pkg, "actors/items/randomizer_powerup/scripts/randomizer_powerup.lc")
            for dep in model_data.dependencies:
                editor.ensure_present(level_pkg, dep)

        # TODO: Add BMSAS :( ?

        # For debugging, write the bmsad we just created
        # Path("custom_bmsad", f"randomizer_powerup_{i}.bmsad.json").write_text(
        #     json.dumps(new_template, indent=4)
        # )



def patch_pickups(editor: PatcherEditor, lua_scripts: LuaEditor, pickups_config: list[dict], configuration: dict):
    editor.add_new_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc", b'', [])

    for i, pickup in enumerate(pickups_config):
        LOG.debug("Writing pickup %d: %s", i, pickup["caption"])
        try:
            pickup_object_for(lua_scripts, pickup, i, configuration).patch(editor)
        except NotImplementedError as e:
            LOG.warning(e)


_PICKUP_TYPE_TO_CLASS: dict[PickupType, type[BasePickup]] = {
    PickupType.ACTOR: ActorPickup,
}

def pickup_object_for(lua_scripts: LuaEditor, pickup: dict, pickup_id: int, configuration: dict) -> "BasePickup":
    pickup_type = PickupType(pickup["pickup_type"])
    return _PICKUP_TYPE_TO_CLASS[pickup_type](lua_scripts, pickup, pickup_id, configuration)
