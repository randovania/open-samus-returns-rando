from mercury_engine_data_structures.formats import Bmsad, Bmsbk

from open_samus_returns_rando.patcher_editor import PatcherEditor

_ELEVATOR_GRAPPLE_BLOCKS = [
    {
        # Area 4 West to Area 4 East
        "scenario": "s040_area4",
        "layer": 9,
        "actor": "LE_GrappleMov_001",
    },
    {
        # Area 5 to Area 6
        "scenario": "s060_area6",
        "layer": 9,
        "actor": "LE_GrappleMov_004",
    },
    {
        # Area 6 to Area 7
        "scenario": "s070_area7",
        "layer": 9,
        "actor": "LE_GrappleMov_001",
    },
    {
        # Area 7 to Area 8
        "scenario": "s090_area9",
        "layer": 9,
        "actor": "LE_GrappleMov_001",
    },
]


def apply_game_patches(editor: PatcherEditor, configuration: dict):
    # Weapon patches
    if configuration["nerf_power_bombs"]:
        _remove_pb_weaknesses(editor)

    if configuration["nerf_super_missiles"]:
        _remove_super_missile_weakness(editor)

    # Area patches
    _remove_grapple_blocks(editor, configuration)
    _patch_crumble_blocks(editor, configuration)
    _patch_reverse_area8(editor, configuration)


def _remove_pb_weaknesses(editor: PatcherEditor):
    # Charge Door
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


def _remove_grapple_blocks(editor: PatcherEditor, configuration: dict):
    if configuration["remove_elevator_grapple_blocks"]:
        for reference in _ELEVATOR_GRAPPLE_BLOCKS:
            editor.remove_entity(reference)

    if configuration["remove_grapple_block_area3_interior_shortcut"]:
        editor.remove_entity(
            {"scenario": "s036_area3c", "layer": 9, "actor": "LE_GrappleDest_004"}
        )


def _remove_super_missile_weakness(editor: PatcherEditor):
    missile_door = editor.get_file(
        "actors/props/doorshieldmissile/charclasses/doorshieldmissile.bmsad", Bmsad
    )
    func = missile_door.raw.components.LIFE.functions[1]
    if func.params.Param1.value:
        func.params.Param1.value = "MISSILE"


def _patch_crumble_blocks(editor: PatcherEditor, configuration: dict):
    # Crumble blocks after Scan Pulse
    if configuration["patch_surface_crumbles"]:
        surface = editor.get_file(
            "maps/levels/c10_samus/s000_surface/s000_surface.bmsbk", Bmsbk
        )
        post_scan_pulse_crumbles = surface.raw["block_groups"][37]
        post_scan_pulse_crumbles["types"][0]["block_type"] = "power_beam"
        post_scan_pulse_crumbles["types"][0]["blocks"][0]["respawn_time"] = 0.0
        post_scan_pulse_crumbles["types"][0]["blocks"][1]["respawn_time"] = 0.0
        post_scan_pulse_crumbles["types"][0]["blocks"][2]["respawn_time"] = 0.0

    # Crumble blocks leaving Area 1
    if configuration["patch_area1_crumbles"]:
        area1 = editor.get_file(
            "maps/levels/c10_samus/s010_area1/s010_area1.bmsbk", Bmsbk
        )
        area1_chozo_seal_crumbles = area1.raw["block_groups"][19]
        area1_chozo_seal_crumbles["types"][0]["block_type"] = "power_beam"
        area1_chozo_seal_crumbles["types"][0]["blocks"][0]["respawn_time"] = 0.0
        area1_chozo_seal_crumbles["types"][0]["blocks"][1]["respawn_time"] = 0.0
        area1_chozo_seal_crumbles["types"][0]["blocks"][2]["respawn_time"] = 0.0
        area1_chozo_seal_crumbles["types"][0]["blocks"][3]["respawn_time"] = 0.0
        area1_chozo_seal_crumbles["types"][0]["blocks"][4]["respawn_time"] = 0.0


def _patch_reverse_area8(editor: PatcherEditor, configuration: dict):
    if configuration["reverse_area8"]:
        editor.remove_entity(
            {"scenario": "s100_area10", "layer": 9, "actor": "LE_ValveQueen"}
        )
