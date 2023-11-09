from mercury_engine_data_structures.formats import Bmsmsd
from mercury_engine_data_structures.formats.bmsmsd import TileType

from open_samus_returns_rando.constants import ALL_AREAS
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_tiles(editor: PatcherEditor):
    AREA_TO_DOORS = {
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
            doors = AREA_TO_DOORS.get(area, [])

            for tile_idx in range(len(tiles)):
                current_tile = tiles[tile_idx]

                icons = current_tile["icons"]
                if len(icons) != 0:
                    icons_length = icons[0] if len(icons) == 1 else icons[1]
                    # Items
                    if "tank" in icons_length["icon"] or "itemsphere" in icons_length["icon"]:
                        if current_tile["tile_type"] == TileType.HEAT:
                            icons_length["icon"] = "itemenabledheat"
                        else:
                            icons_length["icon"] = "itemenabled"

                    # Doors
                    for door in doors:
                        if door in icons_length["actor_name"]:
                            icons_length["clear_condition"] = ""
                            if "left" in icons_length["icon"]:
                                icons_length["icon"] = "doorpowerleft"
                            else:
                                icons_length["icon"] = "doorpowerright"
