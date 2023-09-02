from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.patcher_editor import PatcherEditor

_ELEVATOR_GRAPPLE_BLOCKS = [
    {
        # Area 4 West to Area 4 East
        "scenario": "s040_area4",
        "layer": 9,
        "actor": "LE_GrappleMov_001"
    },
    {
        # Area 5 to Area 6
        "scenario": "s060_area6",
        "layer": 9,
        "actor": "LE_GrappleMov_004"
    },
    {
        # Area 6 to Area 7
        "scenario": "s070_area7",
        "layer": 9,
        "actor": "LE_GrappleMov_001"
    },
    {
        # Area 7 to Area 8
        "scenario": "s090_area9",
        "layer": 9,
        "actor": "LE_GrappleMov_001"
    }
]

def apply_game_patches(editor: PatcherEditor, configuration: dict):

    if configuration["nerf_power_bombs"]:
        _remove_pb_weaknesses(editor)

    _remove_grapple_blocks(editor, configuration)

def _remove_pb_weaknesses(editor: PatcherEditor):
    # Charge Door
    for door in ["doorchargecharge", "doorclosedcharge"]:
        charge_door = editor.get_file(f"actors/props/{door}/charclasses/{door}.bmsad", Bmsad)
        func = charge_door.raw.components.LIFE.functions[0]
        if func.params.Param1.value:
            func.params.Param1.value = "CHARGE_BEAM"
        if func.params.Param2.value:
            func.params.Param2.value = "CHARGE_BEAM"

    # Beam Doors
    for door in ["doorwave", "doorspazerbeam", "doorcreature"]:
        beam_door = editor.get_file(f"actors/props/{door}/charclasses/{door}.bmsad", Bmsad)
        func_wp = beam_door.raw.components.LIFE.functions[1]
        func_s = beam_door.raw.components.LIFE.functions[2]
        if func_wp.params.Param1.value:
            if door == "doorwave":
                func_wp.params.Param1.value = "WAVE_BEAM"
            else:
                func_wp.params.Param1.value = "PLASMA_BEAM"
        if func_s.params.Param1.value:
            func_s.params.Param1.value = "SPAZER_BEAM"

def _remove_grapple_blocks(editor: PatcherEditor, configuration: dict):
    if configuration["remove_elevator_grapple_blocks"]:
        for reference in _ELEVATOR_GRAPPLE_BLOCKS:
            editor.remove_entity(reference)

    if configuration["remove_grapple_block_area3_interior_shortcut"]:
        editor.remove_entity(
            {
                "scenario": "s036_area3c",
                "layer": 9,
                "actor": "LE_GrappleDest_004"
            }
        )
