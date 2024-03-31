Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerReserveTankM = RandomizerReserveTankM or {}
function RandomizerReserveTankM.main()
end

function RandomizerReserveTankM.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    if RandomizerPowerup.GetItemAmount("ITEM_WEAPON_MISSILE_LAUNCHER") > 0 then
        RandomizerPowerup.EnableMissileReserveTank()
    end
end