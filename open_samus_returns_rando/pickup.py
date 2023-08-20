import copy
from pathlib import Path

from mercury_engine_data_structures.formats import Bmsad

from open_samus_returns_rando.model_data import get_data
from open_samus_returns_rando.patcher_editor import PatcherEditor, path_for_level
from open_samus_returns_rando.samus_returns_patcher import LOG


def _read_powerup_lua() -> bytes:
    return Path(__file__).parent.joinpath("files", "randomizer_powerup.lua").read_bytes()


def patch_pickups(editor: PatcherEditor, pickups_config: list[dict]):
    template_bmsad = editor.get_parsed_asset("actors/items/powerup_chargebeam/charclasses/powerup_chargebeam.bmsad").raw

    pkgs_for_lua = set()

    for i, pickup in enumerate(pickups_config):
        LOG.info("Writing pickup %d: %s", i, pickup["item_id"])
        pkgs_for_level = set(editor.find_pkgs(path_for_level(pickup["pickup_actor"]["scenario"]) + ".bmsld"))
        pkgs_for_lua.update(pkgs_for_level)

        actor_reference = pickup["pickup_actor"]
        scenario = editor.get_scenario(actor_reference["scenario"])
        actor_name = actor_reference["actor"]

        actor = next((layer[actor_name] for layer in scenario.raw.actors if actor_name in layer), None)
        if actor is None:
            raise KeyError(f"No actor named '{actor_name}' found in {actor_reference['scenario']}")

        model_name: str = pickup["model"]
        model_data = get_data(model_name)

        new_template = copy.deepcopy(template_bmsad)
        # Update used model
        new_template["model_name"] = model_data.bcmdl_path
        MODELUPDATER = new_template["components"]["MODELUPDATER"]
        MODELUPDATER["functions"][0]["params"]["Param1"]["value"] = model_data.bcmdl_path

        # Update caption
        PICKABLE = new_template["components"]["PICKABLE"]

        # Update given item
        set_custom_params: dict = PICKABLE["functions"][0]["params"]
        item_id: str = pickup["item_id"]
        quantity: float = pickup["quantity"]

        if item_id == "ITEM_ENERGY_TANKS":
            item_id = "fMaxLife"
            quantity *= 100.0
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fCurrentLife"
            set_custom_params["Param6"]["value"] = "LIFE"

        elif item_id == "ITEM_SENERGY_TANKS":
            item_id = "fMaxEnergy"
            quantity *= 50.0
            set_custom_params["Param4"]["value"] = "Full"
            set_custom_params["Param5"]["value"] = "fEnergy"
            set_custom_params["Param6"]["value"] = "SPECIALENERGY"

        set_custom_params["Param1"]["value"] = item_id
        set_custom_params["Param2"]["value"] = quantity

        actordef_id = f"randomizer_powerup_{i}"
        new_template["name"] = actordef_id
        new_path = f"actors/items/{actordef_id}/charclasses/{actordef_id}.bmsad"

        editor.add_new_asset(new_path, Bmsad(new_template, editor.target_game), in_pkgs=pkgs_for_level)
        actor.type = actordef_id

        # Powerup is in plain sight (except for the part we're using the sphere model)
        # actor.components.pop("LIFE", None)

        # Dependencies
        for level_pkg in pkgs_for_level:
            editor.ensure_present(level_pkg, "system/animtrees/base.bmsat")
            for dep in model_data.dependencies:
                editor.ensure_present(level_pkg, dep)

        # For debugging, write the bmsad we just created
        # Path("custom_bmsad", f"randomizer_powerup_{i}.bmsad.json").write_text(
        #     json.dumps(new_template, indent=4)
        # )

    editor.add_new_asset("actors/items/randomizer_powerup/scripts/randomizer_powerup.lc",
                         _read_powerup_lua(),
                         in_pkgs=pkgs_for_lua)
