import typing

from construct import Container  # type: ignore[import-untyped]
from mercury_engine_data_structures.formats import Bmsad, Bmsbk, Bmssd

from open_samus_returns_rando.patcher_editor import PatcherEditor


def apply_game_patches(editor: PatcherEditor, configuration: dict) -> None:
    # Weapon patches
    _remove_pb_weaknesses(editor, configuration)

    if configuration["nerf_super_missiles"]:
        _remove_super_missile_weakness(editor)

    # Area patches
    _remove_grapple_blocks(editor, configuration)
    _patch_crumble_blocks(editor, configuration)
    _patch_reverse_area8(editor, configuration)


def _remove_pb_weaknesses(editor: PatcherEditor, configuration: dict) -> None:
    # Charge Door
    if configuration["charge_door_buff"]:
        for door in ["doorchargecharge", "doorclosedcharge"]:
            charge_door = editor.get_file(
                f"actors/props/{door}/charclasses/{door}.bmsad", Bmsad
            )
            func = charge_door.raw.components.LIFE.functions[0]
            if func.params.Param1.value:
                func.params.Param1.value = "CHARGE_BEAM"
            if func.params.Param2.value:
                func.params.Param2.value = "CHARGE_BEAM"

    # Beam Doors
    if configuration["beam_door_buff"]:
        for door in ["doorwave", "doorspazerbeam", "doorcreature"]:
            beam_door = editor.get_file(
                f"actors/props/{door}/charclasses/{door}.bmsad", Bmsad
            )
            func_wp = beam_door.raw.components.LIFE.functions[1]
            func_s = beam_door.raw.components.LIFE.functions[2]
            if func_wp.params.Param1.value:
                if door == "doorwave":
                    func_wp.params.Param1.value = "WAVE_BEAM"
                else:
                    func_wp.params.Param1.value = "PLASMA_BEAM"
            if func_s.params.Param1.value:
                func_s.params.Param1.value = "SPAZER_BEAM"

    # Blobthrowers/Steel Orbs
    if configuration["beam_burst_buff"]:
        PLANT_FILES = [
            "actors/characters/blobthrower/charclasses/blobthrower.bmsad",
            "actors/props/blockingplant/charclasses/blockingplant.bmsad",
        ]
        for plants in PLANT_FILES:
            plant = editor.get_file(plants, Bmsad)
            plant.raw["components"]["LIFE"]["fields"][
                "bShouldDieWithPowerBomb"
            ] = Container({"type": "bool", "value": False})


def _remove_grapple_blocks(editor: PatcherEditor, configuration: dict) -> None:
    ELEVATOR_GRAPPLE_BLOCKS = {
        # Area 4 West to Area 4 East
        "s040_area4": ["LE_GrappleMov_001"],
        # Area 6 to Area 7
        "s070_area7": ["LE_GrappleMov_001"],
        # Area 7 to Area 8
        "s090_area9": ["LE_GrappleMov_001"],
    }
    if configuration["remove_elevator_grapple_blocks"]:
        # Area 5 to Area 6
        editor.remove_entity(
            {"scenario": "s060_area6", "layer": 9, "actor": "LE_GrappleMov_004"}
        )
        for scenario_name, blocks in ELEVATOR_GRAPPLE_BLOCKS.items():
            scenario = editor.get_scenario(scenario_name)
            for block in blocks:
                actor = scenario.raw.actors[9][block]
                actor["position"][0] -= 100.0

    if configuration["remove_grapple_block_area3_interior_shortcut"]:
        editor.remove_entity(
            {"scenario": "s036_area3c", "layer": 9, "actor": "LE_GrappleDest_004"}
        )


def _remove_super_missile_weakness(editor: PatcherEditor) -> None:
    missile_door = editor.get_file(
        "actors/props/doorshieldmissile/charclasses/doorshieldmissile.bmsad", Bmsad
    )
    func = missile_door.raw.components.LIFE.functions[1]
    if func.params.Param1.value:
        func.params.Param1.value = "MISSILE"


def _patch_crumble_blocks(editor: PatcherEditor, configuration: dict) -> None:
    scenario_block_sg: dict[str, list[dict[str, typing.Any]]] = {
        # Crumble blocks after Scan Pulse
        "s000_surface": [
            {
                "block_group": 5,
                "cc_idx": 7,
                "entry_idx": 1,
                "sg_idx": 42,
                "vignette_models": [2950175714, 3474952711, 3638504308],
            },
        ],
        # Crumble blocks leaving Area 1
        "s010_area1": [
            {
                "block_group": 6,
                "cc_idx": 21,
                "entry_idx": 1,
                "sg_idx": 0,
                "vignette_models": [963224018, 1315868996, 2366773761, 2690707560, 3613901054],
            },
        ],
    }

    if configuration["patch_surface_crumbles"]:
        object_group = scenario_block_sg.get("s000_surface")
        scenario_name = "s000_surface"
        _update_blocks(editor, object_group, scenario_name)
    if configuration["patch_area1_crumbles"]:
        object_group = scenario_block_sg.get("s010_area1")
        scenario_name = "s010_area1"
        _update_blocks(editor, object_group, scenario_name)


def _update_blocks(editor: PatcherEditor, object_group: typing.Any, scenario_name: str) -> None:
    bmsbk = editor.get_file(f"maps/levels/c10_samus/{scenario_name}/{scenario_name}.bmsbk", Bmsbk)
    bmssd = editor.get_file(f"maps/levels/c10_samus/{scenario_name}/{scenario_name}.bmssd", Bmssd)
    for objects in object_group:
        # Disable the blocks
        bmsbk.raw["collision_cameras"][objects["cc_idx"]]["entries"].pop(objects["entry_idx"])
        # Remove the model to prevent it from loading
        models = bmssd.raw["scene_groups"][objects["sg_idx"]]["model_groups"][0]["models"]
        for vignette_model in objects["vignette_models"]:
            for idx, model in enumerate(models):
                if model["model_id"] == vignette_model:
                    models.pop(idx)


def _patch_reverse_area8(editor: PatcherEditor, configuration: dict) -> None:
    if configuration["reverse_area8"]:
        editor.remove_entity(
            {"scenario": "s100_area10", "layer": 9, "actor": "LE_ValveQueen"}
        )
