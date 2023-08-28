from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.patcher_editor import PatcherEditor

def apply_game_patches(editor: PatcherEditor, configuration: dict):

    if configuration["nerf_power_bombs"]:
        _remove_pb_weaknesses(editor)

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