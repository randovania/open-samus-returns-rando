Game.ImportLibrary("system/scripts/init_original.lua")

RL = RL or { 
  -- defined by remote connector
  Init = function() end,
  Update = function() end,
  SendLog = function(message) end,
  SendInventory = function(message) end,
  SendIndices = function(message) end,
  SendReceivedPickups = function(message) end,
  SendNewGameState = function(message) end,
  Connected = function() return true end
}

-- stub for UpdateRDVClient, which will be redefined by bootstrap code of randovania
function RL.UpdateRDVClient(new_scenario)
end

-- stub for GetGameStateAndSend, which will be redefined by bootstrap code of randovania
function RL.GetGameStateAndSend()
end

Init.tNewGameInventory = TEMPLATE("new_game_inventory")
Init.bRevealMap = TEMPLATE("reveal_map_on_start")
Init.sStartingScenario = TEMPLATE("starting_scenario")
Init.sStartingActor = TEMPLATE("starting_actor")
Init.fEnergyPerTank = TEMPLATE("energy_per_tank")
Init.tDNAPerArea = TEMPLATE("dna_per_area")
Init.tScenarioMapping = TEMPLATE("scenario_mapping")
Init.iNumRandoTextBoxes = TEMPLATE("textbox_count")
Init.sLayoutUUID = TEMPLATE("layout_uuid")
Init.sThisRandoIdentifier = TEMPLATE("configuration_identifier") .. Init.sLayoutUUID
Init.tBoxesSeen = 0
Init.bEnableRoomIds = TEMPLATE("enable_room_ids")
Init.sBabyMetroidHint = TEMPLATE("baby_metroid_hint")
Init.bTanksRefillAmmo = TEMPLATE("tanks_refill_ammo")

local orig_log = Game.LogWarn
if TEMPLATE("enable_remote_lua") then
    RL.Init()
    function Game.LogWarn(_, message)
        orig_log(_, message)
        RL.SendLog(message)
    end
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
    if string.sub(_FORV_3_, 1, 17) == "ITEM_RESERVE_TANK" and _FORV_4_ > 0 then
      local missile_launcher = Init.tNewGameInventory["ITEM_WEAPON_MISSILE_LAUNCHER"]
      if _FORV_3_ ~= "ITEM_RESERVE_TANK_MISSILE" or (missile_launcher ~= nil and missile_launcher > 0) then
        Blackboard.SetProp("GAME", _FORV_3_ .. "_ACTIVE", "b", true)
        Blackboard.SetProp("GAME", _FORV_3_ .. "_FULL", "b", true)
      end
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
  Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "RANDO_GAME_INITIALIZED", "b", false)
  Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "RANDO_START_TEXT", "b", false)
  Blackboard.SetProp(Game.GetPlayerBlackboardSectionName(), "THIS_RANDO_IDENTIFIER", "s", Init.sThisRandoIdentifier)
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
    Init.tBoxesSeen = 0
    Game.LoadScenario("c10_samus", Init.sStartingScenario, Init.sStartingActor, "samus", 1)
    if Init.bRevealMap then
      Game.AddGUISF(0.0, Game.ScanVisitDiscoverEverything, "", "")
    end
    Game.SaveGame("savedata", "", Init.sStartingActor, true)
  end

Game.SetForceSkipCutscenes(true)

-- Only required for ils test code
-- ALL_SCENARIOS = {
--   "s000_surface",
--   "s010_area1",
--   "s020_area2",
--   "s025_area2b",
--   "s028_area2c",
--   "s030_area3",
--   "s033_area3b",
--   "s036_area3c",
--   "s040_area4",
--   "s050_area5",
--   "s060_area6",
--   "s065_area6b",
--   "s067_area6c",
--   "s070_area7",
--   "s090_area9",
--   "s100_area10",
--   "s110_surfaceb",
-- }
-- NextScenario = 1
