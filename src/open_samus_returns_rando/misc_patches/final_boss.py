import typing

from open_samus_returns_rando.patcher_editor import PatcherEditor


class NewTrigger(typing.NamedTuple):
    scenario: str
    name: str
    position: list[float]
    entity_groups: list[str]


new_triggers = [
    NewTrigger("s110_surfaceb", "TG_Ridley_Access", [-22800.0, 4400.0, 0.0], ["collision_camera_017"]),
]


def add_boss_triggers(editor: PatcherEditor, new_trigger: NewTrigger) -> None:
    template_tg = editor.get_scenario("s110_surfaceb").raw.actors[0]["TG_Activation_Teleport_00b_01"]

    scenario_name = new_trigger.scenario
    scenario_file = editor.get_scenario(scenario_name)

    editor.copy_actor(scenario_name, new_trigger.position, template_tg, new_trigger.name, 0)

    arguments = scenario_file.raw.actors[0][new_trigger.name]["components"][0]["arguments"]
    arguments[3]["value"] = "CurrentScenario.OnEnter_Ridley_Access"
    # Set the size of the trigger to fill the opening
    arguments[16]["value"] = 150.0
    arguments[17]["value"] = 800.0
    arguments[18]["value"] = 800.0

    for entity_group in new_trigger.entity_groups:
        scenario_file.add_actor_to_entity_groups(entity_group, new_trigger.name, True)


def patch_custom_final_boss(editor: PatcherEditor, configuration: dict) -> None:
    if configuration["objective"]["final_boss"] != "Ridley":
        for new_trigger in new_triggers:
            add_boss_triggers(editor, new_trigger)

    if configuration["objective"]["final_boss"] == "Diggernaut":
        if not configuration["game_patches"]["remove_elevator_grapple_blocks"]:
            scenario = editor.get_scenario("s070_area7")
            scenario.raw.actors[9]["LE_GrappleMov_001"]["position"][0] = -15250.0
