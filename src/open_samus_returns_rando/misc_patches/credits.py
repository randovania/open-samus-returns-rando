
import re

from mercury_engine_data_structures.formats import Txt
from open_samus_returns_rando.patcher_editor import PatcherEditor

_PROJECT_MEMBERS = {
    "Project Leads": [
        "Dyceron",
        "Thanatos",
    ],
    "Game Patching": [
        "Henrique 'Darkszero' Gemignani",
        "duncathan_salt",
        "MeriKatt",
    ],
    "Logic Database": [
        "Miepee",
        "Haxaplax",
    ],
    "     ": [
        "With contributions from many others.",
    ]
}

def _create_randomizer_credits(spoiler_log: dict[str, str])  -> tuple[list[tuple[str, str]], int, int, int]:
    rando_credits: list[tuple[str, str]] = [
        ("Randomizer Credits", "CREDIT_TITLE"),
    ]

    for group, group_members in _PROJECT_MEMBERS.items():
        rando_credits.append((group, "CREDIT_SUBTITLE"))
        for member in group_members:
            rando_credits.append((member, "CREDIT_"))

    if spoiler_log:
        rando_credits.append(("     ", "CREDIT_SUBTITLE"))
        rando_credits.append(("Major Item Locations", "CREDIT_TITLE"))
        for item, loc in spoiler_log.items():
            rando_credits.append((item, "CREDIT_SUBTITLE"))
            rando_credits.append((loc, "CREDIT_"))

    rando_credits.append(("     ", "CREDIT_SUBTITLE"))

    amount_title = 0
    amount_subtitle = 0
    amount_credit = 0

    def new_sort(prefix: str, item: str) -> tuple[str, str]:
        nonlocal amount_title
        nonlocal amount_subtitle
        nonlocal amount_credit
        if prefix.startswith("CREDIT_TITLE"):
            amount_title = amount_title + 1
            return (f"{prefix}{amount_title}", item)
        elif prefix.startswith("CREDIT_SUBTITLE"):
            amount_subtitle = amount_subtitle + 1
            return (f"{prefix}{amount_subtitle}", item)
        else:
            amount_credit = amount_credit + 1
            return (f"{prefix}{amount_credit}", item)

    rando_credits = [
        new_sort(prefix, item)
        for item, prefix in rando_credits
    ]
    return rando_credits, amount_title, amount_subtitle, amount_credit


def patch_credits(editor: PatcherEditor, spoiler_log: dict[str, str]) -> None:
    english_files = [
        "system/localization/mse_english.txt",
    ]

    rando_credits, amount_title, amount_subtitle, amount_credit  = _create_randomizer_credits(spoiler_log)

    for file in english_files:
        text = editor.get_file(file, Txt)
        ordered_credits = list(text.strings.items())

        # suffix needs to be sorted per "type"
        for index, credit_tuple in enumerate(ordered_credits):
            title = re.findall(r'CREDIT_TITLE(\d+)', credit_tuple[0])
            if len(title) > 0:
                new_suffix = int(title[0]) + amount_title
                ordered_credits[index] = (f"CREDIT_TITLE{new_suffix}", credit_tuple[1])
                continue

            title = re.findall(r'CREDIT_SUBTITLE(\d+)', credit_tuple[0])
            if len(title) > 0:
                new_suffix = int(title[0]) + amount_subtitle
                ordered_credits[index] = (f"CREDIT_SUBTITLE{new_suffix}", credit_tuple[1])
                continue

            title = re.findall(r'CREDIT_(\d+)', credit_tuple[0])
            if len(title) > 0:
                new_suffix = int(title[0]) + amount_credit
                ordered_credits[index] = (f"CREDIT_{new_suffix}", credit_tuple[1])

        text.strings = dict(rando_credits + ordered_credits)
