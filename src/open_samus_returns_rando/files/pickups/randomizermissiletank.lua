Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerMissileTank = RandomizerMissileTank or {}
function RandomizerMissileTank.main()
end

function RandomizerMissileTank.OnPickedUp(progression, actorOrName)
    -- if we have main item use missile max else use locked missiles
    local new_item_id = "ITEM_MISSILE_TANKS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_MISSILE_LAUNCHER") > 0
    if is_main_unlocked then
        new_item_id = "ITEM_WEAPON_MISSILE_MAX"
    end
    -- grant locked missiles or new tank
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            inner.item_id = new_item_id
        end
    end
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.IncreaseMissileCheckValue()
end