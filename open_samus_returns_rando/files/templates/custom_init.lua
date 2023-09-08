Game.ImportLibrary("system/scripts/init_original.lua")

Init.tNewGameInventory = TEMPLATE("new_game_inventory")

Init.bRevealMap = TEMPLATE("reveal_map_on_start")

Game.LogWarn(0, "Inventory:")
for k, v in pairs(Init.tNewGameInventory) do
    Game.LogWarn(0, tostring(k) .. " = " .. tostring(v))
end

local buff = {}

Init.sStartingScenario = TEMPLATE("starting_scenario")
Init.sStartingActor = TEMPLATE("starting_actor")

function Init.InitNewGame(arg1, arg2, arg3, arg4, arg5)
  Game.LogWarn(0, string.format("Will start Game - %s / %s / %s / %s", tostring(arg1), tostring(arg2), tostring(arg3), tostring(arg4)))
  Game.LoadScenario("c10_samus", Init.sStartingScenario, Init.sStartingActor, "samus", 1)
  if Init.bRevealMap then
    Game.AddGUISF(0.0, Game.ScanVisitDiscoverEverything, "", "")
  end
end

Game.SetForceSkipCutscenes(true)

Game.LogWarn(0, "Finished modded system/init.lc")
