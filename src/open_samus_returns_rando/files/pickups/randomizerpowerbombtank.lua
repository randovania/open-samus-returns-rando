Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerPowerBombTank = RandomizerPowerBombTank or {}
function RandomizerPowerBombTank.main()
end

function RandomizerPowerBombTank.OnPickedUp(progression, actorOrName)
    -- if we have main item use power bomb max else use locked power bombs
    local new_item_id = "ITEM_POWER_BOMB_TANKS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_POWER_BOMB") > 0
    if is_main_unlocked then
        new_item_id = "ITEM_WEAPON_POWER_BOMB_MAX"
    end

    -- grant locked pbs or new tank
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            inner.item_id = new_item_id
        end
    end
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
end
