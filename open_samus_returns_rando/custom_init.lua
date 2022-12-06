Game.ImportLibrary("system/scripts/original_init.lua")

Init.tNewGameInventory = {
    TEMPLATE("new_game_inventory")
}

Game.LogWarn(0, "Inventory:")
for k, v in pairs(Init.tNewGameInventory) do
    Game.LogWarn(0, tostring(k) .. " = " .. tostring(v))
end

local buff = {}

function Init.InitGameBlackboard()
    Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "ScenarioID", "s", TEMPLATE("starting_scenario"))
    Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "StartPoint", "s", TEMPLATE("starting_actor"))
end

function Init.InitNewGame(arg1, arg2, arg3, arg4, arg4)
    Game.LogWarn(0, string.format("Will start Game - %s / %s / %s / %s", tostring(arg1), tostring(arg2), tostring(arg3), tostring(arg4)))
    Game.LoadScenario("c10_samus", TEMPLATE("starting_scenario"), TEMPLATE("starting_actor"), "Samus", 1)
end

Game.LogWarn(0, "Finished modded system/init.lc")