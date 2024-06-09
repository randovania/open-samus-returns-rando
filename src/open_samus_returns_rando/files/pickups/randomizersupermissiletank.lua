Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerSuperMissileTank = RandomizerSuperMissileTank or {}
function RandomizerSuperMissileTank.main()
end

function RandomizerSuperMissileTank.OnPickedUp(progression, actorOrName)
    -- if we have main item use super missile max else use locked supers
    local new_item_id = "ITEM_SUPER_MISSILE_TANKS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SUPER_MISSILE") > 0
    if is_main_unlocked then
        new_item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX"
    end
    -- grant locked supers or new tank
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            inner.item_id = new_item_id
        end
    end
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
end
