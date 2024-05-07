from __future__ import annotations

import typing

from mercury_engine_data_structures.formats import Txt

if typing.TYPE_CHECKING:
    from open_samus_returns_rando.patcher_editor import PatcherEditor

ALL_TEXT_FILES = {
    "eu_dutch.txt",
    "eu_english.txt",
    "eu_french.txt",
    "eu_german.txt",
    "eu_italian.txt",
    "eu_portuguese.txt",
    "eu_spanish.txt",
    "japanese.txt",
    "mse_english.txt",
    "us_english.txt",
    "us_french.txt",
    "us_spanish.txt"
}


def patch_text(editor: PatcherEditor, key: str, value: str) -> None:
    for text_file in ALL_TEXT_FILES:
        text = editor.get_file(f"system/localization/{text_file}", Txt)
        text.strings[key] = value


def get_text(editor: PatcherEditor, key: str, text_file: str = "us_english.txt") -> str:
    text = editor.get_file(f"system/localization/{text_file}", Txt)
    return text.strings[key]


def apply_text_patches(editor: PatcherEditor, patches: dict[str, str]) -> None:
    for k, v in patches.items():
        patch_text(editor, k, v)


def add_spiderboost_status(editor: PatcherEditor) -> None:
    status = "GUI_STATUS_POWERBOMB"
    original = get_text(editor, status)
    new = original.replace(
        "one.",
        "one.|The Spider Boost can be used while in Spider Ball form. It will "
        "launch you forward, damaging enemies you make contact with.|It can also be used to reach certain items.",
    )
    patch_text(editor, status, new)
