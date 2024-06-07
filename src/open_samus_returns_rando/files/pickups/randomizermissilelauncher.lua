Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerMissileLauncher = RandomizerMissileLauncher or {}
function RandomizerMissileLauncher.main()
end

function RandomizerMissileLauncher.OnPickedUp(progression, actorOrName)
    local locked_missiles = RandomizerPowerup.GetItemAmount("ITEM_MISSILE_TANKS")
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            if inner.item_id == "ITEM_MISSILE_TANKS" then
                inner.item_id = "ITEM_WEAPON_MISSILE_MAX"
                inner.quantity = inner.quantity + locked_missiles
            end
        end
    end
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.SetItemAmount("ITEM_MISSILE_TANKS", 0)
    RandomizerPowerup.IncreaseMissileCheckValue()
    if RandomizerPowerup.GetItemAmount("ITEM_RESERVE_TANK_MISSILE") > 0 then
        RandomizerPowerup.EnableMissileReserveTank()
    end
end
