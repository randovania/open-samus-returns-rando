from mercury_engine_data_structures.formats import Bmsmsd

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_tiles(editor: PatcherEditor):
    DOORS = {
        "s000_surface": ["Door004", "Door011"],
        "s010_area1": ["Door002", "Door004", "Door012", "Door016"],
        "s025_area2b": ["Door008"],
        "s028_area2c": ["Door001", "Door007"],
        "s030_area3": ["Door002", "Door005", "Door006", "Door008"],
        "s040_area4": ["Door001", "Door006", "Door014"],
        "s050_area5": ["Door006"],
        "s060_area6": ["Door001"],
        "s067_area6c": ["Door005", "Door006", "Door009"],
        "s070_area7": ["Door010"],
        "s090_area9": ["Door012"],
    }

    for area in ALL_AREAS:
        if area != "s110_surfaceb":
            scenario = editor.get_file(f"gui/minimaps/c10_samus/{area}.bmsmsd", Bmsmsd)
            tiles = scenario.raw["tiles"]
            for tile_idx in range(len(tiles)):
                current_tile = tiles[tile_idx]
                # Hazardous Tiles
                if current_tile["tile_type"] in {"ACID", "ACID_RISE", "ACID_FALL"}:
                    current_tile["tile_type"] = "NORMAL"

                # Items
                icons = current_tile["icons"]
                if len(icons) != 0 and (
                    icons[0]["icon"].endswith("tank")
                    or icons[0]["icon"].startswith("itemsphere")
                ):
                    if current_tile["tile_type"] == "HEAT":
                        icons[0]["icon"] = "itemenabledheat"
                    else:
                        icons[0]["icon"] = "itemenabled"

                for door in DOORS.get(area, []):
                    if len(icons) == 1 and icons[0]["actor_name"].startswith(door):
                        icons[0]["clear_condition"] = ""
                        if "left" in icons[0]["icon"]:
                            icons[0]["icon"] = "doorpowerleft"
                        else:
                            icons[0]["icon"] = "doorpowerright"
                    if len(icons) == 2 and icons[1]["actor_name"].startswith(door) and "left" in icons[1]["icon"]:
                        icons[1]["clear_condition"] = ""
                        icons[1]["icon"] = "doorpowerleft"
