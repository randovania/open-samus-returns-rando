function s036_area3c.main()
  Scenario.InitGUI()
end
function s036_area3c.SetupDebugGameBlackboard()
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
function s036_area3c.InitFromBlackboard()
  Game.SetArenaDefaultSpawnGroup("Gamma_007", "SG_Gamma_007_A")
  s036_area3c.DeactivateEvents()
end
function s036_area3c.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s036_area3c.OnEnter_ActivationTeleport_03_01()
  Game.OnTeleportApproached("LE_Teleporter_03_01")
end
s036_area3c.tDNAScanLandmarks = {
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
    "LM_ADNScanner_Samus_Alpha_001_014",
    "LM_ADNScanner_Samus_Alpha_001_015"
  },
  SG_Gamma_006 = {
    "LM_ADNScanner_Samus_Gamma_006_001",
    "LM_ADNScanner_Samus_Gamma_006_002",
    "LM_ADNScanner_Samus_Gamma_006_003",
    "LM_ADNScanner_Samus_Gamma_006_004",
    "LM_ADNScanner_Samus_Gamma_006_005",
    "LM_ADNScanner_Samus_Gamma_006_006",
    "LM_ADNScanner_Samus_Gamma_006_007",
    "LM_ADNScanner_Samus_Gamma_006_008",
    "LM_ADNScanner_Samus_Gamma_006_009",
    "LM_ADNScanner_Samus_Gamma_006_010",
    "LM_ADNScanner_Samus_Gamma_006_011",
    "LM_ADNScanner_Samus_Gamma_006_012"
  },
  SG_Gamma_007_A = {
    "LM_ADNScanner_Samus_Gamma_007_A_001",
    "LM_ADNScanner_Samus_Gamma_007_A_002",
    "LM_ADNScanner_Samus_Gamma_007_A_003",
    "LM_ADNScanner_Samus_Gamma_007_A_004",
    "LM_ADNScanner_Samus_Gamma_007_A_005",
    "LM_ADNScanner_Samus_Gamma_007_A_006",
    "LM_ADNScanner_Samus_Gamma_007_A_007",
    "LM_ADNScanner_Samus_Gamma_007_A_008",
    "LM_ADNScanner_Samus_Gamma_007_A_009",
    "LM_ADNScanner_Samus_Gamma_007_A_010",
    "LM_ADNScanner_Samus_Gamma_007_A_011",
    "LM_ADNScanner_Samus_Gamma_007_A_012",
    "LM_ADNScanner_Samus_Gamma_007_A_013",
    "LM_ADNScanner_Samus_Gamma_007_A_014",
    "LM_ADNScanner_Samus_Gamma_007_A_015",
    "LM_ADNScanner_Samus_Gamma_007_A_016"
  },
  SG_Gamma_007_B = {
    "LM_ADNScanner_Samus_Gamma_007_B_001",
    "LM_ADNScanner_Samus_Gamma_007_B_002",
    "LM_ADNScanner_Samus_Gamma_007_B_003",
    "LM_ADNScanner_Samus_Gamma_007_B_004",
    "LM_ADNScanner_Samus_Gamma_007_B_005",
    "LM_ADNScanner_Samus_Gamma_007_B_006",
    "LM_ADNScanner_Samus_Gamma_007_B_007",
    "LM_ADNScanner_Samus_Gamma_007_B_008",
    "LM_ADNScanner_Samus_Gamma_007_B_009",
    "LM_ADNScanner_Samus_Gamma_007_B_010",
    "LM_ADNScanner_Samus_Gamma_007_B_011",
    "LM_ADNScanner_Samus_Gamma_007_B_012",
    "LM_ADNScanner_Samus_Gamma_007_B_013"
  }
}
function s036_area3c.OnLE_Platform_Elevator_FromArea03A(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s030_area3", "ST_FromArea03C", _ARG_2_)
end
function s036_area3c.OnLE_Platform_Elevator_FromArea03B(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s033_area3b", "ST_FromArea03C", _ARG_2_)
end
function s036_area3c.PreLE_Platform_Elevator_FromArea03A()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s036_area3c.PreLE_Platform_Elevator_FromArea03B()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s036_area3c.OnEnter_SetCheckpoint_001_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001", "ST_SG_Alpha_001", "SG_Alpha_001", "", "")
end
function s036_area3c.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_001")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door013")
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
function s036_area3c.OnEnter_Alpha_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_001_deaths", 0) and Game.GetEntity("SpawnGroup006") ~= nil then
    Game.GetEntity("SpawnGroup006").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s036_area3c.OnGamma_006_Discovered()
  if Game.GetEntityFromSpawnPoint("SP_Gamma_006_Intro") ~= nil then
    Game.GetEntityFromSpawnPoint("SP_Gamma_006_Intro").MOVEMENT:SetState("Flying")
    Game.GetEntityFromSpawnPoint("SP_Gamma_006_Intro").ANIMATION:SetAction("waitinginlairendpre", false)
  end
  if Game.GetEntity("LE_Gamma_006_Valve") ~= nil then
    Game.GetEntity("LE_Gamma_006_Valve").ANIMATION:SetAction("use", false)
  end
  if Game.GetEntity("SP_Gamma_006") ~= nil and Game.GetEntity("SP_Gamma_006").SPAWNPOINT ~= nil then
    Game.GetEntity("SP_Gamma_006").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("SP_Gamma_006_Intro") ~= nil and Game.GetEntity("SP_Gamma_006_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("SP_Gamma_006_Intro").SPAWNPOINT:Deactivate()
  end
end
function s036_area3c.OnEnter_SetCheckpoint_001_Gamma_006()
  Game.SetBossCheckPointNames("ST_SG_Gamma_006", "ST_SG_Gamma_006_Out", "SG_Gamma_006", "", "")
end
function s036_area3c.OnEnter_SetCheckpoint_002_Gamma_006()
  Game.SetBossCheckPointNames("ST_SG_Gamma_006B", "ST_SG_Gamma_006B_Out", "SG_Gamma_006", "", "")
end
function s036_area3c.OnGamma_006_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_006")
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddBossCameraCeilingLandmark("LM_Gamma_006_Ceiling")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma006_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma006_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma006_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma006_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma006_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma006_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma006_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma006_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma006_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma006_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma006_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma006_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma006_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma006_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma006_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma006_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma006_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma006_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma006_Idle")
    _ARG_1_.AI.vInLairTilePos = V3D(5800, 4800, 0)
    _ARG_1_.AI.sInLairCallback = "s036_area3c.OnGamma_006_Discovered"
  end
end
function s036_area3c.OnEnter_Gamma_006_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Gamma_006_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_023", "PostGamma_006", true)
    Game.SetSubAreaCurrentSetup("collision_camera_030", "PostGamma_006", true)
    if Game.GetEntity("SpawnGroup007") ~= nil then
      Game.GetEntity("SpawnGroup007").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s036_area3c.OnGamma_007_A_Trigger()
  if Game.GetEntity("SG_Gamma_007_A") ~= nil and Scenario.ReadFromBlackboard("entity_TG_Gamma_007_A_enabled", true) then
    Game.GetEntity("SG_Gamma_007_A").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s036_area3c.OnGamma_007_Intro_A_Generated(_ARG_0_, _ARG_1_)
  -- if Game.GetEntity("LE_Valve_Gamma_007_Intro_A") ~= nil then
  --   Game.GetEntity("LE_Valve_Gamma_007_Intro_A").ANIMATION:SetAction("spawn")
  -- end
  s036_area3c.OnGamma_007_A_Generated(_ARG_0_, _ARG_1_)
end
function s036_area3c.OnEnter_SetCheckpoint_001_Gamma_007()
  Game.SetBossCheckPointNames("ST_SG_Gamma_007", "ST_SG_Gamma_007", "SG_Gamma_007_A", "", "")
end
function s036_area3c.OnGamma_007_A_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_007_A")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door006")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddBossCameraCeilingLandmark("LM_Gamma_007A_Ceiling")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma007_A_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma007_A_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma007_A_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma007_A_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma007_A_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma007_A_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma007_A_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma007_A_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma007_A_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_A_mines_004")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_A_mines_004")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_A_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_A_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_A_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_A_mines_004")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma007_A_Idle")
    -- Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_A_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_A_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_A_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_A_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
  end
end
-- function s036_area3c.OnGamma_007_B_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_007", "B")
-- end
-- function s036_area3c.OnGamma_007_Intro_B_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_007_Intro_B") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_007_Intro_B").ANIMATION:SetAction("spawn")
--   end
--   s036_area3c.OnGamma_007_B_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s036_area3c.OnGamma_007_B_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door006")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddBossCameraCeilingLandmark("LM_Gamma_007B_Ceiling")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma007_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma007_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma007_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma007_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma007_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma007_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma007_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma007_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma007_B_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma007_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma007_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma007_B_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma007_B_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_007_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
function s036_area3c.OnEnter_Gamma_007_Dead()
  if Scenario.ReadFromBlackboard("Arena_Gamma_007_AllDead", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_013", "PostGamma_007", true)
    Game.SetSubAreaCurrentSetup("collision_camera_027", "PostGamma_007", true)
    if Game.GetEntity("SpawnGroup008") ~= nil then
      Game.GetEntity("SpawnGroup008").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s036_area3c.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s036_area3c.OnMumbo_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_001")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s036_area3c.OnMumbo_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_002")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s036_area3c.OnMumbo_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_003")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s036_area3c.OnMumbo_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_004")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s036_area3c.OnMumbo_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MumboPath_005")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s036_area3c.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s036_area3c.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s036_area3c.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s036_area3c.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s036_area3c.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s036_area3c.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s036_area3c.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s036_area3c.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s036_area3c.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s036_area3c.OnGullugg_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s036_area3c.OnGullugg_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s036_area3c.OnGunzoo_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_001")
  end
end
function s036_area3c.OnParabite_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_Attack_001", "ParabitePath_001_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_Attack_002", "ParabitePath_001_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s036_area3c.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s036_area3c.OnEnter_MinimapSecretUncover_001()
  Game.MinimapUncoverSpecifiedCellSecretLeft(41, 31)
end
function s036_area3c.OnEnter_MinimapSecretUncover_002()
  Game.MinimapUncoverSpecifiedCellSecretLeft(40, 31)
end
function s036_area3c.LaunchSpecialEvent03c1()
  if Game.GetEntity("LE_Event_03c1") ~= nil then
    Game.GetEntity("LE_Event_03c1").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("Event_03c1_Launched", "b", true)
  end
end
function s036_area3c.LaunchSpecialEvent03c2()
  if Game.GetEntity("LE_Event_03c2") ~= nil then
    Game.GetEntity("LE_Event_03c2").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("Event_03c2_Launched", "b", true)
  end
end
function s036_area3c.LaunchSpecialEvent03c3()
  if Game.GetEntity("LE_Event_03c3") ~= nil then
    Game.GetEntity("LE_Event_03c3").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("Event_03c3_Launched", "b", true)
  end
end
function s036_area3c.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == "collision_camera_018" then
    s036_area3c.DeactivateEvents()
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s036_area3c.DeactivateEvents()
  if Game.GetEntity("LE_Event_03c1") ~= nil and Scenario.ReadFromBlackboard("Event_03c1_Launched") then
    Game.GetEntity("LE_Event_03c1"):Disable()
  end
  if Game.GetEntity("LE_Event_03c2") ~= nil and Scenario.ReadFromBlackboard("Event_03c2_Launched") then
    Game.GetEntity("LE_Event_03c2"):Disable()
  end
  if Game.GetEntity("LE_Event_03c3") ~= nil and Scenario.ReadFromBlackboard("Event_03c3_Launched") then
    Game.GetEntity("LE_Event_03c3"):Disable()
  end
end
function s036_area3c.OnEnter_ChangeCamera_018()
  Game.SetCollisionCameraLocked("collision_camera_018_B", true)
end
function s036_area3c.OnExit_ChangeCamera_018()
  Game.SetCollisionCameraLocked("collision_camera_018_B", false)
end
