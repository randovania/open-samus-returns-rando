from open_samus_returns_rando.patcher_editor import PatcherEditor
from open_samus_returns_rando.specific_patches.environmental_damage_sources import ALL_DAMAGE_ROOM_ACTORS


def apply_constant_damage(editor: PatcherEditor, configuration: dict) -> None:
    for scenario_name, layer, actor in ALL_DAMAGE_ROOM_ACTORS:
        env_actor = editor.get_scenario(scenario_name).get_actor(layer, actor)

        if env_actor.get_component_function(1).get_argument(26) == "HEAT":
            config_field = "heat"
        elif env_actor.get_component_function(1).get_argument(26) == "LAVA":
            config_field = "lava"
        else:
            raise ValueError(f"{env_actor} does not have a valid actorDef for environmental damage")

        if configuration[config_field] is None:
            continue

        # Uses the default time per tick of 0.5
        damage = configuration[config_field] / 2

        # Damage per tick
        env_actor.get_component_function(1).set_argument(19, damage)
        # Damage Scale
        env_actor.get_component_function(1).set_argument(28, damage)
        # Damage of first tick
        env_actor.get_component_function(2).set_argument(19, damage)
