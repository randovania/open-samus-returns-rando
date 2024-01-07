Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerReserveTankE = RandomizerReserveTankE or {}
function RandomizerReserveTankE.main()
end

function RandomizerReserveTankE.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_ACTIVE", "b", true)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_FULL", "b", true)
    Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
    Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
end
