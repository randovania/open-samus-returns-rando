Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerReserveTankA = RandomizerReserveTankA or {}
function RandomizerReserveTankA.main()
end

function RandomizerReserveTankA.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_ACTIVE", "b", true)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_FULL", "b", true)
    Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
    Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
end