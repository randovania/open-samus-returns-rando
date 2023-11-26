Game.ImportLibrary("system/scripts/init_original.lua")

Init.tNewGameInventory = TEMPLATE("new_game_inventory")

Init.bRevealMap = TEMPLATE("reveal_map_on_start")
Init.sStartingScenario = TEMPLATE("starting_scenario")
Init.sStartingActor = TEMPLATE("starting_actor")
Init.fEnergyPerTank = TEMPLATE("energy_per_tank")
Init.tDNAPerArea = TEMPLATE("dna_per_area")
Init.tScenarioMapping = TEMPLATE("scenario_mapping")

Game.LogWarn(0, "Inventory:")
for k, v in pairs(Init.tNewGameInventory) do
    Game.LogWarn(0, tostring(k) .. " = " .. tostring(v))
end

function Init.InitGameBlackboard()
  Blackboard.ResetWithExceptionList({
    "GAME_PROGRESS"
  })
  for _FORV_3_, _FORV_4_ in pairs(Init.tNewGameInventory) do
    Blackboard.SetProp("PLAYER_INVENTORY", _FORV_3_, "f", _FORV_4_)
    if string.sub(_FORV_3_, 0, 14) == "ITEM_RANDO_DNA" then
      local current_amount = Blackboard.GetProp("PLAYER_INVENTORY", "ITEM_ADN") or 0
      Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_ADN", "f", current_amount + 1)
    end
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
  Blackboard.SetProp("GAME", "Version", "i", SaveGame.Version)
  Blackboard.SetProp("GAME", "HUD", "b", true)
  Blackboard.SetProp("GAME", "Player", "s", "samus")
  Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "LevelID", "s", "c10_samus")
  Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "ScenarioID", "s", TEMPLATE("starting_scenario"))
  Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "StartPoint", "s", TEMPLATE("starting_actor"))

  Blackboard.SetProp("s000_surface", "entity_LE_HazarousPool_enabled", "b", false)
  Blackboard.SetProp("s010_area1", "entity_LE_HazarousPool_enabled", "b", false)
  Blackboard.SetProp("s028_area2c", "entity_LE_HazarousPool_enabled", "b", false)
  Blackboard.SetProp("s030_area3", "entity_LE_HazarousPool_enabled", "b", false)
  Blackboard.SetProp("s040_area4", "entity_LE_HazarousPool_001_enabled", "b", false)
  Blackboard.SetProp("s040_area4", "entity_LE_HazarousPool_002_enabled", "b", false)
  Blackboard.SetProp("s060_area6", "entity_LE_HazarousPool_enabled", "b", false)
  Blackboard.SetProp("s070_area7", "entity_LE_HazarousPool_001_enabled", "b", false)
  Blackboard.SetProp("s070_area7", "entity_LE_HazarousPool_002_enabled", "b", false)
  Blackboard.SetProp("s090_area9", "entity_LE_HazarousPool_enabled", "b", false)

  Blackboard.SetProp("s000_surface", "LarvaPresentationPlayed", "b", true)
  Game.WriteToGameBlackboardSection("PlayedCutscenes", "cutscenes/planetarrival/takes/10/planetarrival10.bmscu", true)

  Game.UnlockAmiiboMenu()
end

function Init.InitNewGame(arg1, arg2, arg3, arg4, arg4)
    Game.LogWarn(0, string.format("Will start Game - %s / %s / %s / %s", tostring(arg1), tostring(arg2), tostring(arg3), tostring(arg4)))
    Game.LoadScenario("c10_samus", Init.sStartingScenario, Init.sStartingActor, "samus", 1)
    if Init.bRevealMap then
      Game.AddGUISF(0.0, Game.ScanVisitDiscoverEverything, "", "")
    end
  end

Game.SetForceSkipCutscenes(true)

Game.LogWarn(0, "Finished modded system/init.lc")
