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
    "ITEM_WEAPON_SUPER_MISSILE": "RandomizerSuperMissile",
    "ITEM_SUPER_MISSILE_TANKS": "RandomizerSuperMissileTank",
    "ITEM_WEAPON_POWER_BOMB": "RandomizerPowerBomb",
    "ITEM_POWER_BOMB_TANKS": "RandomizerPowerBombTank",
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": "RandomizerScanningPulse",
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": "RandomizerEnergyShield",
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": "RandomizerEnergyWave",
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": "RandomizerPhaseDisplacement",
    "ITEM_ENERGY_TANKS": "RandomizerEnergyTank",
}

SPECIFIC_SOUNDS = {
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": "streams/music/special_ability2_32.wav",
    "ITEM_ENERGY_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_MAX_SPECIAL_ENERGY": "streams/music/tank_jingle.wav",
    "ITEM_SUPER_MISSILE_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_POWER_BOMB_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_WEAPON_MISSILE_MAX": "streams/music/tank_jingle.wav",
}

AREA_MAPPING = {
    "s000_surface": "s00",
    "s010_area1": "s01",
    "s020_area2": "s02",
    "s025_area2b": "s02",
    "s028_area2c": "s02",
    "s030_area3": "s03",
    "s033_area3b": "s03",
    "s036_area3c": "s03",
    "s040_area4": "s04",
    "s050_area5": "s04",
    "s060_area6": "s06",
    "s065_area6b": "s06",
    "s067_area6c": "s06",
    "s070_area7": "s07",
    "s090_area9": "s09",
    "s100_area10": "s10",
    "s110_surfaceb": "s00",
}


class LuaEditor:
    def __init__(self):
        self._item_classes = {}
        self._metroid_dict = {}
        self._dna_count_dict = {}
        self._hint_dict = {}
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
            f'{pickup["item_id"]}_{pickup["quantity"]}'
            for res in pickup_resources
            for pickup in res
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

    def _create_custom_init(self, configuration: dict) -> str:
        inventory: dict[str, int] = configuration["starting_items"]
        starting_location: dict = configuration["starting_location"]

        energy_per_tank = configuration["energy_per_tank"]
        max_life = inventory.pop("ITEM_MAX_LIFE")

        max_aeion = inventory.pop("ITEM_MAX_SPECIAL_ENERGY")

        # increase starting HP if starting with etanks
        if "ITEM_ENERGY_TANKS" in inventory:
            etanks = inventory.pop("ITEM_ENERGY_TANKS")
            max_life += etanks * energy_per_tank

        # These fields are required to start the game
        final_inventory = {
            "ITEM_MAX_LIFE": max_life,
            "ITEM_MAX_SPECIAL_ENERGY": max_aeion,
            "ITEM_WEAPON_MISSILE_MAX": 0,
            "ITEM_WEAPON_SUPER_MISSILE_MAX": 0,
            "ITEM_WEAPON_POWER_BOMB_MAX": 0,
            "ITEM_METROID_COUNT": 0,
            "ITEM_METROID_TOTAL_COUNT": 40,
        }
        final_inventory.update(inventory)

        replacement = {
            "new_game_inventory": final_inventory,
            "starting_scenario": lua_util.wrap_string(starting_location["scenario"]),
            "starting_actor": lua_util.wrap_string(starting_location["actor"]),
            "energy_per_tank": energy_per_tank,
            "reveal_map_on_start": configuration["reveal_map_on_start"],
            "dna_per_area": self._dna_count_dict,
            "area_mapping": {key: lua_util.wrap_string(value) for key, value in AREA_MAPPING.items()},
        }

        return lua_util.replace_lua_template("custom_init.lua", replacement)

    def _add_replacement_files(self, editor: PatcherEditor, configuration: dict):
        # Update init.lc
        lua_util.create_script_copy(editor, "system/scripts/init")
        editor.replace_asset(
            "system/scripts/init.lc",
            self._create_custom_init(configuration).encode("ascii"),
        )

        # Add custom lua files
        lua_util.replace_script(editor, "system/scripts/scenario", "custom_scenario.lua")
        lua_util.replace_script(editor, "actors/props/samusship/scripts/samusship", "custom_ship.lua")
        lua_util.replace_script(editor, "actors/props/savestation/scripts/savestation", "custom_savestation.lua")
        lua_util.replace_script(editor, "actors/props/heatzone/scripts/heatzone", "custom_heatzone.lua")

    def save_modifications(self, editor: PatcherEditor, configuration: dict):
        self._add_replacement_files(editor, configuration)

        # add new system script
        editor.add_new_asset(
            "system/scripts/guilib.lc",
            files_path().joinpath("guilib.lua").read_bytes(),
            []
        )

        # replace ensured scripts with the final code
        editor.replace_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc", self._powerup_script)

        final_metroid_script = lua_util.replace_lua_template("metroid_template.lua", {"mapping": self._metroid_dict})
        editor.replace_asset("actors/scripts/metroid.lc", final_metroid_script.encode("utf-8"))

        final_chozo_seal_script = lua_util.replace_lua_template("chozoseal_template.lua", {"mapping": self._hint_dict})
        editor.replace_asset("actors/props/chozoseal/scripts/chozoseal.lc", final_chozo_seal_script.encode("utf-8"))

        # replace all levels files with the custom ones
        for scenario, script in self._custom_level_scripts.items():
            editor.replace_asset(path_for_level(scenario) + ".lc", script["script"].encode("utf-8"))

    def add_metroid_pickup(self, metroid_callback: dict, lua_class: str) -> None:
        scenario = metroid_callback["scenario"]
        spawngroup = metroid_callback["spawngroup"]
        if scenario not in self._metroid_dict:
            self._metroid_dict[scenario] = {}
        scenario_list = self._metroid_dict[scenario]
        scenario_list[spawngroup] = lua_class

    def add_hint(self, hint: dict) -> None:
        actor_ref = hint["accesspoint_actor"]
        scenario = actor_ref["scenario"]
        actor = actor_ref["actor"]

        if scenario not in self._hint_dict:
            self._hint_dict[scenario] = {}

        scenario_list = self._hint_dict[scenario]
        # This takes an arbitrary long string. Each hint should be seperated with a \n.
        # Full text is splitted and then merged pairwise because we cannot show arbitrary long
        # strings in the game itself => Shows two hints per dialog box
        full_hint_text = hint["text"]
        splitted_hint = full_hint_text.split("\n")
        two_hints_list = [lua_util.wrap_string('\\n'.join(it)) for it in zip(splitted_hint[0::2], splitted_hint[1::2])]

        scenario_list[actor] = two_hints_list

    def add_dna(self, scenario: str) -> None:
        scenario_shortened: str = AREA_MAPPING[scenario]
        current_val = self._dna_count_dict.get(scenario_shortened, 0)
        self._dna_count_dict[scenario_shortened] = current_val + 1