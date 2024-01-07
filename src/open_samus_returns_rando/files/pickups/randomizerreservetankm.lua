Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerReserveTankM = RandomizerReserveTankM or {}
function RandomizerReserveTankM.main()
end

function RandomizerReserveTankM.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_ACTIVE", "b", true)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_FULL", "b", true)
    Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
    Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
end