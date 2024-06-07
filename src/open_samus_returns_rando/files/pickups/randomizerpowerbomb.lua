Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerPowerBomb = RandomizerPowerBomb or {}
function RandomizerPowerBomb.main()
end

function RandomizerPowerBomb.OnPickedUp(progression, actorOrName)
    local locked_pbs = RandomizerPowerup.GetItemAmount("ITEM_POWER_BOMB_TANKS")
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            if inner.item_id == "ITEM_POWER_BOMB_TANKS" then
                inner.item_id = "ITEM_WEAPON_POWER_BOMB_MAX"
                inner.quantity = inner.quantity + locked_pbs
            end
        end
    end
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.SetItemAmount("ITEM_POWER_BOMB_TANKS", 0)
end