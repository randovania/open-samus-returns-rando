Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerReserveTankA = RandomizerReserveTankA or {}
function RandomizerReserveTankA.main()
end

function RandomizerReserveTankA.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_ACTIVE", "b", true)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_FULL", "b", true)
    local reserve = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.ReserveTankS")
    GUI.SetProperties(reserve, { Enabled = true })
    Game.GetPlayerInfo():FillSpecialEnergyReserveTank()
end