from open_samus_returns_rando.files import files_path
from open_samus_returns_rando.lua_editor import get_parent_for
from open_samus_returns_rando.misc_patches.lua_util import lua_convert


def get_lua_for_item(progression: list[list[dict[str, str | int]]]):
    generic_pickup = """
    Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
    MultiworldPickup = MultiworldPickup or {}
    function MultiworldPickup.main()
    end

    function MultiworldPickup.OnPickedUp(progression, actorOrName)
        RandomizerPowerup.OnPickedUp(progression, actorOrName)
        hud.UpdatePlayerInfo(true)
    end
    """

    main_item_id = str(progression[0][0]["item_id"])
    parent = get_parent_for(main_item_id)
    if parent == "RandomizerPowerup":
        parent_content = generic_pickup
    else:
        parent_lower = parent.lower()
        parent_content = files_path().joinpath("pickups", f"{parent_lower}.lua").read_text()
        parent_content = parent_content.replace(parent, "MultiworldPickup")

    progression_as_lua = lua_convert(progression, True)
    return f'{parent_content}\nMultiworldPickup.OnPickedUp({progression_as_lua}, nil)'.replace("\n", "\\\n")


# get_lua_for_item([[{'item_id': 'ITEM_RANDO_DNA_12', 'quantity': 1}]])
# get_lua_for_item([[{'item_id': 'ITEM_POWER_BOMB_TANKS', 'quantity': 1}]])
