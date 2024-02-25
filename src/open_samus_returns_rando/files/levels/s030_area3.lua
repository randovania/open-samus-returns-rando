Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
Game.ImportLibrary("actors/props/spenergycloud/scripts/spenergycloud.lua", false)
function s030_area3.main()
  Scenario.InitGUI()
end
function s030_area3.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s030_area3.OnEnter_SetCheckpoint_Gamma_005()
  Game.SetBossCheckPointNames("ST_SG_Gamma_005", "ST_SG_Gamma_005", "", "", "SG_Gamma_005_C")
end
-- function s030_area3.OnGamma_005_A_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_005", "A")
-- end
-- function s030_area3.OnGamma_005_Intro_A_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_005_Intro_A") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_005_Intro_A").ANIMATION:SetAction("spawn")
--   end
--   s030_area3.OnGamma_005_A_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s030_area3.OnGamma_005_A_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door015")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_A_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_A_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_A_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_A_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_A_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_A_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_A_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_A_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_A_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_A_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_A_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_A_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_A_mines_004")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_A_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_A_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_A_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_A_mines_004")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_A_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_A_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_A_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_A_mines_004")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma005_A_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_A_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_A_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_A_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_A_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
-- function s030_area3.OnGamma_005_B_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_005", "B")
-- end
-- function s030_area3.OnGamma_005_Intro_B_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_005_Intro_B") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_005_Intro_B").ANIMATION:SetAction("spawn")
--   end
--   s030_area3.OnGamma_005_B_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s030_area3.OnGamma_005_B_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door015")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_B_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_B_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_B_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_B_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_B_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_B_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_B_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_B_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma005_B_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_B_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_B_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
function s030_area3.OnGamma_005_C_Trigger()
  if Game.GetEntity("SG_Gamma_005_C") ~= nil and Scenario.ReadFromBlackboard("entity_TG_Gamma_005_C_enabled", true) then
    Game.GetEntity("SG_Gamma_005_C").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s030_area3.OnGamma_005_Intro_C_Generated(_ARG_0_, _ARG_1_)
  -- if Game.GetEntity("LE_Valve_Gamma_005_C_002") ~= nil then
  --   Game.GetEntity("LE_Valve_Gamma_005_C_002").ANIMATION:SetAction("spawn")
  -- end
  s030_area3.OnGamma_005_C_Generated(_ARG_0_, _ARG_1_)
end
function s030_area3.OnGamma_005_C_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_005_C")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door015")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_C_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_C_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma005_C_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_C_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_C_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma005_C_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_C_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_C_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma005_C_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_C_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_C_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma005_C_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_C_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_C_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma005_C_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_C_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_C_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma005_C_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma005_C_Idle")
    -- Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_C_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_C_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_C_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_005_C_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
  end
end
function s030_area3.OnEnter_Gamma_005_Dead()
  if Scenario.ReadFromBlackboard("Arena_Gamma_005_AllDead", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_038", "PostGamma_005", true)
    Game.SetSubAreaCurrentSetup("collision_camera_039", "PostGamma_005", true)
    if Game.GetEntity("SpawnGroup014") ~= nil then
      Game.GetEntity("SpawnGroup014").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup015") ~= nil then
      Game.GetEntity("SpawnGroup015").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup016") ~= nil then
      Game.GetEntity("SpawnGroup016").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s030_area3.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPACE_JUMP", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_VARIA_SUIT", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
end
function s030_area3.OnLE_Platform_Elevator_FromArea02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s028_area2c", "ST_FromArea03", _ARG_2_)
end
function s030_area3.OnLE_Platform_Elevator_FromArea04(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s040_area4", "ST_FromArea03", _ARG_2_)
end
function s030_area3.PreLE_Platform_Elevator_FromArea02()
  GUI.ElevatorSetTarget("s030_area3_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s030_area3.PreLE_Platform_Elevator_FromArea04()
  GUI.ElevatorSetTarget("s040_area4_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s030_area3.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea02" then
    GUI.ElevatorSetTarget("s030_area3_elevator", true)
  elseif _ARG_0_ == "ST_FromArea04" then
    GUI.ElevatorSetTarget("s040_area4_elevator", false)
  end
end
function s030_area3.InitFromBlackboard()
  if Game.GetEntity("LE_Event_03") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent03Launched") then
    Game.GetEntity("LE_Event_03"):Disable()
  end
end
function s030_area3.LaunchSpecialEnergyCutscene()
  Game.LaunchCutscene("cutscenes/energywave/takes/01/energywave01.bmscu")
end
function s030_area3.OnStartSpecialEnergyCutscene()
end
function s030_area3.OnEndSpecialEnergyCutscene()
  guicallbacks.OnPickableItemPickedUp("#GUI_ITEM_ACQUIRED_WEAPON_BOOST", true)
end
function s030_area3.OnReloaded()
end
function s030_area3.OnExit()
end
function s030_area3.OnEnter_ActivationDNA()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA", 10)
end
function s030_area3.OnEnter_ActivationTeleport_03A_001()
  Game.OnTeleportApproached("LE_Teleporter_03A_001")
end
function s030_area3.OnEnter_ActivationTeleport_03A_002()
  Game.OnTeleportApproached("LE_Teleporter_03A_002")
end
s030_area3.tDNAScanLandmarks = {
  SG_Gamma_005_A = {
    "LM_ADNScanner_Samus_Gamma_005_A_001",
    "LM_ADNScanner_Samus_Gamma_005_A_002",
    "LM_ADNScanner_Samus_Gamma_005_A_003",
    "LM_ADNScanner_Samus_Gamma_005_A_004",
    "LM_ADNScanner_Samus_Gamma_005_A_005",
    "LM_ADNScanner_Samus_Gamma_005_A_006",
    "LM_ADNScanner_Samus_Gamma_005_A_007",
    "LM_ADNScanner_Samus_Gamma_005_A_008",
    "LM_ADNScanner_Samus_Gamma_005_A_009",
    "LM_ADNScanner_Samus_Gamma_005_A_010",
    "LM_ADNScanner_Samus_Gamma_005_A_011",
    "LM_ADNScanner_Samus_Gamma_005_A_012",
    "LM_ADNScanner_Samus_Gamma_005_A_013"
  },
  SG_Gamma_005_B = {
    "LM_ADNScanner_Samus_Gamma_005_B_001",
    "LM_ADNScanner_Samus_Gamma_005_B_002",
    "LM_ADNScanner_Samus_Gamma_005_B_003",
    "LM_ADNScanner_Samus_Gamma_005_B_004",
    "LM_ADNScanner_Samus_Gamma_005_B_005",
    "LM_ADNScanner_Samus_Gamma_005_B_006",
    "LM_ADNScanner_Samus_Gamma_005_B_007",
    "LM_ADNScanner_Samus_Gamma_005_B_008",
    "LM_ADNScanner_Samus_Gamma_005_B_009",
    "LM_ADNScanner_Samus_Gamma_005_B_010",
    "LM_ADNScanner_Samus_Gamma_005_B_011"
  },
  SG_Gamma_005_C = {
    "LM_ADNScanner_Samus_Gamma_005_C_001",
    "LM_ADNScanner_Samus_Gamma_005_C_002",
    "LM_ADNScanner_Samus_Gamma_005_C_003",
    "LM_ADNScanner_Samus_Gamma_005_C_004",
    "LM_ADNScanner_Samus_Gamma_005_C_005",
    "LM_ADNScanner_Samus_Gamma_005_C_006",
    "LM_ADNScanner_Samus_Gamma_005_C_007",
    "LM_ADNScanner_Samus_Gamma_005_C_008",
    "LM_ADNScanner_Samus_Gamma_005_C_009",
    "LM_ADNScanner_Samus_Gamma_005_C_010",
    "LM_ADNScanner_Samus_Gamma_005_C_011",
    "LM_ADNScanner_Samus_Gamma_005_C_012",
    "LM_ADNScanner_Samus_Gamma_005_C_013"
  }
}
function s030_area3.OnLE_Platform_Elevator_FromArea03B_01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s033_area3b", "ST_FromArea03A_01", _ARG_2_)
end
function s030_area3.OnLE_Platform_Elevator_FromArea03B_02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s033_area3b", "ST_FromArea03A_02", _ARG_2_)
end
function s030_area3.OnLE_Platform_Elevator_FromArea03C(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s036_area3c", "ST_FromArea03A", _ARG_2_)
end
function s030_area3.PreLE_Platform_Elevator_FromArea03B_01()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s030_area3.PreLE_Platform_Elevator_FromArea03B_02()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s030_area3.PreLE_Platform_Elevator_FromArea03C()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s030_area3.OnHazarousPoolDrain()
  Game.SetSubAreaCurrentSetup("collision_camera_002", "Hazarous_empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_001", "Hazarous_empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_032", "Hazarous_empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_033", "Hazarous_empty", true)
end
function s030_area3.OnEnterHazardous()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_002", "Enter_Hazardous", false)
end
function s030_area3.OnExitHazardous()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_002", "Default", false)
end
function s030_area3.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s030_area3.OnGenericCrawlerLeft_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s030_area3.OnGravittBuried_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s030_area3.OnHalzyn_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_008")
  end
end
function s030_area3.OnHalzyn_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_009")
  end
end
function s030_area3.OnHalzyn_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_011")
  end
end
function s030_area3.OnHalzyn_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_012")
  end
end
function s030_area3.OnHalzyn_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_013")
  end
end
function s030_area3.OnHalzyn_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_014")
  end
end
function s030_area3.OnHalzyn_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_016")
  end
end
function s030_area3.OnHalzyn_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_017")
  end
end
function s030_area3.OnHalzyn_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_018")
  end
end
function s030_area3.OnHalzyn_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_019")
  end
end
function s030_area3.OnHalzyn_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_020")
  end
end
function s030_area3.OnHalzyn_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_021")
  end
end
function s030_area3.OnHalzyn_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "HalzynPath_022")
  end
end
function s030_area3.OnGlowflyPuzzle_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fDirX", 1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", true)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_001")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(true)
  end
end
function s030_area3.OnGlowflyPuzzle_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fDirX", 1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", true)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_002")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(true)
  end
end
function s030_area3.OnGlowflyPuzzle_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_003")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s030_area3.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s030_area3.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s030_area3.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s030_area3.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s030_area3.OnBeeSwarm_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_002_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_002_002")
  end
end
function s030_area3.OnBlobthrower_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("bPeaceful", true)
    _ARG_1_.AI:AddRightSwarmPaths("Path_Blobthrower_001_RightPath", "Path_Blobthrower_001_RightAttackPath")
    _ARG_1_.AI:AddLeftSwarmPaths("Path_Blobthrower_001_LeftPath", "Path_Blobthrower_001_LeftAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_001_DeadPath")
    _ARG_1_.AI:AddDeadSwarmPaths("Path_Blobthrower_001_DeadPath", "Path_Blobthrower_001_DeadAttackPath")
  end
end
function s030_area3.OnBlobthrower_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("bPeaceful", true)
    _ARG_1_.AI:AddRightSwarmPaths("Path_Blobthrower_002_RightPath", "Path_Blobthrower_002_RightAttackPath")
    _ARG_1_.AI:AddLeftSwarmPaths("Path_Blobthrower_002_LeftPath", "Path_Blobthrower_002_LeftAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_002_DeadPath")
    _ARG_1_.AI:AddDeadSwarmPaths("Path_Blobthrower_002_DeadPath", "Path_Blobthrower_002_DeadAttackPath")
  end
end
function s030_area3.OnBlobthrower_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddRightSwarmPaths("Path_Blobthrower_003_RightPath", "Path_Blobthrower_003_RightAttackPath")
    _ARG_1_.AI:AddLeftSwarmPaths("Path_Blobthrower_003_LeftPath", "Path_Blobthrower_003_LeftAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_003_DeadPath")
    _ARG_1_.AI:AddDeadSwarmPaths("Path_Blobthrower_003_DeadPath", "Path_Blobthrower_003_DeadAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_003_ChangePath")
  end
end
function s030_area3.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ ~= "collision_camera_002" or _ARG_2_ ~= "collision_camera_036" or not Scenario.ReadFromBlackboard("CamAreaPresentation", false) then
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s030_area3.LaunchAreaPresentation()
  Scenario.WriteToBlackboard("CamAreaPresentation", "b", true)
  Game.LaunchCutscene("cutscenes/area3cam/takes/01/area3cam01.bmscu")
  if Game.GetEntity("TG_Area3Cam") ~= nil then
    Game.GetEntity("TG_Area3Cam"):Disable()
  end
end
function s030_area3.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s030_area3.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s030_area3.LaunchSpecialEvent03()
  if Game.GetEntity("LE_Event_03") ~= nil then
    Game.GetEntity("LE_Event_03").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("SpecialEvent03Launched", "b", true)
  end
end
function s030_area3.OnEnter_ChangeCamera_001()
  Game.SetSubAreaCurrentSetup("collision_camera_016", "ChangeCamera_001", false)
end
function s030_area3.OnExit_ChangeCamera_001()
  Game.SetSubAreaCurrentSetup("collision_camera_016", "Default", false)
end
function s030_area3.OnEnter_ChangeCamera_022()
  Game.SetCollisionCameraLocked("collision_camera_022_B", true)
end
function s030_area3.OnExit_ChangeCamera_022()
  Game.SetCollisionCameraLocked("collision_camera_022_B", false)
end
function s030_area3.OnEnter_ChangeCamera_030()
  Game.SetCollisionCameraLocked("collision_camera_030_B", true)
end
function s030_area3.OnExit_ChangeCamera_030()
  Game.SetCollisionCameraLocked("collision_camera_030_B", false)
end
function s030_area3.OnEnter_ChangeCamera_032()
  Game.SetCollisionCameraLocked("collision_camera_032_B", true)
end
function s030_area3.OnExit_ChangeCamera_032()
  Game.SetCollisionCameraLocked("collision_camera_032_B", false)
end
function s030_area3.OnEnter_ChangeCamera_037()
  Game.SetCollisionCameraLocked("collision_camera_037_B", true)
end
function s030_area3.OnExit_ChangeCamera_037()
  Game.SetCollisionCameraLocked("collision_camera_037_B", false)
end
function s030_area3.OnEnter_ChangeCamera_038()
  Game.SetCollisionCameraLocked("collision_camera_038_B", true)
end
function s030_area3.OnExit_ChangeCamera_038()
  Game.SetCollisionCameraLocked("collision_camera_038_B", false)
end
function s030_area3.OnEnter_ChangeCamera_038_C()
  Game.SetCollisionCameraLocked("collision_camera_038_C", true)
end
function s030_area3.OnExit_ChangeCamera_038_C()
  Game.SetCollisionCameraLocked("collision_camera_038_C", false)
end
function s030_area3.OnEnter_ChangeCamera_040()
  Game.SetSubAreaCurrentSetup("collision_camera_040", "ChangeCamera", false)
end
function s030_area3.OnExit_ChangeCamera_040()
  Game.SetSubAreaCurrentSetup("collision_camera_040", "Default", false)
end
function s030_area3.OnEnter_ChangeCamera_041()
  Game.SetCollisionCameraLocked("collision_camera_041_B", true)
end
function s030_area3.OnExit_ChangeCamera_041()
  Game.SetCollisionCameraLocked("collision_camera_041_B", false)
end
