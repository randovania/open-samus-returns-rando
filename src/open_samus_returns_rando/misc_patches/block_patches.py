from mercury_engine_data_structures.formats import Bmsbk
from open_samus_returns_rando.constants import ALL_SCENARIOS
from open_samus_returns_rando.patcher_editor import PatcherEditor


def patch_block_types(editor: PatcherEditor, configuration: dict) -> None:
    if len(configuration["block_patches"]) == 0:
        return

    for scenario_name in ALL_SCENARIOS:
        bmsbk = editor.get_file(f"maps/levels/c10_samus/{scenario_name}/{scenario_name}.bmsbk", Bmsbk)
        blocks = bmsbk.raw["block_groups"]
        for block in blocks:
            block_type = block["types"][0]
            temp_type: str = ""
            for original_type, new_type in configuration["block_patches"].items():
                # Check for the block type and change it to the new type
                if original_type == block_type["block_type"] and temp_type == "":
                    # Set the temp_type to the original_type to ensure the block doesnt get changed again
                    temp_type = original_type
                    block_type["block_type"] = new_type
