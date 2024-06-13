from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.specific_patches.environmental_damage_sources import ALL_DAMAGE_ROOM_ACTORS


def apply_constant_damage(editor: PatcherEditor, configuration: dict) -> None:
    for reference in ALL_DAMAGE_ROOM_ACTORS:
        actor = editor.resolve_actor_reference(reference)

        if actor["components"][1]["arguments"][26]["value"] == "HEAT":
            config_field = "heat"
        elif actor["components"][1]["arguments"][26]["value"] == "LAVA":
            config_field = "lava"
        else:
            raise ValueError(f"{reference} does not have a valid actorDef for environmental damage")

        if configuration[config_field] is None:
            continue

        damage = configuration[config_field]

        # Max damage per tick
        actor["components"][1]["arguments"][19]["value"] = damage
        # Damage Scale
        actor["components"][1]["arguments"][28]["value"] = damage
        # Damage of first tick. Set to half to give room for player error
        actor["components"][2]["arguments"][19]["value"] = damage / 2
