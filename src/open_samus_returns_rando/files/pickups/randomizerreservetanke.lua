Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerReserveTankE = RandomizerReserveTankE or {}
function RandomizerReserveTankE.main()
end

function RandomizerReserveTankE.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_ACTIVE", "b", true)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_FULL", "b", true)
    local reserve = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.ReserveTankE")
    GUI.SetProperties(reserve, { Enabled = true })
    Game.GetPlayerInfo():FillLifeReserveTank()
end
