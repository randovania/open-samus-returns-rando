Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s070_area7.main()
  Scenario.InitGUI()
end
function s070_area7.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s070_area7.SetupDebugGameBlackboard()
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_SPECIAL_ENERGY", "f", 1000)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MAX_SPECIAL_ENERGY", "f", 1000)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_LIFE", "f", 399)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MAX_LIFE", "f", 399)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_MAX", "f", 100)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_CURRENT", "f", 100)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_MAX", "f", 25)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_CURRENT", "f", 25)
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_PLASMA_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_GRAPPLE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPACE_JUMP", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_VARIA_SUIT", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_GRAVITY_SUIT", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SCREW_ATTACK", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 1)
end
function s070_area7.OnLE_Platform_Elevator_FromArea06(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s060_area6", "ST_FromArea07", _ARG_2_)
end
function s070_area7.OnLE_Platform_Elevator_FromArea09(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s090_area9", "ST_FromArea07", _ARG_2_)
end
function s070_area7.PreLE_Platform_Elevator_FromArea06()
  GUI.ElevatorSetTarget("s070_area7_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s070_area7.PreLE_Platform_Elevator_FromArea09()
  GUI.ElevatorSetTarget("s090_area9_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s070_area7.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea06" then
    GUI.ElevatorSetTarget("s070_area7_elevator", true)
  elseif _ARG_0_ == "ST_FromArea09" then
    GUI.ElevatorSetTarget("s090_area9_elevator", true)
  end
end
s070_area7.tDNAScanLandmarks = {
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
  SG_Omega_001 = {
    "LM_ADNScanner_Samus_Omega_001_001",
    "LM_ADNScanner_Samus_Omega_001_002",
    "LM_ADNScanner_Samus_Omega_001_003",
    "LM_ADNScanner_Samus_Omega_001_004",
    "LM_ADNScanner_Samus_Omega_001_005",
    "LM_ADNScanner_Samus_Omega_001_006",
    "LM_ADNScanner_Samus_Omega_001_007",
    "LM_ADNScanner_Samus_Omega_001_008",
    "LM_ADNScanner_Samus_Omega_001_009",
    "LM_ADNScanner_Samus_Omega_001_010",
    "LM_ADNScanner_Samus_Omega_001_011",
    "LM_ADNScanner_Samus_Omega_001_012",
    "LM_ADNScanner_Samus_Omega_001_013"
  }
}
function s070_area7.InitFromBlackboard()
  Game.SetSubAreaCurrentSetup("collision_camera_037", "Omega_Enabled", true)
  Scenario.WriteToBlackboard("OmegaDiscovered", "b", true)
  s070_area7.SetLowModelsVisibility(false)
  if Blackboard.GetProp("s070_area7", "entity_LE_HazarousPool_001_enabled") == nil then
    Game.GetEntity("LE_HazarousPool_001").HAZAROUSPOOL:Activate(true)
    Game.GetEntity("LE_HazarousPool_002").HAZAROUSPOOL:Activate(false)
  end
  s070_area7.OnFansInit()
  if Scenario.ReadFromBlackboard("OmegaDiscovered", false) then
    Game.SetSceneGroupEnabledByName("sg_SubArea_ValveOmega", false)
  else
    Game.SetSceneGroupEnabledByName("sg_SubArea_ValveOmega", true)
  end
end
function s070_area7.OnReloaded()
end
function s070_area7.OnExit()
  s070_area7.SetLowModelsVisibility(false)
end
function s070_area7.OnEnter_ActivationDNA_001()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA_001", 1)
end
function s070_area7.OnEnter_ActivationDNA_002()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA_002", 1)
end
function s070_area7.OnEnter_ActivationTeleport_07_01()
  Game.OnTeleportApproached("LE_Teleporter_07_01")
end
function s070_area7.OnEnter_ActivationTeleport_07_02()
  Game.OnTeleportApproached("LE_Teleporter_07_02")
end
function s070_area7.OnHazarousPoolDrain(_ARG_0_)
  --if _ARG_0_ == "LE_HazarousPool_001" then
  --  Game.SetSubAreaCurrentSetup("collision_camera_037", "Omega_Enabled", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_A", "Hazardous_Phase_02", true)
  --  Scenario.WriteToBlackboard("OmegaDiscovered", "b", true)
  --  Game.SetSceneGroupEnabledByName("sg_SubArea_ValveOmega", false)
  --  Game.SetSubAreaCurrentSetup("collision_camera_051", "Hazardous_Phase_02", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_060", "Hazardous_Phase_02", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_042", "Hazardous_Phase_02", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_B", "Hazardous_Phase_02", true)
  --elseif _ARG_0_ == "LE_HazarousPool_002" then
  --  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_A", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_051", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_060", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_B", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_034", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_035", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_043", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_045", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_044", "Hazardous_Phase_03", true)
  --  Game.SetSubAreaCurrentSetup("collision_camera_042", "Hazardous_Phase_03", true)
  --end
  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_A", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_051", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_060", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_B", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_034", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_035", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_043", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_045", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_044", "Hazardous_Phase_03", true)
  Game.SetSubAreaCurrentSetup("collision_camera_042", "Hazardous_Phase_03", true)
end
function s070_area7.OnEnterHazardous_001()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_A", "Enter_Hazardous_001", false)
end
function s070_area7.OnExitHazardous_001()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_Hazard_End_A", "Default", false)
end
function s070_area7.OnZeta_001_Intro_Generated(_ARG_0_, _ARG_1_)
  s070_area7.OnZeta_001_Generated(_ARG_0_, _ARG_1_)
end
function s070_area7.Spawn_Zeta_001_Intro()
  Game.DisableTrigger("TG_Zeta_001_Intro")
  Game.GetEntityFromSpawnPoint("Zeta_001_Intro").ANIMATION:SetAction("spawn71", true)
  if Game.GetEntity("Zeta_001") ~= nil and Game.GetEntity("Zeta_001").SPAWNPOINT ~= nil then
    Game.GetEntity("Zeta_001").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Zeta_001_Intro") ~= nil and Game.GetEntity("Zeta_001_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Zeta_001_Intro").SPAWNPOINT:Deactivate()
  end
end
function s070_area7.OnEnter_SetCheckpoint_001_Zeta_001()
  Game.SetBossCheckPointNames("ST_SG_Zeta_001", "ST_SG_Zeta_001_Out", "SG_Zeta_001", "", "")
end
function s070_area7.OnEnter_SetCheckpoint_002_Zeta_001()
  Game.SetBossCheckPointNames("ST_SG_Zeta_001B", "ST_SG_Zeta_001B_Out", "SG_Zeta_001", "", "")
end
function s070_area7.OnZeta_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Zeta_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door021")
    -- _ARG_1_.AI:AddBossDoor("Door022")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI.sNavigableAreaID = "SHAPE_Zeta001"
    _ARG_1_.AI:AddBossCamera("CAM_Zeta")
  end
end
function s070_area7.OnEnter_Zeta_001_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Zeta_001_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_048", "PostZeta_001", true)
    if Game.GetEntity("SpawnGroup058") ~= nil then
      Game.GetEntity("SpawnGroup058").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s070_area7.OnEnter_SetCheckpoint_001_Omega_001()
  Game.SetBossCheckPointNames("ST_SG_Omega_001", "ST_SG_Omega_001_Out", "SG_Omega_001", "", "")
end
function s070_area7.OnEnter_SetCheckpoint_002_Omega_001()
  Game.SetBossCheckPointNames("ST_SG_Omega_001B", "ST_SG_Omega_001B_Out", "SG_Omega_001", "", "")
end
function s070_area7.OnEnter_SetCheckpoint_003_Omega_001()
  Game.SetBossCheckPointNames("ST_SG_Omega_001C", "ST_SG_Omega_001C", "SG_Omega_001", "", "")
end
function s070_area7.OnOmega_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Omega_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door015")
    -- _ARG_1_.AI:AddBossDoor("Door023")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Omega")
    _ARG_1_.AI:AddLandmark("LM_CrushingJumpLeft", "LM_CrushingJumpLeft_001")
    _ARG_1_.AI:AddLandmark("LM_CrushingJumpRight", "LM_CrushingJumpRight_001")
    _ARG_1_.AI:AddLandmark("LM_SlapLeft", "LM_SlapLeft_001")
    _ARG_1_.AI:AddLandmark("LM_SlapRight", "LM_SlapRight_001")
    _ARG_1_.AI:AddLandmark("LM_PlasmaArcLeft", "LM_PlasmaArcLeft_001")
    _ARG_1_.AI:AddLandmark("LM_PlasmaArcRight", "LM_PlasmaArcRight_001")
    _ARG_1_.AI:AddLandmark("LM_ArenaLeft", "LM_ArenaLeft_001")
    _ARG_1_.AI:AddLandmark("LM_ArenaRight", "LM_ArenaRight_001")
  end
end
function s070_area7.OnEnter_Omega_001_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Omega_001_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_037", "PostOmega_001", true)
    if Game.GetEntity("SpawnGroup032") ~= nil then
      Game.GetEntity("SpawnGroup032").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.SetSceneGroupEnabledByName("sg_SubArea_Omega_001_Wall", false)
  end
end
function s070_area7.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s070_area7.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s070_area7.OnBeeSwarm_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_002_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_002_002")
  end
end
function s070_area7.OnBeeSwarm_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_003_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_003_002")
  end
end
function s070_area7.OnDrivelStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_008")
  end
end
function s070_area7.OnDrivelStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_009")
  end
end
function s070_area7.OnDrivelStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_010")
  end
end
function s070_area7.OnDrivelStr_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_012")
  end
end
function s070_area7.OnDrivelStr_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_019")
  end
end
function s070_area7.OnDrivelStr_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_020")
  end
end
function s070_area7.OnDrivelStr_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_021")
  end
end
function s070_area7.OnDrivelStr_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_022")
  end
end
function s070_area7.OnDrivelStr_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_023")
  end
end
function s070_area7.OnDrivelStr_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_024")
  end
end
function s070_area7.OnDrivelStr_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_025")
  end
end
function s070_area7.OnGulluggStr_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s070_area7.OnGulluggStr_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s070_area7.OnGulluggStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s070_area7.OnGulluggStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s070_area7.OnGulluggStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s070_area7.OnGulluggStr_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s070_area7.OnGulluggStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s070_area7.OnGulluggStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s070_area7.OnGulluggStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s070_area7.OnGulluggStr_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s070_area7.OnGulluggStr_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s070_area7.OnGulluggStr_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s070_area7.OnGulluggStr_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_014")
  end
end
function s070_area7.OnGulluggStr_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s070_area7.OnGulluggStr_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_016")
  end
end
function s070_area7.OnGulluggStr_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_019")
  end
end
function s070_area7.OnGulluggStr_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_020")
  end
end
function s070_area7.OnGulluggStr_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_021")
  end
end
function s070_area7.OnGulluggStr_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_022")
  end
end
function s070_area7.OnGulluggStr_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_023")
  end
end
function s070_area7.OnGulluggStr_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_024")
  end
end
function s070_area7.OnGulluggStr_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_025")
  end
end
function s070_area7.OnGulluggStr_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_026")
  end
end
function s070_area7.OnGulluggStr_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_027")
  end
end
function s070_area7.OnGulluggStr_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_028")
  end
end
function s070_area7.OnGulluggStr_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_029")
  end
end
function s070_area7.OnGulluggStr_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_030")
  end
end
function s070_area7.OnGulluggStr_031_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_031")
  end
end
function s070_area7.OnGulluggStr_032_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_032")
  end
end
function s070_area7.OnGulluggStr_033_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_033")
  end
end
function s070_area7.OnGulluggStr_034_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_034")
  end
end
function s070_area7.OnGulluggStr_035_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_035")
  end
end
function s070_area7.OnGulluggStr_036_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_036")
  end
end
function s070_area7.OnGulluggStr_037_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_037")
  end
end
function s070_area7.OnGulluggStr_038_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_038")
  end
end
function s070_area7.OnGulluggStr_039_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_039")
  end
end
function s070_area7.OnGulluggStr_040_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_040")
  end
end
function s070_area7.OnGulluggStr_041_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_041")
  end
end
function s070_area7.OnGulluggStr_042_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_042")
  end
end
function s070_area7.OnGulluggStr_043_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_043")
  end
end
function s070_area7.OnGulluggStr_044_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_044")
  end
end
function s070_area7.OnGulluggStr_045_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_045")
  end
end
function s070_area7.OnGulluggStr_046_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_046")
  end
end
function s070_area7.OnGulluggStr_047_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_047")
  end
end
function s070_area7.OnGulluggStr_048_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_048")
  end
end
function s070_area7.OnGulluggStr_049_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_049")
  end
end
function s070_area7.OnGulluggStr_050_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_050")
  end
end
function s070_area7.OnGulluggStr_051_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_051")
  end
end
function s070_area7.OnGulluggStr_052_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_052")
  end
end
function s070_area7.OnGulluggStr_053_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_053")
  end
end
function s070_area7.OnGulluggStr_054_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_054")
  end
end
function s070_area7.OnGulluggStr_055_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_055")
  end
end
function s070_area7.OnGulluggStr_056_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_056")
  end
end
function s070_area7.OnGulluggStr_057_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_057")
  end
end
function s070_area7.OnGulluggStr_058_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_058")
  end
end
function s070_area7.OnGulluggStr_059_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_059")
  end
end
function s070_area7.OnGulluggStr_060_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_060")
  end
end
function s070_area7.OnGulluggStr_061_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_061")
  end
end
function s070_area7.OnGulluggStr_062_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_062")
  end
end
function s070_area7.OnGulluggStr_063_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_063")
  end
end
function s070_area7.OnGulluggStr_064_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_064")
  end
end
function s070_area7.OnGulluggStr_065_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_065")
  end
end
function s070_area7.OnGulluggStr_066_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_066")
  end
end
function s070_area7.OnGulluggStr_067_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_067")
  end
end
function s070_area7.OnGravittAdamant_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s070_area7.OnGawron_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 600, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGawron_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGawron_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGawron_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGawron_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGawron_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 350, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGawron_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, -250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s070_area7.OnGlowflyPuzzle_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_004")
    _ARG_1_.AI:AddBlackboardParam("sBurrowName_B", "LE_Glowfly_Burrow_004_B")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s070_area7.OnGlowflyPuzzle_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_005")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s070_area7.OnGlowflyPuzzle_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_006")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s070_area7.OnGlowflyPuzzle_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_007")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s070_area7.OnGlowflyPuzzle_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_008")
    _ARG_1_.AI:AddBlackboardParam("sBurrowName_B", "LE_Glowfly_Burrow_008_B")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s070_area7.OnGlowflyPuzzle_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", 1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", true)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_009")
    _ARG_1_.AI:AddBlackboardParam("sBurrowName_B", "LE_Glowfly_Burrow_009_B")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(true)
  end
end
function s070_area7.OnGlowfly_LS_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", true)
    _ARG_1_.AI:AddBlackboardParam("sMode", "ROUTE")
  end
end
function s070_area7.LaunchFirstTimeOmegaPresentation()
  Scenario.WriteToBlackboard("OmegaIntroCutscenePlayed", "b", true)
  -- Game.LaunchCutscene("cutscenes/introomega/takes/10/introomega10.bmscu")
  s070_area7.OnOmegaPresentationCutsceneStart()
  Game.SetCameraEnemy("omega")
  Game.MetroidRadarForceStateOnBegin(2, -1, true, true)
end
function s070_area7.OnOmegaPresentationCutsceneStart()
  if Game.GetEntity("SG_Omega_001") ~= nil then
    Game.GetEntity("SG_Omega_001").SPAWNGROUP:EnableSpawnGroup()
    Game.AddSF(0.5, "Game.MetroidRadarForceStateOnEnd", "")
    if Game.GetEntityFromSpawnPoint("Omega_001") ~= nil then
      Game.GetEntityFromSpawnPoint("Omega_001").AI:SetBossCamera(true)
    end
  end
end
function s070_area7.OnOmegaPresentationCutsceneEnd()
end
function s070_area7.OnGrapplePullFinished(_ARG_0_, _ARG_1_)
  if _ARG_0_ ~= nil and _ARG_0_.sName == "LE_GrappleMov_003" and _ARG_1_ and Game.GetEntity("LE_Fan_003") ~= nil then
    Game.GetEntity("LE_Fan_003").BOMBFAN:SetIsWorking(not _ARG_1_)
  end
end
function s070_area7.OnFansInit()
  if Game.GetEntity("LE_Fan_003") ~= nil then
    Game.GetEntity("LE_Fan_003").BOMBFAN:SetIsWorking(not Blackboard.GetProp("s070_area7", "entity_LE_GrappleMov_003_used"))
  end
end
function s070_area7.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == "" and _ARG_2_ == "collision_camera_043" and _ARG_3_ == "ManicMiner_Dead" and Game.GetEntity("SG_ManicMinerBot") ~= nil then
    Game.GetEntity("SG_ManicMinerBot").SPAWNGROUP:EnableSpawnGroup()
    if Game.GetEntityFromSpawnPoint("SP_ManicMinerBot") ~= nil then
      Game.GetEntityFromSpawnPoint("SP_ManicMinerBot").ANIMATION.sDefaultSpawnAction = "deathloop"
      Game.GetEntityFromSpawnPoint("SP_ManicMinerBot").ANIMATION:SetAction("deathloop", true)
      Game.GetEntityFromSpawnPoint("SP_ManicMinerBot").AI:OnDeadCutsceneEnd()
    end
  end
  if _ARG_0_ == "collision_camera_041" and _ARG_2_ == "collision_camera_038" then
    if not Scenario.ReadFromBlackboard("ManicMinerBotStealOrbPlayed", false) then
      s070_area7.LaunchManicMinerBotStealOrb()
    end
  elseif _ARG_0_ == "collision_camera_034" and _ARG_2_ == "collision_camera_043" then
    if not Scenario.ReadFromBlackboard("ManicMinerBotIntroCutscenePlayed", false) then
      Game.SetCameraEnemy("manicminerbot")
      s070_area7.LaunchManicMinerBotIntroCutscene()
    end
  elseif _ARG_2_ == "collision_camera_037" and _ARG_3_ == "Omega_Enabled" and not Scenario.ReadFromBlackboard("OmegaIntroCutscenePlayed", false) then
    s070_area7.LaunchFirstTimeOmegaPresentation()
  end
  if _ARG_2_ == "collision_camera_037" and _ARG_3_ == "Omega_Enabled" and not Scenario.ReadFromBlackboard("entity_SG_Omega_001_deaths", false) then
    Game.SetSceneGroupEnabledByName("sg_SubArea_Omega_001_Wall", true)
  else
    Game.SetSceneGroupEnabledByName("sg_SubArea_Omega_001_Wall", false)
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s070_area7.LaunchManicMinerBotStealOrb()
  Scenario.WriteToBlackboard("ManicMinerBotStealOrbPlayed", "b", true)
  -- Game.LaunchCutscene("cutscenes/manicminerbotstealorb/takes/01/manicminerbotstealorb01.bmscu")
end
function s070_area7.OnManicMinerBotStealOrbCutsceneEnd()
  Game.UpdateSpecifiedMinimapCellIcon(23, 26)
end
function s070_area7.OnPlayerDead(_ARG_0_)
  s070_area7.SetLowModelsVisibility(false)
end
function s070_area7.SetLowModelsVisibility(_ARG_0_)
  if _ARG_0_ and Game.GetEntity("Samus") ~= nil and Game.GetItemAmount(Game.GetPlayerName(), "ITEM_GRAVITY_SUIT") == 1 then
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Body_Ch", false)
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", true)
  elseif not _ARG_0_ and Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Body_Ch", true)
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", false)
  end
end
function s070_area7.LaunchManicMinerBotIntroCutscene()
  if Game.GetEntity("LE_PowerUp_Powerbomb") ~= nil then
    Game.GetEntity("LE_PowerUp_Powerbomb"):Disable()
  end
  s070_area7.SetLowModelsVisibility(true)
  Scenario.WriteToBlackboard("ManicMinerBotIntroCutscenePlayed", "b", true)
  Game.LaunchCutscene("cutscenes/manicminerbotfinalbattle/takes/01/manicminerbotfinalbattle01.bmscu")
  PBLauncher = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB")
  if PBLauncher > 0 then
    local PreFightPBMax = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB_MAX")
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB", 0)
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB_MAX", 0)
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB_CURRENT", 0)
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_POWER_BOMB_TANKS", PreFightPBMax)
  end
end
function s070_area7.OnStartManicMinerBotIntroCutscene()
  if Game.GetEntity("DoorManicMinerBot") ~= nil then
    Game.GetEntity("DoorManicMinerBot").LIFE:CloseDoor()
    Game.AddEntityToUpdateInCutscene("DoorManicMinerBot")
  end
  if Game.GetEntity("Door024") ~= nil then
    Game.GetEntity("Door024"):Disable()
  end
end
function s070_area7.OnStartLastTakeManicMinerBotIntroCutscene()
  if Game.GetEntity("SG_ManicMinerBot") ~= nil then
    Game.GetEntity("SG_ManicMinerBot").SPAWNGROUP:EnableSpawnGroup()
    if Game.GetEntityFromSpawnPoint("SP_ManicMinerBot") ~= nil then
      Game.GetEntityFromSpawnPoint("SP_ManicMinerBot").AI:SetBossCamera(true)
    end
  end
end
function s070_area7.OnEndManicMinerBotIntroCutscene()
  if Game.GetEntity("DoorManicMinerBot") ~= nil then
    Game.RemoveEntityToUpdateInCutscene("DoorManicMinerBot")
  end
end
function s070_area7.UpdateMinimapItemsphereIcon()
  Scenario.WriteToBlackboard("BattleFinished", "b", true)
  Game.UpdateSpecifiedMinimapCellIcon(6, 8)
end
function s070_area7.OnStartManicMinerBotDeathCutscene()
  Game.GetPlayer("Samus").vPos = Game.GetEntity("DoorManicMinerBot").vPos
  if Game.GetEntity("LE_PowerUp_Powerbomb") ~= nil then
    Game.GetEntity("LE_PowerUp_Powerbomb"):Enable()
  end
  if Game.GetEntity("Door024") ~= nil then
    Game.GetEntity("Door024"):Enable()
  end
  Game.AddEntityToUpdateInCutscene("LE_ManicMinerWall")
  Game.AddEntityToUpdateInCutscene("LE_PowerUp_Powerbomb")
  Scenario.WriteToBlackboard("manicMinerDead", "b", true)
  if PBLauncher ~= 0 and Game.GetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB") == 0 then
    local locked_pbs = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_POWER_BOMB_TANKS")
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB", 1)
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB_MAX", locked_pbs)
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_POWER_BOMB_CURRENT", locked_pbs)
    Game.SetItemAmount(Game.GetPlayerName(), "ITEM_POWER_BOMB_TANKS", 0)
  end
end
function s070_area7.OnEndManicMinerBotDeathCutscene()
  s070_area7.UpdateMinimapItemsphereIcon()
  Game.RemoveEntityToUpdateInCutscene("LE_ManicMinerWall")
  Game.RemoveEntityToUpdateInCutscene("LE_PowerUp_Powerbomb")
  if Game.GetEntity("pool#manicminerbot@manicminerbot0") ~= nil then
    Game.GetEntity("pool#manicminerbot@manicminerbot0").AI:OnDeadCutsceneEnd()
  end
  s070_area7.SetLowModelsVisibility(false)
end
function s070_area7.OnEnter_SetCheckpoint_001_ManicMiner()
  Game.SetBossCheckPointNames("ST_SG_ManicMiner_Checkpoint", "ST_SG_ManicMiner_Checkpoint", "SG_ManicMinerBot", "", "")
end
function s070_area7.OnManicMinerBotGenerated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_ManicMinerBot")
  end
end
function s070_area7.OnEnter_ManicMiner_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_ManicMinerBot_deaths", false) > 0 then
    Game.SetSubAreaCurrentSetup("collision_camera_043", "PostManicMiner_001", true)
    if Game.GetEntity("SpawnGroup059") ~= nil then
      Game.GetEntity("SpawnGroup059").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s070_area7.OnManicMinerBotStartPoint()
  Game.HUDIdleScreenLeave()
end
function s070_area7.LaunchSpecialEvent0701()
  if Game.GetEntity("LE_Event_0701") ~= nil then
    Game.GetEntity("LE_Event_0701").ANIMATION:SetAction("event")
  end
end
function s070_area7.OnEnter_ChangeCamera_034()
  Game.SetCollisionCameraLocked("collision_camera_034_B", true)
end
function s070_area7.OnExit_ChangeCamera_034()
  Game.SetCollisionCameraLocked("collision_camera_034_B", false)
end
function s070_area7.OnEnter_ChangeCamera_060()
  Game.SetCollisionCameraLocked("collision_camera_060", true)
end
function s070_area7.OnExit_ChangeCamera_060()
  Game.SetCollisionCameraLocked("collision_camera_060", false)
end
function s070_area7.OnEnter_ChangeCamera_051()
  Game.SetCollisionCameraLocked("collision_camera_051_B", true)
end
function s070_area7.OnExit_ChangeCamera_051()
  Game.SetCollisionCameraLocked("collision_camera_051_B", false)
end
function s070_area7.OnEnter_ChangeCamera_Hazard_A()
  Game.SetCollisionCameraLocked("collision_camera_Hazard_End_A_v2", true)
end
function s070_area7.OnExit_ChangeCamera_Hazard_A()
  Game.SetCollisionCameraLocked("collision_camera_Hazard_End_A_v2", false)
end
