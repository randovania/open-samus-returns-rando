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
    Blackboard.ResetWithExceptionList({
      "GAME_PROGRESS"
    })
    for _FORV_3_, _FORV_4_ in pairs(Init.tNewGameInventory) do
      Blackboard.SetProp("PLAYER_INVENTORY", _FORV_3_, "f", _FORV_4_)
    end
    Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_METROID_COUNT", "f", 0)
    Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_LIFE", "f", Init.tNewGameInventory.ITEM_MAX_LIFE)
    Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_CURRENT", "f", Init.tNewGameInventory.ITEM_WEAPON_MISSILE_MAX)
    Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_CURRENT", "f", Init.tNewGameInventory.ITEM_WEAPON_SUPER_MISSILE_MAX)
    Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_POWER_BOMB_CURRENT", "f", Init.tNewGameInventory.ITEM_WEAPON_POWER_BOMB_MAX)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_SIZE", "f", Init.tReserveTanksInitialConfiguration.ITEM_RESERVE_TANK_LIFE_SIZE)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_SIZE", "f", Init.tReserveTanksInitialConfiguration.ITEM_RESERVE_TANK_SPECIAL_ENERGY_SIZE)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_SIZE", "f", Init.tReserveTanksInitialConfiguration.ITEM_RESERVE_TANK_MISSILE_SIZE)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SUPER_MISSILE_SIZE", "f", Init.tReserveTanksInitialConfiguration.ITEM_RESERVE_TANK_SUPER_MISSILE_SIZE)
    if ProfileBlackboard.GetProp("SETTINGS", "AMIIBO_MENU_UNLOCKED") ~= nil then
      Blackboard.SetProp("GAME", "AMIIBO_MENU_UNLOCKED", "b", (ProfileBlackboard.GetProp("SETTINGS", "AMIIBO_MENU_UNLOCKED")))
    end
    Blackboard.SetProp("GAME", "Version", "i", SaveGame.Version)
    Blackboard.SetProp("GAME", "HUD", "b", true)
    Blackboard.SetProp("GAME", "Player", "s", "samus")
    Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "LevelID", "s", "c10_samus")
    Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "ScenarioID", "s", TEMPLATE("starting_scenario"))
    Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "StartPoint", "s", TEMPLATE("starting_actor"))
  end

function Init.InitNewGame(arg1, arg2, arg3, arg4, arg4)
    Game.LogWarn(0, string.format("Will start Game - %s / %s / %s / %s", tostring(arg1), tostring(arg2), tostring(arg3), tostring(arg4)))
    Game.LoadScenario("c10_samus", TEMPLATE("starting_scenario"), TEMPLATE("starting_actor"), "Samus", 1)
end

Game.SetForceSkipCutscenes(true)
Game.LogWarn(0, "Finished modded system/init.lc")
