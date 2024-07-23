import itertools
from collections.abc import Iterable

from construct import Container  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats.lua import Lua

from open_samus_returns_rando.constants import ALL_SCENARIOS
from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.misc_patches import lua_util
from open_samus_returns_rando.misc_patches.text_patches import patch_text
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level
from open_samus_returns_rando.specific_patches import cosmetic_patches


def _read_level_lua(level_id: str) -> str:
    return files_path().joinpath("levels", f"{level_id}.lua").read_text()

SPECIFIC_CLASSES = {
    "ITEM_VARIA_SUIT": "RandomizerSuit",
    "ITEM_GRAVITY_SUIT": "RandomizerSuit",
    "ITEM_BABY_HATCHLING": "RandomizerBabyHatchling",
    "ITEM_WEAPON_MISSILE_LAUNCHER": "RandomizerMissileLauncher",
    "ITEM_MISSILE_TANKS": "RandomizerMissileTank",
    "ITEM_WEAPON_SUPER_MISSILE": "RandomizerSuperMissile",
    "ITEM_SUPER_MISSILE_TANKS": "RandomizerSuperMissileTank",
    "ITEM_WEAPON_POWER_BOMB": "RandomizerPowerBomb",
    "ITEM_POWER_BOMB_TANKS": "RandomizerPowerBombTank",
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": "RandomizerScanningPulse",
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": "RandomizerEnergyShield",
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": "RandomizerEnergyWave",
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": "RandomizerPhaseDisplacement",
    "ITEM_ENERGY_TANKS": "RandomizerEnergyTank",
    "ITEM_RESERVE_TANK_LIFE": "RandomizerReserveTankE",
    "ITEM_RESERVE_TANK_MISSILE": "RandomizerReserveTankM",
    "ITEM_RESERVE_TANK_SPECIAL_ENERGY": "RandomizerReserveTankA",
}

SPECIFIC_SOUNDS = {
    "ITEM_SPECIAL_ENERGY_SCANNING_PULSE": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_ENERGY_WAVE": "streams/music/special_ability2_32.wav",
    "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT": "streams/music/special_ability2_32.wav",
    "ITEM_ENERGY_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_MAX_SPECIAL_ENERGY": "streams/music/tank_jingle.wav",
    "ITEM_MISSILE_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_SUPER_MISSILE_TANKS": "streams/music/tank_jingle.wav",
    "ITEM_POWER_BOMB_TANKS": "streams/music/tank_jingle.wav",
}

SCENARIO_MAPPING = {
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

def get_parent_for(item_id: str) -> str:
    return SPECIFIC_CLASSES.get(item_id, "RandomizerPowerup")

class ScriptClass:
    def __init__(
            self,
            class_name: str,
            actor_def_id: str,
            lua_content: str,
            lua_parent: str,
    ):
        self.class_name = class_name
        self.actor_def_name = actor_def_id
        self.lua_content = lua_content
        self.lua_parent =  lua_parent

    def get_lua_file_name(self) -> str:
        actor_def_lower = self.actor_def_name.lower()
        return f"actors/items/{actor_def_lower}/scripts/{actor_def_lower}.lc"

    def get_lua_parent_file_name(self) -> str:
        parent_lower = self.lua_parent.lower()
        return f"actors/items/{parent_lower}/scripts/{parent_lower}.lc"

    def get_bmsad_path(self) -> str:
        return f"actors/items/{self.actor_def_name}/charclasses/{self.actor_def_name}.bmsad"

    def ensure_files(self, editor: PatcherEditor) -> None:
        # ensure file itself
        lua_file_name = self.get_lua_file_name()
        # files are added to RomFS without package to make them globally accessible
        if not editor.does_asset_exists(lua_file_name):
            editor.add_new_asset(lua_file_name, Lua(Container(lua_text=self.lua_content), editor.target_game), [])

        # ensure parent file
        parent_file_name = self.get_lua_parent_file_name()
        if not editor.does_asset_exists(parent_file_name):
            parent_content = files_path().joinpath("pickups", f"{self.lua_parent.lower()}.lua").read_text()
            editor.add_new_asset(parent_file_name, Lua(Container(lua_text=parent_content), editor.target_game), [])


class LuaEditor:
    def __init__(self) -> None:
        self._item_classes: dict[str, ScriptClass] = {}
        self._metroid_dict: dict[str, dict[str, str]] = {}
        self._dna_count_dict: dict[str, int] = {}
        self._hint_dict: dict[str, dict[str, list[str]]] = {}
        self._progressive_models = ""
        self._custom_level_scripts: dict[str, dict] = self._read_levels()
        self._metroid_imports: list[str] = []

    def _read_levels(self) -> dict[str, dict]:
        return {
            scenario: {"script": _read_level_lua(scenario), "edited": False}
            for scenario in ALL_SCENARIOS
        }

    def create_script_class(self, pickup: dict, actordef_id: str = "") -> ScriptClass:
        pickup_resources = pickup["resources"]
        first_item_id = pickup_resources[0][0]["item_id"]
        parent = get_parent_for(first_item_id)
        model_array = pickup.get("model", None)

        if actordef_id and model_array and len(model_array) > 1:
            self.add_progressive_models(pickup, actordef_id)

        hashable_progression = "_".join([
            str(
                hash(f'{item_quantity["item_id"]}_{item_quantity["quantity"]}_{pickup["caption"]}')
            ).replace("-", "MINUS")
            for progressive_stage in pickup_resources
            for item_quantity in progressive_stage
        ])

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
        if "ITEM_RANDO_DNA" in first_item_id:
            sound = "streams/music/k_matad_jinchozo.wav"
        else:
            sound = SPECIFIC_SOUNDS.get(first_item_id, "streams/music/sphere_jingle_placeholder.wav")

        parent_file_name = f"actors/items/{parent.lower()}/scripts/{parent.lower()}.lc"
        replacement = {
            "name": class_name,
            "resources": resources,
            "parent": parent,
            "parent_lua": lua_util.wrap_string(parent_file_name),
            "caption": lua_util.wrap_string(pickup["caption"].replace("\n", "\\n")),
            "sound": lua_util.wrap_string(sound),
        }

        lua_content = lua_util.replace_lua_template("randomizer_item_template.lua", replacement)
        new_script_class = ScriptClass(class_name, actordef_id, lua_content, parent)
        self._item_classes[hashable_progression] = new_script_class

        return new_script_class

    def add_progressive_models(self, pickup: dict, actordef_name: str) -> None:
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
        self._progressive_models += models

    def _create_custom_init(self, editor: PatcherEditor, configuration: dict) -> str:
        inventory: dict[str, int] = configuration["starting_items"]
        starting_location: dict = configuration["starting_location"]
        starting_text: list[str] = configuration.get("starting_text", [])
        game_patches: dict = configuration["game_patches"]
        cosmetic_options: dict = configuration["cosmetic_patches"]
        configuration_identifier: str = configuration["configuration_identifier"]
        enable_remote_lua: bool = configuration.get("enable_remote_lua", False)

        energy_per_tank = configuration["energy_per_tank"]
        max_life = inventory.pop("ITEM_MAX_LIFE")

        max_aeion = inventory.pop("ITEM_MAX_SPECIAL_ENERGY")

        # increase starting HP if starting with etanks
        if "ITEM_ENERGY_TANKS" in inventory:
            etanks = inventory.pop("ITEM_ENERGY_TANKS")
            max_life += etanks * energy_per_tank

        # use _MAX if main is unlocked to unlock the ammo too
        LAUNCHER_TANK_MAPPING = [
            ("ITEM_WEAPON_MISSILE_LAUNCHER", "ITEM_MISSILE_TANKS"),
            ("ITEM_WEAPON_SUPER_MISSILE", "ITEM_SUPER_MISSILE_TANKS"),
            ("ITEM_WEAPON_POWER_BOMB", "ITEM_POWER_BOMB_TANKS"),
        ]
        for launcher, tanks in LAUNCHER_TANK_MAPPING:
            if launcher in inventory and inventory[launcher] > 0 and tanks in inventory:
                ammo_max = "ITEM_WEAPON_" + tanks[5:].replace("TANKS", "MAX")
                inventory[ammo_max] = inventory.pop(tanks)

        # These fields are required to start the game
        final_inventory = {
            "ITEM_MAX_LIFE": max_life,
            "ITEM_MAX_SPECIAL_ENERGY": max_aeion,
            "ITEM_WEAPON_MISSILE_MAX": 0,
            "ITEM_WEAPON_SUPER_MISSILE_MAX": 0,
            "ITEM_WEAPON_POWER_BOMB_MAX": 0,
            "ITEM_METROID_COUNT": 0,
            "ITEM_METROID_TOTAL_COUNT": 40,
            "ITEM_MISSILE_CHECK": max(1, inventory.get("ITEM_WEAPON_MISSILE_MAX", 0)),
        }
        final_inventory.update(inventory)

        # Use itertools batched when upgrading to python 3.12
        def chunks(array: list[str], n: int) -> Iterable[list[str]]:
            for i in range(0, len(array), n):
                yield array[i:i + n]

        textboxes = 0
        boxes = chunks(starting_text, 3)
        for box in boxes:
            textboxes += 1
            box_text = "|".join(box)
            patch_text(editor, f"RANDO_STARTING_TEXT_{textboxes}", box_text)


        layout_uuid = None
        if "layout_uuid" in configuration:
            layout_uuid = lua_util.wrap_string(configuration["layout_uuid"])


        baby_metroid_hint = lua_util.wrap_string("Continue searching for the Baby Metroid.")
        if "baby_metroid_hint" in configuration:
            baby_metroid_hint = lua_util.wrap_string(configuration["baby_metroid_hint"])

        replacement = {
            "new_game_inventory": final_inventory,
            "starting_scenario": lua_util.wrap_string(starting_location["scenario"]),
            "starting_actor": lua_util.wrap_string(starting_location["actor"]),
            "energy_per_tank": energy_per_tank,
            "reveal_map_on_start": configuration["reveal_map_on_start"],
            "dna_per_area": self._dna_count_dict,
            "scenario_mapping": {key: lua_util.wrap_string(value) for key, value in SCENARIO_MAPPING.items()},
            "textbox_count": textboxes,
            "configuration_identifier": lua_util.wrap_string(configuration_identifier),
            "enable_room_ids": False if cosmetic_options["enable_room_name_display"] == "NEVER" else True,
            "layout_uuid": layout_uuid,
            "enable_remote_lua": enable_remote_lua,
            "baby_metroid_hint": baby_metroid_hint,
            "tanks_refill_ammo": game_patches["tanks_refill_ammo"]
        }

        return lua_util.replace_lua_template("custom_init.lua", replacement)

    def _add_replacement_files(self, editor: PatcherEditor, configuration: dict) -> None:
        # Update init.lc
        lua_util.create_script_copy(editor, "system/scripts/init")

        init_script = self._create_custom_init(editor, configuration)
        editor.replace_asset(
            "system/scripts/init.lc",
            Lua(Container(lua_text=init_script), editor.target_game)
        )

        # Add custom lua files
        scenario_lua_content = files_path().joinpath("custom/scenario.lua").read_text()
        scenario_lua_content += "\n" + self._progressive_models
        lua_util.replace_script_with_content(editor, "system/scripts/scenario", scenario_lua_content)

        lua_util.replace_script(editor, "actors/characters/arachnus/scripts/arachnus", "custom/arachnus.lua")
        lua_util.replace_script(editor, "actors/props/samusship/scripts/samusship", "custom/ship.lua")
        lua_util.replace_script(editor, "actors/props/savestation/scripts/savestation", "custom/savestation.lua")
        lua_util.replace_script(editor, "actors/props/heatzone/scripts/heatzone", "custom/heatzone.lua")
        lua_util.replace_script(editor, "gui/scripts/sprites_splashes", "custom/sprites_splashes.lua")
        lua_util.replace_script(editor, "gui/scripts/sprites_texturehud", "custom/sprites_texturehud.lua")

    def save_modifications(self, editor: PatcherEditor, configuration: dict) -> None:
        self._add_replacement_files(editor, configuration)

        # add new system scripts
        editor.add_new_asset(
            "system/scripts/guilib.lc",
            Lua(Container(lua_text=files_path().joinpath("custom", "guilib.lua").read_text()), editor.target_game),
            []
        )

        editor.add_new_asset(
            "system/scripts/queue.lc",
            Lua(Container(lua_text=files_path().joinpath("custom", "queue.lua").read_text()), editor.target_game),
            []
        )

        cosmetics_script = cosmetic_patches.lua_cosmetics(configuration["cosmetic_patches"])
        editor.add_new_asset(
            "system/scripts/cosmetics.lc",
            Lua(Container(lua_text=cosmetics_script), editor.target_game),
            []
        )

        editor.add_new_asset(
            "system/scripts/room_names.lc",
            Lua(Container(lua_text=files_path().joinpath("custom", "room_names.lua").read_text()), editor.target_game),
            []
        )

        # replace ensured scripts with the final code
        final_metroid_script = lua_util.replace_lua_template("metroid_template.lua", {"mapping": self._metroid_dict})
        imports_in_metroid = [f'Game.ImportLibrary("{a_import}", false)' for a_import in self._metroid_imports]
        final_metroid_script = "\n".join(imports_in_metroid) + "\n" + final_metroid_script
        editor.replace_asset(
            "actors/scripts/metroid.lc",
            Lua(Container(lua_text=final_metroid_script), editor.target_game)
        )

        final_chozo_seal_script = lua_util.replace_lua_template("chozoseal_template.lua", {"mapping": self._hint_dict})
        editor.add_new_asset(
            "actors/props/chozoseal/scripts/chozoseal.lc",
            Lua(Container(lua_text=final_chozo_seal_script), editor.target_game),
            []
        )

        # replace all levels files with the custom ones
        for scenario, script in self._custom_level_scripts.items():
            editor.replace_asset(
                path_for_level(scenario) + ".lc",
                Lua(Container(lua_text=script["script"]), editor.target_game)
            )

    def add_metroid_pickup(self, metroid_callback: dict, script_class: ScriptClass) -> None:
        scenario = metroid_callback["scenario"]
        spawngroup = metroid_callback["spawngroup"]
        if scenario not in self._metroid_dict:
            self._metroid_dict[scenario] = {}
        scenario_list = self._metroid_dict[scenario]
        scenario_list[spawngroup] = script_class.class_name
        lua_file_name = script_class.get_lua_file_name()
        if lua_file_name not in self._metroid_imports:
            self._metroid_imports.append(script_class.get_lua_file_name())

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
        scenario_shortened: str = SCENARIO_MAPPING[scenario]
        current_val = self._dna_count_dict.get(scenario_shortened, 0)
        self._dna_count_dict[scenario_shortened] = current_val + 1
