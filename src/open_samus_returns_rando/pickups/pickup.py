import copy
import functools
import json
from enum import Enum

from construct import Container, ListContainer  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsad, Bmsmsd, Lua
from mercury_engine_data_structures.formats.bmsmsd import TileType
from open_samus_returns_rando.constants import get_package_name
from open_samus_returns_rando.files import templates_path
from open_samus_returns_rando.logger import LOG
from open_samus_returns_rando.lua_editor import LuaEditor, ScriptClass
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level
from open_samus_returns_rando.pickups.model_data import get_data

RESERVE_TANK_ITEMS = {
    "ITEM_RESERVE_TANK_LIFE",
    "ITEM_RESERVE_TANK_MISSILE",
    "ITEM_RESERVE_TANK_SPECIAL_ENERGY",
}

TANK_MODELS = {
    "item_energytank",
    "item_senergytank",
    "item_missiletank",
    "item_supermissiletank",
    "item_powerbombtank",
}

MODELS_WITH_FX = {
    "powerup_scanningpulse",
    "powerup_energyshield",
    "powerup_energywave",
    "powerup_phasedisplacement",
    "adn",
    "itemsphere"
}

MODEL_TO_OFFSET = {
    "powerup_scanningpulse": 50,
    "powerup_energyshield": 50,
    "powerup_energywave": 50,
    "powerup_phasedisplacement": 50,
    "powerup_spiderball": 40,
    "item_energytank": 0,
    "item_senergytank": 0,
    "item_missiletank": 0,
    "item_supermissiletank": 0,
    "item_powerbombtank": 0,
    "adn": 50,
    "babyhatchling": 50,
}

OFFSET = Container({
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
def _read_template_powerup() -> dict:
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

    def patch(self, editor: PatcherEditor) -> None:
        raise NotImplementedError

    def get_scenario(self) -> str:
        raise NotImplementedError

class ActorPickup(BasePickup):
    _bmsad_dict: dict[int, tuple[str, ScriptClass]] = {}

    def patch_item_pickup(self, bmsad: dict) -> tuple[dict, ScriptClass]:
        pickable: dict = bmsad["components"]["PICKABLE"]
        script: dict = bmsad["components"]["SCRIPT"]

        set_custom_params: dict = pickable["functions"][0]["params"]
        set_custom_params["Param1"]["value"] = "ITEM_NONE"
        set_custom_params["Param2"]["value"] = 0

        script_class = self.lua_editor.create_script_class(
            self.pickup, actordef_id=bmsad["name"]
        )

        script["functions"][0]["params"]["Param1"]["value"] = script_class.get_lua_file_name()
        script["functions"][0]["params"]["Param2"]["value"] = script_class.class_name
        return bmsad, script_class

    def add_new_bmsad(self, editor: PatcherEditor, actordef_id: str, pkgs_for_level: set[str]) -> ScriptClass:
        template_bmsad = _read_template_powerup()
        new_template = copy.deepcopy(template_bmsad)
        new_template["name"] = actordef_id
        model_names: list[str] = self.pickup["model"]

        # Update model
        self.patch_model(model_names, new_template)

        # Update given item
        new_template, script_class = self.patch_item_pickup(new_template)

        new_path = script_class.get_bmsad_path()
        editor.add_new_asset(new_path, Bmsad(new_template, editor.target_game), in_pkgs=pkgs_for_level) # type: ignore
        return script_class


    def patch_model(self, model_names: list[str], bmsad: dict) -> None:
        MODELUPDATER = bmsad["components"]["MODELUPDATER"]
        item_id: str = self.pickup["resources"][0][0]["item_id"]
        model_name = model_names[0]
        y_offset = MODEL_TO_OFFSET.get(model_name, 20)
        if len(model_names) == 1:
            model_data = get_data(model_name)
            action_sets: dict = bmsad["action_sets"][0]["animations"][0]
            bmsad["header"]["model_name"] = model_data.bcmdl_path
            fx_create_and_link: dict = bmsad["components"]["FX"]["functions"][0]["params"]

            MODELUPDATER["functions"][0]["params"]["Param1"]["value"] = model_data.bcmdl_path
            # tank models
            if model_name in TANK_MODELS:
                action_sets["animation_id"] = 150
                action_sets["action"]["bcskla"] = "actors/items/itemtank/animations/relax.bcskla"
                if model_name != "item_energytank":
                    energytank_bcmdl = "actors/items/item_energytank/models/item_energytank.bcmdl"
                    MODELUPDATER["functions"][0]["params"]["Param2"]["value"] = energytank_bcmdl
                else:
                    MODELUPDATER["functions"][0]["params"].pop("Param2")
                # Placeholder until custom models/textures are made
                if item_id in RESERVE_TANK_ITEMS:
                    fx_create_and_link["Param1"]["value"] = "spinattack"
                    fx_create_and_link["Param2"]["value"] = "actors/characters/samus/fx/spinattack.bcptl"
                    fx_create_and_link["Param8"]["value"] = 55
                    fx_create_and_link["Param13"]["value"] = True
                else:
                    bmsad["components"].pop("FX")
            # if model uses fx, enable it and adjust position
            elif model_name in MODELS_WITH_FX:
                fx_create_and_link["Param8"]["value"] = y_offset
                fx_create_and_link["Param13"]["value"] = True
                bmsad["action_sets"] = ListContainer([])
                bmsad["components"].pop("ANIMATION")
                # aeion abilities
                if model_name not in {"adn", "itemsphere"}:
                    scanningpulse_bcmdl = "actors/items/powerup_scanningpulse/models/powerup_scanningpulse.bcmdl"
                    MODELUPDATER["functions"][0]["params"]["Param2"]["value"] = scanningpulse_bcmdl
                    bmsad["sound_fx"] = ListContainer([
                        ListContainer([
                            "generic/hability_projector.wav",
                            1
                        ])
                    ])
                    if model_name == "powerup_scanningpulse":
                        MODELUPDATER["functions"][0]["params"].pop("Param2")
                        fx_create_and_link["Param1"]["value"] = "orb"
                        fx_create_and_link["Param2"]["value"] = "actors/items/powerup_scanningpulse/fx/orb.bcptl"
                    elif model_name == "powerup_energyshield":
                        fx_create_and_link["Param1"]["value"] = "orb"
                        fx_create_and_link["Param2"]["value"] = "actors/items/powerup_energyshield/fx/orb.bcptl"
                    elif model_name == "powerup_energywave":
                        fx_create_and_link["Param1"]["value"] = "yelloworb"
                        fx_create_and_link["Param2"]["value"] = "actors/items/powerup_energywave/fx/yelloworb.bcptl"
                    else:
                        fx_create_and_link["Param1"]["value"] = "purpleorb"
                        fx_create_and_link["Param2"]["value"] = (
                            "actors/items/powerup_phasedisplacement/fx/purpleorb.bcptl"
                        )
                elif model_name == "adn":
                    MODELUPDATER["functions"][0]["params"].pop("Param2")
                    fx_create_and_link["Param1"]["value"] = "leak"
                    fx_create_and_link["Param2"]["value"] = "actors/items/adn/fx/adnleak.bcptl"
                    bmsad["sound_fx"] = ListContainer([
                        ListContainer([
                            "actors/samus/samus_dnascan.wav",
                            1
                        ])
                    ])
                else:
                    MODELUPDATER["functions"][0]["params"].pop("Param2")
                    fx_create_and_link["Param1"]["value"] = "itemparts"
                    fx_create_and_link["Param2"]["value"] = "actors/items/itemsphere/fx/itemsphereparts.bcptl"
                    bmsad["sound_fx"] = ListContainer([
                        ListContainer([
                            "generic/itemsphere_cracks.wav",
                            1
                        ])
                    ])
            elif model_name in {"babyhatchling", "powerup_spiderball"}:
                MODELUPDATER["functions"][0]["params"].pop("Param2")
                bmsad["components"].pop("FX")
                bmsad["sound_fx"] = ListContainer([])
            else:
                bmsad["components"].pop("FX")
                bmsad["sound_fx"] = ListContainer([])
        else:
            bmsad["components"].pop("FX")
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
        if model_name not in TANK_MODELS:
            MODELUPDATER["fields"] = OFFSET
            MODELUPDATER["fields"]["vInitPosWorldOffset"]["value"][1] = y_offset
            MODELUPDATER["fields"]["vInitAngWorldOffset"]["value"][0] = 0.0


    def patch(self, editor: PatcherEditor) -> None:
        actor_reference = self.pickup["pickup_actor"]
        actor_name = actor_reference["actor"]
        model_names: list[str] = self.pickup["model"]
        scenario_name: str = actor_reference['scenario']

        pkgs_for_level = set(editor.find_pkgs(path_for_level(self.pickup["pickup_actor"]["scenario"]) + ".bmsld"))
        scenario = editor.get_scenario(scenario_name)
        actor = next((layer[actor_name] for layer in scenario.raw.actors if actor_name in layer), None)
        if actor is None:
            raise KeyError(f"No actor named '{actor_name}' found in {scenario_name}")

        item_id = self.pickup["resources"][0][0]["item_id"]
        caption = self.pickup["caption"]
        key_for_dict = hash(f"{item_id}{caption}")
        cached_bmsad = self._bmsad_dict.get(key_for_dict, None)
        if cached_bmsad is None:
            actordef_id = f"randomizerpowerup{self.pickup_id}"
            script_class = self.add_new_bmsad(editor, actordef_id, pkgs_for_level)
            script_class.ensure_files(editor)
            self._bmsad_dict[key_for_dict] = (actordef_id, script_class)
        else:
            actordef_id = cached_bmsad[0]
            script_class = cached_bmsad[1]
            bmsad_path = script_class.get_bmsad_path()
            editor.ensure_present_in_scenario(scenario_name, bmsad_path)

        actor.type = actordef_id

        # special case for surface / surfaceb item
        if (
                actor_reference["scenario"] == "s000_surface" and
                (actor_name == "LE_Item_002" or actor_name == "LE_Item_003")
        ):
            surfaceb_name = "s110_surfaceb"
            surface_b = editor.get_scenario(surfaceb_name)
            mirrored_actor = next((layer[actor_name] for layer in surface_b.raw.actors if actor_name in layer), None)
            assert mirrored_actor is not None
            mirrored_actor.type = actordef_id
            path = script_class.get_bmsad_path()
            editor.ensure_present_in_scenario(surfaceb_name, path)
            pkgs_for_level.update(set(editor.find_pkgs(path_for_level(surfaceb_name) + ".bmsld")))

        script_class.ensure_files(editor)

        self.patch_minimap(editor, scenario_name, actor_name)

        # Dependencies
        for level_pkg in pkgs_for_level:
            for model_name in model_names:
                model_data = get_data(model_name)
                for dep in model_data.dependencies:
                    editor.ensure_present(get_package_name(level_pkg, dep), dep)


    def patch_minimap(self, editor: PatcherEditor, scenario_name: str, actor_name: str) -> None:
        if scenario_name != "s110_surfaceb":
            scenario_minimap = editor.get_file(f"gui/minimaps/c10_samus/{scenario_name}.bmsmsd", Bmsmsd)
        else:
            scenario_minimap = editor.get_file("gui/minimaps/c10_samus/s000_surface.bmsmsd", Bmsmsd)
        tiles = scenario_minimap.raw["tiles"]

        # find item tile
        tile_for_item = [
            x for x in tiles if len(x.icons) and next((y for y in x.icons if actor_name in y.actor_name), 0)
        ]

        if len(tile_for_item) == 1:
            pickup_tile_icon = next((y for y in tile_for_item[0].icons if "item" in y.icon), None)

            if not pickup_tile_icon:
                raise ValueError("No icon found")

            pickup_model = self.pickup["model"][0]

            # Custom blocks are no longer attached to the pickup, so make all hidden pickups consistent and generic
            if pickup_tile_icon.icon_priority == "HIDDEN_ITEM" or (
                # Boss pickups are now always visible on the map without fighting them, so make icons generic
                actor_name in {"LE_PowerUp_Springball", "LE_PowerUp_Powerbomb", "LE_Baby_Hatchling"}
            ):
                if tile_for_item[0]["tile_type"] == TileType.HEAT:
                    pickup_tile_icon.icon = "itemenabledheat"
                else:
                    pickup_tile_icon.icon = "itemenabled"
            # Powerups use a modified Samus helmet icon
            elif "powerup" in pickup_model or "babyhatchling" in pickup_model:
                pickup_tile_icon.icon = "item_powerup"
            # DNA uses a custom icon
            elif "adn" in pickup_model:
                pickup_tile_icon.icon = "item_adn"
            # Offworld powerups use the offworld model
            elif "offworld" in pickup_model:
                pickup_tile_icon.icon = "item_offworld"
            # Nothing items use an "updated" itemsphere icon so they update on the map
            elif "itemsphere" in pickup_model:
                pickup_tile_icon.icon = "item_nothing"
            else:
                # Tanks use their respective tank icon
                pickup_tile_icon.icon = pickup_model



    def get_scenario(self) -> str:
        return self.pickup["pickup_actor"]["scenario"]


class MetroidPickup(BasePickup):
    def patch(self, editor: PatcherEditor) -> None:
        script_class = self.lua_editor.create_script_class(self.pickup, f"metroid_{self.pickup_id}")
        script_class.ensure_files(editor)
        self.lua_editor.add_metroid_pickup(self.pickup["metroid_callback"], script_class)

    def get_scenario(self) -> str:
        return self.pickup["metroid_callback"]["scenario"]


def ensure_base_models(editor: PatcherEditor) -> None:
    for level_pkg in editor.get_all_level_pkgs():
        # ensure base stuff
        editor.ensure_present(get_package_name(level_pkg, "bmsat"), "system/animtrees/base.bmsat")
        editor.ensure_present(get_package_name(level_pkg, "bcwav"), "sounds/generic/obtencion.bcwav")

        # ensure itemsphere stuff (base for many majors)
        editor.ensure_present(get_package_name(level_pkg, "bcskla"), "actors/items/itemsphere/animations/relax.bcskla")
        model_data = get_data("itemsphere")
        for dep in model_data.dependencies:
            editor.ensure_present(get_package_name(level_pkg, dep), dep)

        # ensure energytank stuff (base for all tanks)
        editor.ensure_present(get_package_name(level_pkg, "bcskla"), "actors/items/itemtank/animations/relax.bcskla")
        model_data = get_data("item_energytank")
        for dep in model_data.dependencies:
            editor.ensure_present(get_package_name(level_pkg, dep), dep)

def count_dna(lua_scripts: LuaEditor, pickup_object: BasePickup) -> None:
    item_id = pickup_object.pickup["resources"][0][0]["item_id"]
    if item_id.startswith("ITEM_RANDO_DNA"):
        scenario: str = pickup_object.get_scenario()
        lua_scripts.add_dna(scenario)

def patch_pickups(
        editor: PatcherEditor, lua_scripts: LuaEditor, pickups_config: list[dict], configuration: dict
        ) -> None:
    ActorPickup._bmsad_dict = {}
    editor.add_new_asset(
        "actors/items/randomizerpowerup/scripts/randomizerpowerup.lc",
        Lua(Container(lua_text=templates_path().joinpath("randomizerpowerup.lua").read_text()), editor.target_game),
        []
    )
    editor.add_new_asset("actors/scripts/metroid.lc", b'', [])
    ensure_base_models(editor)

    for i, pickup in enumerate(pickups_config):
        LOG.debug("Writing pickup %d: %s", i, pickup["caption"])
        try:
            pickup_object = pickup_object_for(lua_scripts, pickup, i, configuration)
            pickup_object.patch(editor)
            count_dna(lua_scripts, pickup_object)
        except NotImplementedError as e:
            LOG.warning(e)

_PICKUP_TYPE_TO_CLASS: dict[PickupType, type[BasePickup]] = {
    PickupType.ACTOR: ActorPickup,
    PickupType.METROID: MetroidPickup,
}

def pickup_object_for(lua_scripts: LuaEditor, pickup: dict, pickup_id: int, configuration: dict) -> "BasePickup":
    pickup_type = PickupType(pickup["pickup_type"])
    return _PICKUP_TYPE_TO_CLASS[pickup_type](lua_scripts, pickup, pickup_id, configuration)
