from mercury_engine_data_structures.formats.bmtun import Bmtun

from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_tunables(editor: PatcherEditor, configuration: dict) -> None:
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    _patch_scan_pulse(tunables)
    _reserves_per_tank(tunables, configuration["reserves_per_tank"])
    _suit_reductions(tunables, configuration["suit_reductions"])


def _patch_scan_pulse(tunables: Bmtun) -> None:
    tunables.set_tunable("CTunableAbilityScanningPulse", "fConsumptionOnActivation", 0.0)


def _reserves_per_tank(tunables: Bmtun, configuration: dict) -> None:
    tunables.set_tunable("Amiibo|CTunableReserveTanks", "fLifeTankSize", configuration["life_tank_size"])
    tunables.set_tunable("Amiibo|CTunableReserveTanks", "fSETankSize", configuration["aeion_tank_size"])
    tunables.set_tunable("Amiibo|CTunableReserveTanks", "fMissileTankSize", configuration["missile_tank_size"])
    tunables.set_tunable(
        "Amiibo|CTunableReserveTanks", "fSuperMissileTankSize", configuration["super_missile_tank_size"]
    )


def _suit_reductions(tunables: Bmtun, configuration: dict) -> None:
    tunables.set_tunable(
        "Player|CTunablePlayerLifeComponent","fVariaSuitDamageMult", configuration["varia_suit_reduction"]
    )
    tunables.set_tunable(
        "Player|CTunablePlayerLifeComponent","fGravitySuitDamageMult", configuration["gravity_suit_reduction"]
    )
