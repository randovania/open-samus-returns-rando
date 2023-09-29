

from mercury_engine_data_structures.formats.bmtun import Bmtun

from open_samus_returns_rando.patcher_editor import PatcherEditor


def _patch_scanning_pulse(tunables: Bmtun):
    # # does nothing :(
    # ctunableminimap = tunables.raw["classes"]["CTunableMinimapScenario"]["tunables"]
    # ctunableminimap["iScanningPulseRadiusInTiles"]["value"] = 200
    tunables.raw["classes"]["CTunableAbilityScanningPulse"]["tunables"]["fConsumptionOnActivation"]["value"] = 0.0


def patch_tunables(editor: PatcherEditor):
    tunables = editor.get_file("system/tunables/tunables.bmtun", Bmtun)
    _patch_scanning_pulse(tunables)
