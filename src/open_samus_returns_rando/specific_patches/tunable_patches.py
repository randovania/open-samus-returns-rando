from mercury_engine_data_structures.formats.bmtun import Bmtun
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_tunables(editor: PatcherEditor, configuration: dict) -> None:
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    _patch_scan_pulse(tunables)
    _reserves_per_tank(tunables, configuration)


def _patch_scan_pulse(tunables: Bmtun) -> None:
    tunables.raw["classes"]["CTunableAbilityScanningPulse"]["tunables"][
        "fConsumptionOnActivation"
    ]["value"] = 0.0


def _reserves_per_tank(tunables: Bmtun, configuration: dict) -> None:
    amiibo = tunables.raw["classes"]["Amiibo|CTunableReserveTanks"]["tunables"]
    amiibo["fLifeTankSize"]["value"] = configuration["life_tank_size"]
    amiibo["fSETankSize"]["value"] = configuration["aeion_tank_size"]
    amiibo["fMissileTankSize"]["value"] = configuration["missile_tank_size"]
    amiibo["fSuperMissileTankSize"]["value"] = configuration["super_missile_tank_size"]
