from open_samus_returns_rando.patcher_editor import PatcherEditor

MULTI_ROOM_GAMMAS = [
    {
        "scenario": "s033_area3b",
        "layer": 4,
        "actor": "Gamma_004_A"
    },
    {
        "scenario": "s033_area3b",
        "layer": 4,
        "actor": "Gamma_004_Intro_A"
    },
    {
        "scenario": "s033_area3b",
        "layer": 4,
        "actor": "Gamma_004_C"
    },
    {
        "scenario": "s033_area3b",
        "layer": 4,
        "actor": "Gamma_004_Intro_C"
    },
    {
        "scenario": "s036_area3c",
        "layer": 4,
        "actor": "SP_Gamma_007_B"
    },
    {
        "scenario": "s036_area3c",
        "layer": 4,
        "actor": "SP_Gamma_007_Intro_B"
    },
    {
        "scenario": "s040_area4",
        "layer": 4,
        "actor": "SP_Gamma_001_B"
    },
    {
        "scenario": "s040_area4",
        "layer": 4,
        "actor": "SP_Gamma_001_Intro_B"
    },
    {
        "scenario": "s040_area4",
        "layer": 4,
        "actor": "SP_Gamma_001_C"
    },
    {
        "scenario": "s040_area4",
        "layer": 4,
        "actor": "SP_Gamma_001_Intro_C"
    },
    {
        "scenario": "s050_area5",
        "layer": 4,
        "actor": "Gamma_002_B"
    },
    {
        "scenario": "s050_area5",
        "layer": 4,
        "actor": "Gamma_002_Intro_B"
    },
    {
        "scenario": "s050_area5",
        "layer": 4,
        "actor": "Gamma_002_C"
    },
    {
        "scenario": "s050_area5",
        "layer": 4,
        "actor": "Gamma_002_Intro_C"
    },
]

def patch_multi_room_gammas(editor: PatcherEditor):
    for reference in MULTI_ROOM_GAMMAS:
            editor.remove_entity(reference)

def apply_static_fixes(editor: PatcherEditor):
      patch_multi_room_gammas(editor)
