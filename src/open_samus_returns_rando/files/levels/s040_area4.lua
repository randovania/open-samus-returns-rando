Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s040_area4.main()
  Scenario.InitGUI()
end
function s040_area4.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s040_area4.OnEnter_SetCheckpoint_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001", "ST_SG_Alpha_001", "SG_Alpha_001", "", "")
end
function s040_area4.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_001")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door012")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha001_Idle")
  end
end
function s040_area4.OnEnter_Alpha_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_007", "PostAlpha_001", true)
    if Game.GetEntity("SpawnGroup018") ~= nil then
      Game.GetEntity("SpawnGroup018").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s040_area4.OnEnter_SetCheckpoint_Gamma_001()
  Game.SetBossCheckPointNames("ST_SG_Gamma_001", "ST_SG_Gamma_001", "SG_Gamma_001_A", "", "")
end
function s040_area4.OnGamma_001_A_Trigger()
  if Game.GetEntity("SG_Gamma_001_A") ~= nil and Scenario.ReadFromBlackboard("entity_TG_Gamma_001_A_enabled", true)  then
    Game.GetEntity("SG_Gamma_001_A").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s040_area4.OnGamma_001_Intro_A_Generated(_ARG_0_, _ARG_1_)
  -- if Game.GetEntity("LE_Valve_Gamma_001_Intro_A") ~= nil then
  --   Game.GetEntity("LE_Valve_Gamma_001_Intro_A").ANIMATION:SetAction("spawn")
  -- end
  s040_area4.OnGamma_001_A_Generated(_ARG_0_, _ARG_1_)
end
function s040_area4.OnGamma_001_A_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_001_A")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door011")
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door004")
    Game.DisableTrigger("TG_SetCheckpoint_Gamma_001")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_A_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_A_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_A_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_A_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_A_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_A_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_A_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_A_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_A_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_A_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma001_A_Idle")
    -- Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_A_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_A_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_A_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_A_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
  end
end
-- function s040_area4.OnGamma_001_B_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_001", "B")
-- end
-- function s040_area4.OnGamma_001_Intro_B_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_001_B_002") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_001_B_002").ANIMATION:SetAction("spawn")
--   end
--   s040_area4.OnGamma_001_B_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s040_area4.OnGamma_001_B_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door004")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_B_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_B_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma001_B_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
-- function s040_area4.OnGamma_001_C_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_001", "C")
-- end
-- function s040_area4.OnGamma_001_Intro_C_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_001_Intro_C") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_001_Intro_C").ANIMATION:SetAction("spawn")
--   end
--   s040_area4.OnGamma_001_C_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s040_area4.OnGamma_001_C_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoor("Door010")
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door004")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Gamma_001_C")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_C_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_C_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_C_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_C_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_C_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_C_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma001_C_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_C_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_C_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_C_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_001_C_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
function s040_area4.OnEnter_Gamma_001_Dead()
  if Scenario.ReadFromBlackboard("Arena_Gamma_001_AllDead", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_005", "PostGamma_001", true)
    Game.SetSubAreaCurrentSetup("collision_camera_012", "PostGamma_001", true)
    Game.SetSubAreaCurrentSetup("collision_camera_013", "PostGamma_001", true)
    if Game.GetEntity("SpawnGroup019") ~= nil then
      Game.GetEntity("SpawnGroup019").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup020") ~= nil then
      Game.GetEntity("SpawnGroup020").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup021") ~= nil then
      Game.GetEntity("SpawnGroup021").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
s040_area4.tDNAScanLandmarks = {
  SG_Alpha_001 = {
    "LM_ADNScanner_Samus_Alpha_001_001",
    "LM_ADNScanner_Samus_Alpha_001_002",
    "LM_ADNScanner_Samus_Alpha_001_003",
    "LM_ADNScanner_Samus_Alpha_001_004",
    "LM_ADNScanner_Samus_Alpha_001_005",
    "LM_ADNScanner_Samus_Alpha_001_006",
    "LM_ADNScanner_Samus_Alpha_001_007",
    "LM_ADNScanner_Samus_Alpha_001_008",
    "LM_ADNScanner_Samus_Alpha_001_009",
    "LM_ADNScanner_Samus_Alpha_001_010",
    "LM_ADNScanner_Samus_Alpha_001_011",
    "LM_ADNScanner_Samus_Alpha_001_012",
    "LM_ADNScanner_Samus_Alpha_001_013",
    "LM_ADNScanner_Samus_Alpha_001_014"
  },
  SG_Gamma_001_A = {
    "LM_ADNScanner_Samus_Gamma_001_A_001",
    "LM_ADNScanner_Samus_Gamma_001_A_002",
    "LM_ADNScanner_Samus_Gamma_001_A_003",
    "LM_ADNScanner_Samus_Gamma_001_A_004",
    "LM_ADNScanner_Samus_Gamma_001_A_005",
    "LM_ADNScanner_Samus_Gamma_001_A_006",
    "LM_ADNScanner_Samus_Gamma_001_A_007",
    "LM_ADNScanner_Samus_Gamma_001_A_008",
    "LM_ADNScanner_Samus_Gamma_001_A_009",
    "LM_ADNScanner_Samus_Gamma_001_A_010",
    "LM_ADNScanner_Samus_Gamma_001_A_011",
    "LM_ADNScanner_Samus_Gamma_001_A_012",
    "LM_ADNScanner_Samus_Gamma_001_A_013",
    "LM_ADNScanner_Samus_Gamma_001_A_014",
    "LM_ADNScanner_Samus_Gamma_001_A_015",
    "LM_ADNScanner_Samus_Gamma_001_A_016",
    "LM_ADNScanner_Samus_Gamma_001_A_017"
  },
  SG_Gamma_001_B = {
    "LM_ADNScanner_Samus_Gamma_001_B_001",
    "LM_ADNScanner_Samus_Gamma_001_B_002",
    "LM_ADNScanner_Samus_Gamma_001_B_003",
    "LM_ADNScanner_Samus_Gamma_001_B_004",
    "LM_ADNScanner_Samus_Gamma_001_B_005",
    "LM_ADNScanner_Samus_Gamma_001_B_006",
    "LM_ADNScanner_Samus_Gamma_001_B_007",
    "LM_ADNScanner_Samus_Gamma_001_B_008",
    "LM_ADNScanner_Samus_Gamma_001_B_009",
    "LM_ADNScanner_Samus_Gamma_001_B_010"
  },
  SG_Gamma_001_C = {
    "LM_ADNScanner_Samus_Gamma_001_C_001",
    "LM_ADNScanner_Samus_Gamma_001_C_002",
    "LM_ADNScanner_Samus_Gamma_001_C_003",
    "LM_ADNScanner_Samus_Gamma_001_C_004",
    "LM_ADNScanner_Samus_Gamma_001_C_005",
    "LM_ADNScanner_Samus_Gamma_001_C_006",
    "LM_ADNScanner_Samus_Gamma_001_C_007",
    "LM_ADNScanner_Samus_Gamma_001_C_008",
    "LM_ADNScanner_Samus_Gamma_001_C_009",
    "LM_ADNScanner_Samus_Gamma_001_C_010"
  }
}
function s040_area4.OnLE_Platform_Elevator_FromArea03(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s030_area3", "ST_FromArea04", _ARG_2_)
end
function s040_area4.OnLE_Platform_Elevator_FromArea05(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s050_area5", "ST_FromArea04", _ARG_2_)
end
function s040_area4.OnLE_Platform_Elevator_FromArea06(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s060_area6", "ST_FromArea04", _ARG_2_)
end
function s040_area4.PreLE_Platform_Elevator_FromArea03()
  GUI.ElevatorSetTarget("s040_area4_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s040_area4.PreLE_Platform_Elevator_FromArea05()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s040_area4.PreLE_Platform_Elevator_FromArea06()
  GUI.ElevatorSetTarget("s060_area6_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s040_area4.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea03" then
    GUI.ElevatorSetTarget("s040_area4_elevator", true)
  elseif _ARG_0_ == "ST_FromArea06" then
    GUI.ElevatorSetTarget("s060_area6_elevator", false)
  end
end
function s040_area4.SetupDebugGameBlackboard()
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_SPECIAL_ENERGY", "f", 1000)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MAX_SPECIAL_ENERGY", "f", 1000)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_LIFE", "f", 399)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MAX_LIFE", "f", 399)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_MAX", "f", 100)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_CURRENT", "f", 100)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_MAX", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_CURRENT", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_POWER_BOMB_MAX", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_POWER_BOMB_CURRENT", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MORPH_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_CHARGE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_BOMB", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_ICE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPIDER_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_WAVE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SPAZER_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_PLASMA_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_GRAPPLE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPACE_JUMP", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_VARIA_SUIT", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
end
function s040_area4.InitFromBlackboard()
  Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_001", true)
  Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_002", true)
  if Blackboard.GetProp("s040_area4", "entity_LE_HazarousPool_001_enabled") == nil then
    Game.GetEntity("LE_HazarousPool_001").HAZAROUSPOOL:Activate(true)
    Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_001", false)
    Game.GetEntity("LE_HazarousPool_002").HAZAROUSPOOL:Activate(false)
    Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_002", false)
  elseif Blackboard.GetProp("s040_area4", "entity_LE_HazarousPool_002_enabled") == nil then
    Game.GetEntity("LE_HazarousPool_002").HAZAROUSPOOL:Activate(true)
    Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_002", false)
  else
    Game.GetEntity("LE_HazarousPool_001").HAZAROUSPOOL:Activate((Blackboard.GetProp("s040_area4", "entity_LE_HazarousPool_001_enabled")))
    Game.GetEntity("LE_HazarousPool_002").HAZAROUSPOOL:Activate((Blackboard.GetProp("s040_area4", "entity_LE_HazarousPool_002_enabled")))
  end
  s040_area4.OnFansInit()
  Game.SetArenaDefaultSpawnGroup("Gamma_001", "SG_Gamma_001_A")
end
function s040_area4.OnReloaded()
end
function s040_area4.OnExit()
end
function s040_area4.OnEnter_ActivationDNA_001()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA_001", 1)
end
function s040_area4.OnEnter_ActivationDNA_002()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA_002", 3)
end
function s040_area4.OnEnter_ActivationTeleport_04_01()
  Game.OnTeleportApproached("LE_Teleporter_04_01")
end
function s040_area4.OnHazarousPoolDrain(_ARG_0_)
  --if _ARG_0_ == "LE_HazarousPool_001" then
  --  Game.SetSubAreaCurrentSetup("collision_camera_006", "Hazarous_empty_001", true)
  --  Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_001", true)
  --elseif _ARG_0_ == "LE_HazarousPool_002" then
   -- Game.SetSubAreaCurrentSetup("collision_camera_006", "Hazarous_empty_002", true)
   -- Game.SetSubAreaCurrentSetup("collision_camera_022", "Hazarous_empty_002", true)
   -- Game.SetSubAreaCurrentSetup("collision_camera_023", "Hazarous_empty_002", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_010", "Hazarous_empty_002", true)
  --  Game.SetSceneGroupEnabledByName("sg_Hazardous_Puddle_002", true)
 -- end
  --if _ARG_0_ == "LE_HazarousPool_001" then
  --  Game.GetEntity("LE_HazarousPool_002").HAZAROUSPOOL:Activate(true)
  --end
  -- Set all camera's
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Hazarous_empty_001", true)
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Hazarous_empty_002", true)
  Game.SetSubAreaCurrentSetup("collision_camera_022", "Hazarous_empty_002", true)
  Game.SetSubAreaCurrentSetup("collision_camera_023", "Hazarous_empty_002", true)
  Game.SetSubAreaCurrentSetup("collision_camera_010", "Hazarous_empty_002", true)
end
function s040_area4.OnEnterHazardous_001()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Enter_Hazardous_001", false)
end
function s040_area4.OnExitHazardous_001()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Default", false)
end
function s040_area4.OnEnterHazardous_002()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Enter_Hazardous_002", false)
end
function s040_area4.OnExitHazardous_002()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Hazarous_empty_001", false)
end
function s040_area4.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s040_area4.OnMoheek_Clockwise_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sMode", "CLOCKWISE")
  end
end
function s040_area4.OnMoheek_CounterClockwise_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sMode", "COUNTERCLOCKWISE")
  end
end
function s040_area4.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s040_area4.OnMumbo_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_001")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s040_area4.OnMumbo_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_002")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s040_area4.OnMumbo_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_003")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s040_area4.OnMumbo_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_004")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s040_area4.OnMumbo_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_005")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s040_area4.OnGulluggStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_003")
  end
end
function s040_area4.OnGulluggStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_004")
  end
end
function s040_area4.OnGulluggStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_005")
  end
end
function s040_area4.OnGulluggStr_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_006")
  end
end
function s040_area4.OnGulluggStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_009")
  end
end
function s040_area4.OnGulluggStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_010")
  end
end
function s040_area4.OnHalzyn_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_001")
  end
end
function s040_area4.OnHalzyn_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_002")
  end
end
function s040_area4.OnHalzyn_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_004")
  end
end
function s040_area4.OnHalzyn_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_006")
  end
end
function s040_area4.OnHalzyn_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_007")
  end
end
function s040_area4.OnHalzyn_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_009")
  end
end
function s040_area4.OnHalzyn_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_010")
  end
end
function s040_area4.OnHalzyn_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_011")
  end
end
function s040_area4.OnHalzyn_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_012")
  end
end
function s040_area4.OnHalzyn_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_013")
  end
end
function s040_area4.OnHalzyn_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_014")
  end
end
function s040_area4.OnHalzyn_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_016")
  end
end
function s040_area4.OnGawron_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(-150, -250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 450, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(150, -250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 450, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s040_area4.OnGawron_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 1)
  end
end
function s040_area4.OnGrapplePullFinished(_ARG_0_, _ARG_1_)
  if _ARG_0_ ~= nil and _ARG_0_.sName == "LE_GrappleMov_003" and _ARG_1_ and Game.GetEntity("LE_Fan_002") ~= nil then
    Game.GetEntity("LE_Fan_002").BOMBFAN:SetIsWorking(not _ARG_1_)
  end
end
function s040_area4.OnFansInit()
  if Game.GetEntity("LE_Fan_002") ~= nil then
    Game.GetEntity("LE_Fan_002").BOMBFAN:SetIsWorking(not Blackboard.GetProp("s040_area4", "entity_LE_GrappleMov_003_used"))
  end
end
function s040_area4.OnEnter_ChangeCamera_001()
  Game.SetCollisionCameraLocked("collision_camera_001_B", true)
end
function s040_area4.OnExit_ChangeCamera_001()
  Game.SetCollisionCameraLocked("collision_camera_001_B", false)
end
function s040_area4.OnEnter_ChangeCamera_015()
  Game.SetCollisionCameraLocked("collision_camera_015_B", true)
end
function s040_area4.OnExit_ChangeCamera_015()
  Game.SetCollisionCameraLocked("collision_camera_015_B", false)
end
function s040_area4.OnEnter_ChangeCamera_006()
  Game.SetCollisionCameraLocked("collision_camera_006_B", true)
end
function s040_area4.OnExit_ChangeCamera_006()
  Game.SetCollisionCameraLocked("collision_camera_006_B", false)
end
function s040_area4.OnEnter_ChangeCamera_022()
  Game.SetCollisionCameraLocked("collision_camera_022_B", true)
end
function s040_area4.OnExit_ChangeCamera_022()
  Game.SetCollisionCameraLocked("collision_camera_022_B", false)
end
function s040_area4.OnEnter_ChangeCamera_023()
  Game.SetCollisionCameraLocked("collision_camera_023_B", true)
end
function s040_area4.OnExit_ChangeCamera_023()
  Game.SetCollisionCameraLocked("collision_camera_023_B", false)
end
function s040_area4.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end