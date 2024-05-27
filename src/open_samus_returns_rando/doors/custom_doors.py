import typing

from construct import Container, ListContainer
from mercury_engine_data_structures.formats import Bmsad, Bmsmsd
from mercury_engine_data_structures.formats.bmsmsd import IconPriority, TileBorders
from open_samus_returns_rando.patcher_editor import PatcherEditor


def add_custom_doors(editor: PatcherEditor, custom_doors: list[dict]) -> None:
    template_door = editor.get_scenario("s000_surface").raw.actors[15]["Door001"]

    for door in custom_doors:
        scenario_name = door["door_actor"]["scenario"]
        scenario_file = editor.get_scenario(scenario_name)
        scenario_map = editor.get_file(f"gui/minimaps/c10_samus/{scenario_name}.bmsmsd", Bmsmsd)

        door_name = door["door_actor"]["actor"]
        door_position = [door["position"]["x"], door["position"]["y"], door["position"]["z"]]

        editor.copy_actor(scenario_name, door_position, template_door, door_name, 15)

        direction = door["direction"]
        actor_name = door_name + direction
        icon = "doorpower" + direction
        border = TileBorders.RIGHT if direction == "left" else TileBorders.LEFT

        DOOR_ICON = Container({
            "actor_name": actor_name,
            "clear_condition": "",
            "icon": icon,
            "icon_priority": IconPriority.DOOR,
            "coordinates": ListContainer(door_position),
        })

        tile_idx = scenario_map.raw["tiles"][door["tile_index"]]
        # Add the tile border to the tile_borders dict so the doors tiles can properly update
        tile_idx["tile_borders"][border] = True

        # Add the tile icon
        if tile_idx["icons"] is None:
            tile_idx["icons"] = ListContainer([DOOR_ICON])
        elif len(tile_idx["icons"]) < 2:
            # The game crashes if there are more than two icons listed per tile, so exclude the second door
            tile_idx["icons"].append(DOOR_ICON)

        scenario_file.add_actor_to_entity_groups(door["entity_group"], door_name, True)


class NewShield(typing.NamedTuple):
    shield_name: str
    weakness: str
    base_shield: str


new_shields = [
    NewShield("beamburst", "WEAPON_BOOST", "doorshieldpowerbomb"),
    NewShield("bomb", "BOMB", "doorshieldsupermissile"),
    NewShield("grapplebeam", "GRAPPLE_BEAM", "doorshield"),
    NewShield("icebeam", "ICE_BEAM", "doorcreature"),
    NewShield("locked", "", "doorspazerbeam"),
]


def add_custom_shields(editor: PatcherEditor, new_shield: NewShield) -> None:
    # Missile shields are split across doorshield and doorshieldmissile
    if new_shield.base_shield == "doorshield":
        template_bmsad = "actors/props/doorshieldmissile/charclasses/doorshieldmissile.bmsad"
    else:
        template_bmsad = f"actors/props/{new_shield.base_shield}/charclasses/{new_shield.base_shield}.bmsad"

    new_model = f"actors/props/doorshield{new_shield.shield_name}/models/doorshield{new_shield.shield_name}.bcmdl"
    new_bmsad = f"actors/props/doorshield{new_shield.shield_name}/charclasses/doorshield{new_shield.shield_name}.bmsad"

    # Create a copy of the bmsad
    template_shield = editor.get_file(template_bmsad, Bmsad)
    editor.add_new_asset(new_bmsad, template_shield, [])

    # Modify the new bmsad
    custom_shield = editor.get_file(new_bmsad, Bmsad)
    custom_shield.name = f"doorshield{new_shield.shield_name}"
    custom_shield.raw["header"]["model_name"] = new_model
    custom_shield.components["MODELUPDATER"].functions[0].params["Param1"]["value"] = new_model

    # Update the life component
    life_component = custom_shield.raw["components"]["LIFE"]["functions"]
    # Change the weaknesses for each door
    for damage_source in life_component:
        if damage_source["name"] == "AddDamageSource":
            damage_source["params"]["Param1"]["value"] = new_shield.weakness
    if new_shield.base_shield == "doorcreature":
        # Set shield health to 1
        life_component[2]["params"]["Param2"]["value"] = 1.0
        life_component[3]["params"]["Param2"]["value"] = 1.0
        # Remove the drops from breaking the shield
        custom_shield.raw["components"].pop("DROP")
        # Remove the particle animation that occurs after the shield breaks (color mismatch)
        custom_shield.raw["action_sets"][0]["animations"][0]["events0"][1]["args"]["LinkType"]["value"] = 0
    elif new_shield.base_shield in {"doorshieldsupermissile", "doorshieldpowerbomb"}:
        # Some shaders do not use dissolve fx, so force fx to be used
        custom_shield.raw["components"]["LIFE"]["fields"]["bDisolveByMaterial"]["value"] = False
        custom_shield.raw["components"]["LIFE"]["fields"]["fTimeToStartDisolve"]["value"] = 0.2


def patch_custom_doors(editor: PatcherEditor, custom_doors: list[dict]):
    add_custom_doors(editor, custom_doors)
    for new_shield in new_shields:
        add_custom_shields(editor, new_shield)
