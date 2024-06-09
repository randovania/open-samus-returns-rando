Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerSuperMissile = RandomizerSuperMissile or {}
function RandomizerSuperMissile.main()
end

function RandomizerSuperMissile.OnPickedUp(progression, actorOrName) 
    local locked_supers = RandomizerPowerup.GetItemAmount("ITEM_SUPER_MISSILE_TANKS")
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            if inner.item_id == "ITEM_SUPER_MISSILE_TANKS" then
                inner.item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX"
                inner.quantity = inner.quantity + locked_supers
            end
        end
    end
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.SetItemAmount("ITEM_SUPER_MISSILE_TANKS", 0)
end