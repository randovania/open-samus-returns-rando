Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s050_area5.main()
  Scenario.InitGUI()
end
function s050_area5.OnGenerateNavMesh()
end
function s050_area5.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
s050_area5.tDNAScanLandmarks = {
  SG_Zeta_001 = {
    "LM_ADNScanner_Samus_Zeta_001_001",
    "LM_ADNScanner_Samus_Zeta_001_002",
    "LM_ADNScanner_Samus_Zeta_001_003",
    "LM_ADNScanner_Samus_Zeta_001_004",
    "LM_ADNScanner_Samus_Zeta_001_005",
    "LM_ADNScanner_Samus_Zeta_001_006",
    "LM_ADNScanner_Samus_Zeta_001_007",
    "LM_ADNScanner_Samus_Zeta_001_008"
  },
  SG_Gamma_002_A = {
    "LM_ADNScanner_Samus_Gamma_002_A_001",
    "LM_ADNScanner_Samus_Gamma_002_A_002",
    "LM_ADNScanner_Samus_Gamma_002_A_003",
    "LM_ADNScanner_Samus_Gamma_002_A_004",
    "LM_ADNScanner_Samus_Gamma_002_A_005",
    "LM_ADNScanner_Samus_Gamma_002_A_006",
    "LM_ADNScanner_Samus_Gamma_002_A_007",
    "LM_ADNScanner_Samus_Gamma_002_A_008",
    "LM_ADNScanner_Samus_Gamma_002_A_009",
    "LM_ADNScanner_Samus_Gamma_002_A_010",
    "LM_ADNScanner_Samus_Gamma_002_A_011",
    "LM_ADNScanner_Samus_Gamma_002_A_012",
    "LM_ADNScanner_Samus_Gamma_002_A_013"
  },
  SG_Gamma_002_B = {
    "LM_ADNScanner_Samus_Gamma_002_B_001",
    "LM_ADNScanner_Samus_Gamma_002_B_002",
    "LM_ADNScanner_Samus_Gamma_002_B_003",
    "LM_ADNScanner_Samus_Gamma_002_B_004",
    "LM_ADNScanner_Samus_Gamma_002_B_005",
    "LM_ADNScanner_Samus_Gamma_002_B_006",
    "LM_ADNScanner_Samus_Gamma_002_B_007",
    "LM_ADNScanner_Samus_Gamma_002_B_008"
  },
  SG_Gamma_002_C = {
    "LM_ADNScanner_Samus_Gamma_002_C_001",
    "LM_ADNScanner_Samus_Gamma_002_C_002",
    "LM_ADNScanner_Samus_Gamma_002_C_003",
    "LM_ADNScanner_Samus_Gamma_002_C_004",
    "LM_ADNScanner_Samus_Gamma_002_C_005",
    "LM_ADNScanner_Samus_Gamma_002_C_006",
    "LM_ADNScanner_Samus_Gamma_002_C_007",
    "LM_ADNScanner_Samus_Gamma_002_C_008",
    "LM_ADNScanner_Samus_Gamma_002_C_009",
    "LM_ADNScanner_Samus_Gamma_002_C_010",
    "LM_ADNScanner_Samus_Gamma_002_C_011"
  }
}
function s050_area5.OnLE_Platform_Elevator_FromArea04(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s040_area4", "ST_FromArea05", _ARG_2_)
end
function s050_area5.PreLE_Platform_Elevator_FromArea04()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s050_area5.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SPAZER_BEAM", "f", 1)
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
function s050_area5.InitFromBlackboard()
  s050_area5.SetAfterChaseSubAreaSetup()
  s050_area5.SetLocationTanksAfterChase()
  if Game.GetEntity("LE_Event_0501") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent0501Launched") then
    Game.GetEntity("LE_Event_0501"):Disable()
  end
  if Game.GetEntity("LE_Event_05_02") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent0502Launched") then
    Game.GetEntity("LE_Event_05_02"):Disable()
  end
end
function s050_area5.OnReloaded()
end
function s050_area5.OnExit()
end
function s050_area5.OnEnter_ActivationTeleport_05_01()
  Game.OnTeleportApproached("LE_Teleporter_05_01")
end
function s050_area5.OnEnter_SetCheckpoint_Gamma_002()
  Game.SetBossCheckPointNames("ST_SG_Gamma_002", "ST_SG_Gamma_002", "SG_Gamma_002_A", "", "")
end
function s050_area5.OnGamma_002_A_Trigger()
  if Game.GetEntity("SG_Gamma_002_A") ~= nil and Scenario.ReadFromBlackboard("entity_TG_Gamma_002_A_enabled", true) then
    Game.GetEntity("SG_Gamma_002_A").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s050_area5.OnGamma_002_Intro_A_Generated(_ARG_0_, _ARG_1_)
  -- if Game.GetEntity("LE_Valve_Gamma_002_Intro_A") ~= nil then
  --   Game.GetEntity("LE_Valve_Gamma_002_Intro_A").ANIMATION:SetAction("spawn")
  -- end
  s050_area5.OnGamma_002_A_Generated(_ARG_0_, _ARG_1_)
end
function s050_area5.OnGamma_002_A_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_002_A")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Gamma_002_A")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_A_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_A_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_A_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_A_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_A_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_A_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_A_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_A_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_A_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_A_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma002_A_Idle_001")
    -- Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_A_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_A_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_A_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_A_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
  end
end
-- function s050_area5.OnGamma_002_B_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_002", "B")
-- end
-- function s050_area5.OnGamma_002_Intro_B_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_002_Intro_B") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_002_Intro_B").ANIMATION:SetAction("spawn")
--   end
--   s050_area5.OnGamma_002_B_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s050_area5.OnGamma_002_B_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Gamma_002_B")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_B_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_B_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma002_B_Idle_001")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
-- function s050_area5.OnGamma_002_C_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_002", "C")
-- end
-- function s050_area5.OnGamma_002_Intro_C_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_002_Intro_C") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_002_Intro_C").ANIMATION:SetAction("spawn")
--   end
--   s050_area5.OnGamma_002_C_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s050_area5.OnGamma_002_C_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_C_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_C_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_C_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_C_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_C_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_C_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma002_C_Idle_001")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_C_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_C_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_C_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_002_C_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
function s050_area5.OnEnter_Gamma_002_Dead()
  if Scenario.ReadFromBlackboard("Arena_Gamma_002_AllDead", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_009", "PostGamma_002", true)
    Game.SetSubAreaCurrentSetup("collision_camera_015", "PostGamma_002", true)
    Game.SetSubAreaCurrentSetup("collision_camera_017", "PostGamma_002", true)
    if Game.GetEntity("SpawnGroup019") ~= nil then
      Game.GetEntity("SpawnGroup019").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup021") ~= nil then
      Game.GetEntity("SpawnGroup021").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup022") ~= nil then
      Game.GetEntity("SpawnGroup022").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup023") ~= nil then
      Game.GetEntity("SpawnGroup023").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup024") ~= nil then
      Game.GetEntity("SpawnGroup024").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s050_area5.OnEnter_SetCheckpoint_Zeta_001()
  Game.SetBossCheckPointNames("ST_SG_Zeta_001", "ST_SG_Zeta_001_Out", "SG_Zeta_001", "", "")
end
function s050_area5.OnZeta_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Zeta_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door009")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI.sNavigableAreaID = "SHAPE_Zeta001"
    _ARG_1_.AI:AddBossCamera("CAM_Zeta")
  end
end
function s050_area5.OnEnter_Zeta_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Zeta_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_008", "PostZeta_001", true)
    if Game.GetEntity("SpawnGroup018") ~= nil then
      Game.GetEntity("SpawnGroup018").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s050_area5.OnMoheek_Chase_Plat_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sMode", "CLOCKWISE")
    _ARG_1_.AI:AddBlackboardParam("bIsPlatformMoheek", true)
    _ARG_1_.AI:SetNavPathPolyGenerationType(true)
  end
end
function s050_area5.OnMoheek_Chase_Path_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:SetNavPathPolyGenerationType(true)
  end
end
function s050_area5.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s050_area5.OnGawron_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 200, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 200, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 100, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 1)
  end
end
function s050_area5.OnGawron_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 150, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 150, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 1)
  end
end
function s050_area5.OnGawron_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 150, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 1)
  end
end
function s050_area5.OnGawron_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, -250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGawron_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, -200, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s050_area5.OnGulluggStr_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_001")
  end
end
function s050_area5.OnGulluggStr_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_002")
  end
end
function s050_area5.OnGulluggStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_003")
  end
end
function s050_area5.OnGulluggStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_004")
  end
end
function s050_area5.OnGulluggStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_005")
  end
end
function s050_area5.OnGulluggStr_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_006")
  end
end
function s050_area5.OnGulluggStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_008")
  end
end
function s050_area5.OnGulluggStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_009")
  end
end
function s050_area5.OnGulluggStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_010")
  end
end
function s050_area5.OnGulluggStr_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_011")
  end
end
function s050_area5.OnGulluggStr_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_012")
  end
end
function s050_area5.OnGulluggStr_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_013")
  end
end
function s050_area5.OnGulluggStr_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_014")
  end
end
function s050_area5.OnGulluggStr_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_015")
  end
end
function s050_area5.OnGulluggStr_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_016")
  end
end
function s050_area5.OnGulluggStr_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_017")
  end
end
function s050_area5.OnGulluggStr_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_018")
  end
end
function s050_area5.OnGulluggStr_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_019")
  end
end
function s050_area5.OnGulluggStr_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_020")
  end
end
function s050_area5.OnGulluggStr_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_021")
  end
end
function s050_area5.OnGulluggStr_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_022")
  end
end
function s050_area5.OnGulluggStr_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_023")
  end
end
function s050_area5.OnGulluggStr_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_024")
  end
end
function s050_area5.OnGulluggStr_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_025")
  end
end
function s050_area5.OnGulluggStr_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_026")
  end
end
function s050_area5.OnGulluggStr_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_027")
  end
end
function s050_area5.OnGulluggStr_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_028")
  end
end
function s050_area5.OnGulluggStr_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_029")
  end
end
function s050_area5.OnGulluggStr_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_030")
  end
end
function s050_area5.OnGulluggStr_031_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_031")
  end
end
function s050_area5.OnParabite_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_001", "ParabitePath_001_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_002", "ParabitePath_001_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s050_area5.OnParabite_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_002")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_002_001", "ParabitePath_002_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_002_002", "ParabitePath_002_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s050_area5.OnWallfire_Chase_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fAttackFrequency", 4)
  end
end
function s050_area5.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == "collision_camera_003" and _ARG_2_ == "collision_camera_008" and not Scenario.ReadFromBlackboard("FirstTimeZetaPresentationPlayed", false) then
    s050_area5.LaunchFirstTimeZetaPresentation()
  end
  if _ARG_0_ == "collision_camera_010" and _ARG_2_ == "collision_camera_BeforeChase1" and not Scenario.ReadFromBlackboard("firstTimeBrokenChozoStatuePlayed", false) then
    s050_area5.LaunchFirstTimeBrokenChozoStatuePresentation()
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s050_area5.LaunchFirstTimeZetaPresentation()
  Scenario.WriteToBlackboard("FirstTimeZetaPresentationPlayed", "b", true)
  s050_area5.OnZetaPresentationCutsceneStart()
  -- Game.LaunchCutscene("cutscenes/introzeta/takes/01/introzeta01.bmscu")
  Game.MetroidRadarForceStateOnBegin(2, -1, true, true)
end
function s050_area5.OnZetaPresentationCutsceneStart()
  Game.SetCameraEnemy("zeta")
  if Game.GetEntity("SG_Zeta_001") ~= nil then
    Game.GetEntity("SG_Zeta_001").SPAWNGROUP:EnableSpawnGroup()
    Game.AddSF(0.5, "Game.MetroidRadarForceStateOnEnd", "")
  end
end
function s050_area5.OnZetaPresentationCutsceneEnd()
end
function s050_area5.LaunchFirstTimeBrokenChozoStatuePresentation()
  Scenario.WriteToBlackboard("firstTimeBrokenChozoStatuePlayed", "b", true)
  Game.SetSceneGroupEnabledByName("sg_disablecs5", false)
  --Game.LaunchCutscene("cutscenes/brokenchozostatue/takes/01/brokenchozostatue01.bmscu")
  if Game.GetEntity("TG_Intro_BrokenChozoStatue") ~= nil then
    Game.GetEntity("TG_Intro_BrokenChozoStatue").TRIGGER:DisableTrigger()
  end
end
function s050_area5.BrokenChozoStatueOnEnd()
  Game.SetSceneGroupEnabledByName("sg_disablecs5", true)
end
function s050_area5.LaunchManicMinerBotChase()
  if Game.GetEntity("SPG_ManicMinerBotHidden") ~= nil then
    Game.GetEntity("SPG_ManicMinerBotHidden").SPAWNGROUP:EnableSpawnGroup()
  end
  Game.LaunchCutscene("cutscenes/intromanicminerbotchase/takes/01/intromanicminerbotchase01.bmscu")
end
function s050_area5.OnManicMinerBotChaseCutsceneStart()
  Game.SetCameraEnemy("manicminerbot")
  Game.SetInGameMusicState("RELAX", true)
  Game.ForceConvertToSamus()
  Game.SetPlayerInputEnabled(false, false)
end
function s050_area5.OnManicMinerBotChaseCutsceneEnd()
  Game.SetPlayerInputEnabled(true, false)
  Game.LoadScenario("c10_samus", "s050_area5", "ST_Diggernaut_Chase_Respawn", "samus", 1)
end
function s050_area5.SetAfterChaseSubAreaSetup()
  Game.SetSubAreaCurrentSetup("collision_camera_AfterChase", "AfterChase", true, false)
  Game.SetSubAreaCurrentSetup("collision_camera_AfterChase_001", "AfterChase", true, false)
  Game.SetSubAreaCurrentSetup("collision_camera_AfterChase_002", "AfterChase", true, false)
  Game.SetSubAreaCurrentSetup("collision_camera_AfterChase_003", "AfterChase", true, false)
  Game.SetSubAreaCurrentSetup("collision_camera_BeforeChase1", "AfterChase", true, false)
  Game.SetSubAreaCurrentSetup("collision_camera_BeforeChase2", "AfterChase", true, false)
  Game.SetSubAreaCurrentSetup("collision_camera_BeforeChase3", "AfterChase", true, false)
  for _FORV_4_, _FORV_5_ in pairs({
    "SpawnGroup025",
    "SpawnGroup039",
    "SpawnGroup040"
  }) do
    print(_FORV_5_)
    if Game.GetEntity(_FORV_5_) ~= nil then
      Game.GetEntity(_FORV_5_).SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s050_area5.SetLocationTanksAfterChase()
  if Scenario.ReadFromBlackboard("ChaseFinished", true) then
    Game.GetEntity("LE_Item_003").vPos = Game.GetLandmarkPosition("LM_TankPosition_AfterChase")
    Game.GetEntity("LE_Item_010").vPos = Game.GetLandmarkPosition("LM_TankPosition_AfterChase001")
  end
end
function s050_area5.OnEnter_AfterChaseEnemies()
  Game.SetSubAreaCurrentSetup("collision_camera_AfterChase", "AfterChaseEnemies", true, false)
  for _FORV_4_, _FORV_5_ in pairs({
    "collision_camera_005",
    "collision_camera_010",
    "collision_camera_011"
  }) do
    print(_FORV_5_)
    Game.SetSubAreaCurrentSetup(_FORV_5_, "AfterChase_IntroLevel", true)
  end
end
function s050_area5.UpdateMinimapItemsphereIcon()
  Scenario.WriteToBlackboard("ChaseFinished", "b", true)
  Game.UpdateSpecifiedMinimapCellIcon(60, 7)
  s050_area5.SetLocationTanksAfterChase()
end
function s050_area5.OnManicMinerBotHiddenStageFinished(_ARG_0_, _ARG_1_)
  if _ARG_0_ == 2 and _ARG_1_ then
    Game.LaunchCutscene("cutscenes/manicminerbotchaseend/takes/01/manicminerbotchaseend01.bmscu")
  else
    Game.SetInGameMusicState("RELAX")
  end
end
function s050_area5.OnManicMinerBotChaseEndCutsceneStart()
  Game.SetPlayerInputEnabled(false, true)
  Game.SetSceneGroupEnabledByName("sg_rocas", false)
  if s050_area5.oManicMinerBotEntity ~= nil then
    s050_area5.oManicMinerBotEntity:DelMe()
    s050_area5.oManicMinerBotEntity = nil
  end
end
function s050_area5.OnManicMinerBotChaseEndCutsceneEnd()
  Game.SetPlayerInputEnabled(true, true)
  Game.AddSF(5, "Game.PlayCurrentEnvironmentMusic", "")
end
function s050_area5.OnManicMinerBotGenerated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    s050_area5.oManicMinerBotEntity = _ARG_1_
    s050_area5.oManicMinerBotEntity:SetVisible(false)
  end
end
function s050_area5.OnPlayerReachedStage1SafePoint()
  if s050_area5.oManicMinerBotEntity ~= nil then
    s050_area5.oManicMinerBotEntity.MOVEMENT:OnPlayerReachedSafePoint()
  end
end
function s050_area5.OnStage2Triggered()
  if not Scenario.ReadFromBlackboard("ChaseFinished", false) and Scenario.ReadFromBlackboard("ManicMinerBotChaseStageIdx", -1) < 1 and s050_area5.oManicMinerBotEntity ~= nil then
    s050_area5.oManicMinerBotEntity.MOVEMENT:StartStage(1, false)
  end
end
function s050_area5.OnPlayerReachedStage2SafePoint()
  if s050_area5.oManicMinerBotEntity ~= nil then
    s050_area5.oManicMinerBotEntity.MOVEMENT:OnPlayerReachedSafePoint()
  end
end
function s050_area5.OnStage3Triggered()
  if not Scenario.ReadFromBlackboard("ChaseFinished", false) and Scenario.ReadFromBlackboard("ManicMinerBotChaseStageIdx", -1) < 2 and s050_area5.oManicMinerBotEntity ~= nil then
    s050_area5.oManicMinerBotEntity.MOVEMENT:StartStage(2, false)
  end
end
function s050_area5.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s050_area5.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s050_area5.OnEnterManicMinerShake()
  Game.PlayDirectionalCameraFXPreset("MANIC_MINER_BOT_SHAKE", V3D(0, 1, 0))
  Game.PlayEntitySound("actors/omega/omega_equake_03.wav", Game.GetPlayer().sName, 1, 5000, 50000, 0.9)
  Game.PlayEntitySound("actors/queen/queen_movement_04.wav", Game.GetPlayer().sName, 1, 5000, 50000, 0.7)
end
function s050_area5.LaunchSpecialEvent0501()
  if Game.GetEntity("LE_Event_0501") ~= nil then
    Game.GetEntity("LE_Event_0501").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("SpecialEvent0501Launched", "b", true)
  end
  Game.DisableTrigger("TG_Event_05")
end
function s050_area5.LaunchSpecialEvent0502()
  if Game.GetEntity("LE_Event_05_02") ~= nil then
    Game.GetEntity("LE_Event_05_02").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("SpecialEvent0502Launched", "b", true)
  end
  Game.DisableTrigger("TG_Event_05_02")
end
function s050_area5.OnEnter_ChangeCamera_005()
  Game.SetCollisionCameraLocked("collision_camera_005_B", true)
end
function s050_area5.OnExit_ChangeCamera_005()
  Game.SetCollisionCameraLocked("collision_camera_005_B", false)
end
function s050_area5.OnEnter_ChangeCamera_001()
  Game.SetCollisionCameraLocked("collision_camera_001_B", true)
end
function s050_area5.OnExit_ChangeCamera_001()
  Game.SetCollisionCameraLocked("collision_camera_001_B", false)
end
function s050_area5.OnEnter_ChangeCamera_009()
  Game.SetCollisionCameraLocked("collision_camera_009", true)
end
function s050_area5.OnExit_ChangeCamera_009()
  Game.SetCollisionCameraLocked("collision_camera_009", false)
end
function s050_area5.OnEnter_ChangeCamera_017()
  Game.SetCollisionCameraLocked("collision_camera_017", true)
end
function s050_area5.OnExit_ChangeCamera_017()
  Game.SetCollisionCameraLocked("collision_camera_017", false)
end
function s050_area5.OnEnter_ChangeCamera_AfterChase()
  Game.SetCollisionCameraLocked("collision_camera_AfterChase_B", true)
end
function s050_area5.OnExit_ChangeCamera_AfterChase()
  Game.SetCollisionCameraLocked("collision_camera_AfterChase_B", false)
end
function s050_area5.OnEnter_ChangeCamera_AfterChase_Transition_01_02()
  Game.SetCollisionCameraLocked("collision_camera_AfterChase_Transition_01_02", true)
end
function s050_area5.OnExit_ChangeCamera_AfterChase_Transition_01_02()
  Game.SetCollisionCameraLocked("collision_camera_AfterChase_Transition_01_02", false)
end
function s050_area5.OnEnter_ChangeCamera_AfterChase_Transition_02_03()
  Game.SetCollisionCameraLocked("collision_camera_AfterChase_Transition_02_03", true)
end
function s050_area5.OnExit_ChangeCamera_AfterChase_Transition_02_03()
  Game.SetCollisionCameraLocked("collision_camera_AfterChase_Transition_02_03", false)
end
