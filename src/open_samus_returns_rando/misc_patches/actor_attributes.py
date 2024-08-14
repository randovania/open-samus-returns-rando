from mercury_engine_data_structures.formats import Bmsad
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_actor_attributes(editor: PatcherEditor, configuration: dict) -> None:
    _custom_baby_size(editor, configuration)


def _custom_baby_size(editor: PatcherEditor, configuration: dict) -> None:
    baby = editor.get_file("actors/characters/babyhatchling/charclasses/babyhatchling.bmsad", Bmsad)
    baby.raw["header"]["model_scale"] = configuration["babyhatchling"]["size"]
