import itertools

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level


def _read_powerup_lua() -> bytes:
    return files_path().joinpath("randomizer_powerup.lua").read_bytes()


def _read_level_lua(level_id: str) -> str:
    return files_path().joinpath("levels", f"{level_id}.lua").read_text()


SPECIFIC_CLASSES = {
    "ITEM_VARIA_SUIT": "RandomizerSuit",
    "ITEM_GRAVITY_SUIT": "RandomizerSuit",
    "ITEM_BABY_HATCHLING": "RandomizerBabyHatchling",
    "ITEM_WEAPON_SUPER_MISSILE_MAX": "RandomizerSuperMissile",
    "ITEM_RANDO_LOCKED_SUPERS": "RandomizerSuperMissileTank",
    "ITEM_WEAPON_POWER_BOMB_MAX": "RandomizerPowerBomb",
    "ITEM_RANDO_LOCKED_PBS": "RandomizerPowerBombTank",
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": "RandomizerScanningPulse",
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": "RandomizerEnergyShield",
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": "RandomizerEnergyWave",
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": "RandomizerPhaseDisplacement",
    "ITEM_ENERGY_TANKS": "RandomizerEnergyTank",
    "ITEM_AEION_TANKS": "RandomizerAeionTank",
}

SPECIFIC_SOUNDS = {
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": "streams/music/special_ability2_32.wav",
    "ITEM_ENERGY_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_AEION_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_RANDO_LOCKED_SUPERS": "streams/music/tank_jingle.wav",
    "ITEM_RANDO_LOCKED_PBS": "streams/music/tank_jingle.wav",
    "ITEM_WEAPON_MISSILE_MAX": "streams/music/tank_jingle.wav",
}


class LuaEditor:
    def __init__(self):
        self._item_classes = {}
        self._metroid_dict = {}
        self._powerup_script = _read_powerup_lua()
        self._custom_level_scripts: dict[str, dict] = self._read_levels()

    def _read_levels(self) -> dict[str, dict]:
        return {
            scenario: {"script": _read_level_lua(scenario), "edited": False}
            for scenario in ALL_AREAS
        }

    def get_parent_for(self, item_id) -> str:
        return SPECIFIC_CLASSES.get(item_id, "RandomizerPowerup")

    def get_script_class(self, pickup: dict, actordef_name: str = "") -> str:
        pickup_resources = pickup["resources"]
        first_item_id = pickup_resources[0][0]["item_id"]
        parent = self.get_parent_for(first_item_id)

        if actordef_name and len(pickup["model"]) > 1:
            self.add_progressive_models(pickup, actordef_name)

        hashable_progression = "_".join([
            f'{res[0]["item_id"]}_{res[0]["quantity"]}'
            for res in pickup_resources
        ]).replace("-", "MINUS")

        if hashable_progression in self._item_classes.keys():
            return self._item_classes[hashable_progression]

        class_name = f"RandomizerItem{hashable_progression}"

        resources = [
            [
                {
                    "item_id": lua_util.wrap_string(res["item_id"]),
                    "quantity": res["quantity"]
                }
                for res in resource_list
            ]
            for resource_list in pickup_resources
        ]
        sound = SPECIFIC_SOUNDS.get(first_item_id, "streams/music/sphere_jingle_placeholder.wav")
        replacement = {
            "name": class_name,
            "resources": resources,
            "parent": parent,
            "caption": lua_util.wrap_string(pickup["caption"].replace("\n", "\\n")),
            "sound": lua_util.wrap_string(sound),
        }

        self.add_item_class(replacement)
        self._item_classes[hashable_progression] = class_name

        return class_name

    def add_item_class(self, replacement):
        new_class = lua_util.replace_lua_template("randomizer_item_template.lua", replacement)
        self._powerup_script += new_class.encode("utf-8")

    def add_progressive_models(self, pickup: dict, actordef_name: str):
        progressive_models = [
            {
                "item": lua_util.wrap_string(resource["item_id"]),
                "alias": lua_util.wrap_string(model_name),
            }
            for resource, model_name in itertools.chain(
                zip([r[0] for r in pickup["resources"]], pickup["model"][0:])
            )
        ]

        replacement = {
            "actordef_name": actordef_name,
            "progressive_models": progressive_models,
        }

        models = lua_util.replace_lua_template("progressive_model_template.lua", replacement)
        self._powerup_script += models.encode("utf-8")

    def save_modifications(self, editor: PatcherEditor):
        final_metroid_script = lua_util.replace_lua_template("metroid_template.lua", {"mapping": self._metroid_dict})

        editor.replace_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc", self._powerup_script)
        editor.replace_asset("actors/scripts/metroid.lc", final_metroid_script.encode("utf-8"))
        editor.replace_asset("actors/props/heatzone/scripts/heatzone.lc",
                             files_path().joinpath("heatzone.lua").read_bytes())
        for scenario, script in self._custom_level_scripts.items():
            editor.replace_asset(path_for_level(scenario) + ".lc", script["script"].encode("utf-8"))

    def add_metroid_pickup(self, metroid_callback: dict, lua_class: str) -> None:
        scenario = metroid_callback["scenario"]
        spawngroup = metroid_callback["spawngroup"]
        if scenario not in self._metroid_dict:
            self._metroid_dict[scenario] = {}
        scenario_list = self._metroid_dict[scenario]
        scenario_list[spawngroup] = lua_class
