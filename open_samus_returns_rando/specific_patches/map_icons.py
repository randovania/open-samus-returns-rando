from mercury_engine_data_structures.formats import Bmsmsd

from open_samus_returns_rando.patcher_editor import PatcherEditor


def _surface_icons(editor: PatcherEditor):
    surface = editor.get_file("gui/minimaps/c10_samus/s000_surface.bmsmsd", Bmsmsd)
    mapicon = surface.raw["tiles"]

    # Doors
    # Door004, Door011 (Chozo Seal Charge Doors)
    mapicon[99]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[100]["icons"][0]["icon"] = "doorpowerright"

    mapicon[57]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[58]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(479):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] == "ACID":
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and (
            mapicon[tile]["icons"][0]["icon"].endswith("tank")
            or mapicon[tile]["icons"][0]["icon"].startswith("itemsphere")
            or mapicon[tile]["icons"][0]["icon"].startswith("spenergy")
        ):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area1_icons(editor: PatcherEditor):
    area1 = editor.get_file("gui/minimaps/c10_samus/s010_area1.bmsmsd", Bmsmsd)
    mapicon = area1.raw["tiles"]

    # Doors
    # Door002 (Chozo Seal Charge Door)
    mapicon[77]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[78]["icons"][0]["icon"] = "doorpowerright"

    # Door004 (Bombs)
    mapicon[194]["icons"][0]["icon"] = "doorpowerleft"

    # Door012 (Right Exterior Door -> Interior)
    mapicon[266]["icons"][0]["clear_condition"] = ""
    mapicon[267]["icons"][0]["icon"] = "doorpowerright"

    # Door016 (Exterior Alpha)
    mapicon[302]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(384):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] == "ACID":
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"
    mapicon[158]["icons"][0]["icon"] = "itemenabledheat"


def _area2_icons(editor: PatcherEditor):
    area2 = editor.get_file("gui/minimaps/c10_samus/s020_area2.bmsmsd", Bmsmsd)
    mapicon = area2.raw["tiles"]

    # Items
    for tile in range(310):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area2b_icons(editor: PatcherEditor):
    area2b = editor.get_file("gui/minimaps/c10_samus/s025_area2b.bmsmsd", Bmsmsd)
    mapicon = area2b.raw["tiles"]

    # Doors
    # Door008 (Below Wave Beam)
    mapicon[152]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[153]["icons"][0]["clear_condition"] = ""

    # Items
    for tile in range(160):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"
    mapicon[88]["icons"][0]["icon"] = "itemenabledheat"


def _area2c_icons(editor: PatcherEditor):
    area2c = editor.get_file("gui/minimaps/c10_samus/s028_area2c.bmsmsd", Bmsmsd)
    mapicon = area2c.raw["tiles"]

    # Doors
    # Door001, Door007 (Chozo Seal Charge Doors)
    mapicon[50]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[51]["icons"][0]["icon"] = "doorpowerright"

    mapicon[32]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[33]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(116):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] == "ACID":
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and (
            mapicon[tile]["icons"][0]["icon"].startswith("item")
            or mapicon[tile]["icons"][0]["icon"].startswith("spenergy")
        ):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area3_icons(editor: PatcherEditor):
    area3 = editor.get_file("gui/minimaps/c10_samus/s030_area3.bmsmsd", Bmsmsd)
    mapicon = area3.raw["tiles"]

    # Doors
    # Door002, Door008 (Chozo Seal Charge Doors)
    mapicon[54]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[55]["icons"][0]["icon"] = "doorpowerright"

    mapicon[2]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[3]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(300):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] == "ACID":
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and (
            mapicon[tile]["icons"][0]["icon"].startswith("item")
            or mapicon[tile]["icons"][0]["icon"].startswith("spenergy")
        ):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area3b_icons(editor: PatcherEditor):
    area3b = editor.get_file("gui/minimaps/c10_samus/s033_area3b.bmsmsd", Bmsmsd)
    mapicon = area3b.raw["tiles"]

    # Items
    for tile in range(323):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area3c_icons(editor: PatcherEditor):
    area3c = editor.get_file("gui/minimaps/c10_samus/s036_area3c.bmsmsd", Bmsmsd)
    mapicon = area3c.raw["tiles"]

    # Items
    for tile in range(150):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area4_icons(editor: PatcherEditor):
    area4 = editor.get_file("gui/minimaps/c10_samus/s040_area4.bmsmsd", Bmsmsd)
    mapicon = area4.raw["tiles"]

    # Doors
    # Door001 (Chozo Seal Spazer Door)
    mapicon[161]["icons"][1]["icon"] = "doorspazerleft"

    # Door006 (Chozo Seal Charge Door)
    mapicon[141]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[142]["icons"][0]["icon"] = "doorpowerright"

    # Door014 (The Big Gap Charge Door)
    mapicon[2]["icons"][1]["icon"] = "doorpowerleft"
    mapicon[3]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(285):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] in {"ACID", "ACID_FALL"}:
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area5_icons(editor: PatcherEditor):
    area5 = editor.get_file("gui/minimaps/c10_samus/s050_area5.bmsmsd", Bmsmsd)
    mapicon = area5.raw["tiles"]

    # Doors
    # Door006 (Elevator Charge Door)
    mapicon[100]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[101]["icons"][0]["icon"] = "doorpowerright"

    # Items
    for tile in range(296):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"
    mapicon[213]["icons"][0]["icon"] = "itemenabledheat"


def _area6_icons(editor: PatcherEditor):
    area6 = editor.get_file("gui/minimaps/c10_samus/s060_area6.bmsmsd", Bmsmsd)
    mapicon = area6.raw["tiles"]

    # Doors
    # Door001 (Entrance Charge Door)
    mapicon[14]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[15]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(226):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] == "ACID":
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and (
            mapicon[tile]["icons"][0]["icon"].startswith("item")
            or mapicon[tile]["icons"][0]["icon"].startswith("spenergy")
        ):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area6b_icons(editor: PatcherEditor):
    area6b = editor.get_file("gui/minimaps/c10_samus/s065_area6b.bmsmsd", Bmsmsd)
    mapicon = area6b.raw["tiles"]

    # Items
    for tile in range(290):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area6c_icons(editor: PatcherEditor):
    area6c = editor.get_file("gui/minimaps/c10_samus/s067_area6c.bmsmsd", Bmsmsd)
    mapicon = area6c.raw["tiles"]

    # Doors
    # Door005 (Plasma Beam Missile Door)
    mapicon[32]["icons"][0]["icon"] = "doorpowerleft"

    # Door006 (Plasma Beam Plasma Door)
    mapicon[35]["icons"][0]["icon"] = "doorpowerleft"

    # Door009 (Gravity Suit Missile Door)
    mapicon[149]["icons"][0]["icon"] = "doorpowerleft"

    # Items
    for tile in range(212):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area7_icons(editor: PatcherEditor):
    area7 = editor.get_file("gui/minimaps/c10_samus/s070_area7.bmsmsd", Bmsmsd)
    mapicon = area7.raw["tiles"]

    # Doors
    # Door010 (Pre-Steal Charge Door)
    mapicon[273]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[274]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(351):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] in {"ACID", "ACID_RISE", "ACID_FALL"}:
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area9_icons(editor: PatcherEditor):
    area9 = editor.get_file("gui/minimaps/c10_samus/s090_area9.bmsmsd", Bmsmsd)
    mapicon = area9.raw["tiles"]

    # Doors
    # Door012 (Chozo Seal Charge Door)
    mapicon[89]["icons"][0]["icon"] = "doorpowerleft"
    mapicon[90]["icons"][0]["icon"] = "doorpowerright"

    for tile in range(387):
        # Hazardous Tiles
        if mapicon[tile]["tile_type"] == "ACID":
            mapicon[tile]["tile_type"] = "NORMAL"
        # Items
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def _area10_icons(editor: PatcherEditor):
    area10 = editor.get_file("gui/minimaps/c10_samus/s100_area10.bmsmsd", Bmsmsd)
    mapicon = area10.raw["tiles"]

    # Items
    for tile in range(339):
        if mapicon[tile]["icons"] != ([]) and mapicon[tile]["icons"][0][
            "icon"
        ].startswith("item"):
            mapicon[tile]["icons"][0]["icon"] = "itemenabled"


def update_map_icons(editor: PatcherEditor):
    _surface_icons(editor)
    _area1_icons(editor)
    _area2_icons(editor)
    _area2b_icons(editor)
    _area2c_icons(editor)
    _area3_icons(editor)
    _area3b_icons(editor)
    _area3c_icons(editor)
    _area4_icons(editor)
    _area5_icons(editor)
    _area6_icons(editor)
    _area6b_icons(editor)
    _area6c_icons(editor)
    _area7_icons(editor)
    _area9_icons(editor)
    _area10_icons(editor)
