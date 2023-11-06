Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s090_area9.main()
  Scenario.InitGUI()
end
function s090_area9.SetupDebugGameBlackboard()
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_SPECIAL_ENERGY", "f", 1000)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MAX_SPECIAL_ENERGY", "f", 1000)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_CURRENT_LIFE", "f", 399)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MAX_LIFE", "f", 399)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_MAX", "f", 100)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_MISSILE_CURRENT", "f", 100)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_MAX", "f", 25)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SUPER_MISSILE_CURRENT", "f", 25)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_POWER_BOMB_MAX", "f", 5)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_POWER_BOMB_CURRENT", "f", 5)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MORPH_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_CHARGE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_BOMB", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_ICE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPIDER_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_WAVE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_GRAPPLE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SPAZER_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_PLASMA_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_GRAPPLE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_POWER_BOMB", "f", 1)
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
function s090_area9.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
s090_area9.tDNAScanLandmarks = {
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
  },
  SG_Omega_002 = {
    "LM_ADNScanner_Samus_Omega_002_001",
    "LM_ADNScanner_Samus_Omega_002_002",
    "LM_ADNScanner_Samus_Omega_002_003",
    "LM_ADNScanner_Samus_Omega_002_004",
    "LM_ADNScanner_Samus_Omega_002_005",
    "LM_ADNScanner_Samus_Omega_002_006",
    "LM_ADNScanner_Samus_Omega_002_007",
    "LM_ADNScanner_Samus_Omega_002_008",
    "LM_ADNScanner_Samus_Omega_002_009",
    "LM_ADNScanner_Samus_Omega_002_010",
    "LM_ADNScanner_Samus_Omega_002_011",
    "LM_ADNScanner_Samus_Omega_002_012",
    "LM_ADNScanner_Samus_Omega_002_013"
  },
  SG_Omega_003 = {
    "LM_ADNScanner_Samus_Omega_003_001",
    "LM_ADNScanner_Samus_Omega_003_002",
    "LM_ADNScanner_Samus_Omega_003_003",
    "LM_ADNScanner_Samus_Omega_003_004",
    "LM_ADNScanner_Samus_Omega_003_005",
    "LM_ADNScanner_Samus_Omega_003_006",
    "LM_ADNScanner_Samus_Omega_003_007",
    "LM_ADNScanner_Samus_Omega_003_008",
    "LM_ADNScanner_Samus_Omega_003_009",
    "LM_ADNScanner_Samus_Omega_003_010",
    "LM_ADNScanner_Samus_Omega_003_011",
    "LM_ADNScanner_Samus_Omega_003_012",
    "LM_ADNScanner_Samus_Omega_003_013"
  }
}
function s090_area9.OnLE_Platform_Elevator_FromArea07(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s070_area7", "ST_FromArea09", _ARG_2_)
end
function s090_area9.OnLE_Platform_Elevator_FromArea10(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s100_area10", "ST_FromArea09", _ARG_2_)
end
function s090_area9.PreLE_Platform_Elevator_FromArea07()
  GUI.ElevatorSetTarget("s090_area9_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s090_area9.PreLE_Platform_Elevator_FromArea10()
  GUI.ElevatorSetTarget("s100_area10_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s090_area9.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea07" then
    GUI.ElevatorSetTarget("s090_area9_elevator", false)
  elseif _ARG_0_ == "ST_FromArea10" then
    GUI.ElevatorSetTarget("s100_area10_elevator", true)
  end
end
function s090_area9.InitFromBlackboard()
  s090_area9.bAfterOmegasKilledMusicChange = false
  s090_area9.AllOmegasDeadCallback()
  s090_area9.OnFansInit()
end
function s090_area9.OnReloaded()
end
function s090_area9.OnExit()
end
function s090_area9.OnEnter_ActivationDNA()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA", 3)
end
function s090_area9.OnEnter_ActivationTeleport_09_01()
  Game.OnTeleportApproached("LE_Teleporter_09_01")
end
function s090_area9.OnEnter_ActivationTeleport_09_02()
  Game.OnTeleportApproached("LE_Teleporter_09_02")
end
function s090_area9.OnHazarousPoolDrain()
  Game.SetSubAreaCurrentSetup("collision_camera_011", "Hazarous_Empty", true)
end
function s090_area9.OnEnterHazardous()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_011", "Enter_Hazardous", false)
end
function s090_area9.OnExitHazardous()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_011", "Default", false)
end
function s090_area9.OnEnter_SetCheckpoint_001_Omega_001()
  Game.SetBossCheckPointNames("ST_SG_Omega_001", "ST_SG_Omega_001", "SG_Omega_001", "", "")
end
function s090_area9.OnOmega_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Omega_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door016")
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
    _ARG_1_.AI.iNumStalactites = 39
  end
end
function s090_area9.OnEnter_Omega_001_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Omega_001_deaths", false) then
    Game.SetSubAreaEnvironmentLocked(false, false, false)
    if s090_area9.AreAllOmegasDead() then
      s090_area9.AllOmegasDeadCallback()
    end
    Game.SetSubAreaCurrentSetup("collision_camera_014", "PostOmega_001", true)
    if Game.GetEntity("SpawnGroup018") ~= nil then
      Game.GetEntity("SpawnGroup018").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.SetSceneGroupEnabledByName("sg_SubArea_Omega_001_Wall", false)
  end
end
function s090_area9.OnOmega_002_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Omega_002") ~= nil and Game.GetEntity("Omega_002").SPAWNPOINT ~= nil then
    Game.GetEntity("Omega_002").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Omega_002_Intro") ~= nil and Game.GetEntity("Omega_002_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Omega_002_Intro").SPAWNPOINT:Deactivate()
  end
  s090_area9.OnOmega_002_Generated(_ARG_0_, _ARG_1_)
end
function s090_area9.Spawn_Omega_002_Intro()
  Game.DisableTrigger("TG_Omega_002_Intro")
  if Game.GetEntity("SG_Omega_002") ~= nil then
    Game.GetEntity("SG_Omega_002").SPAWNGROUP:EnableSpawnGroup()
  end
  if Game.GetEntityFromSpawnPoint("Omega_002_Intro") ~= nil then
    Game.GetEntityFromSpawnPoint("Omega_002_Intro").ANIMATION:SetAction("spawn92", true)
  end
end
function s090_area9.OnEnter_SetCheckpoint_001_Omega_002()
  Game.SetBossCheckPointNames("ST_SG_Omega_002", "ST_SG_Omega_002", "SG_Omega_002", "", "")
end
function s090_area9.OnOmega_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Omega_002")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door006")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Omega")
    _ARG_1_.AI:AddLandmark("LM_CrushingJumpLeft", "LM_CrushingJumpLeft_002")
    _ARG_1_.AI:AddLandmark("LM_CrushingJumpRight", "LM_CrushingJumpRight_002")
    _ARG_1_.AI:AddLandmark("LM_SlapLeft", "LM_SlapLeft_002")
    _ARG_1_.AI:AddLandmark("LM_SlapRight", "LM_SlapRight_002")
    _ARG_1_.AI:AddLandmark("LM_PlasmaArcLeft", "LM_PlasmaArcLeft_002")
    _ARG_1_.AI:AddLandmark("LM_PlasmaArcRight", "LM_PlasmaArcRight_002")
    _ARG_1_.AI:AddLandmark("LM_ArenaLeft", "LM_ArenaLeft_002")
    _ARG_1_.AI:AddLandmark("LM_ArenaRight", "LM_ArenaRight_002")
    _ARG_1_.AI.iNumStalactites = 39
  end
end
function s090_area9.OnEnter_Omega_002_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Omega_002_deaths", false) then
    Game.SetSubAreaEnvironmentLocked(false, false, false)
    if s090_area9.AreAllOmegasDead() then
      s090_area9.AllOmegasDeadCallback()
      Game.SetSubAreaCurrentSetup("collision_camera_009", "PostOmegas", true)
    else
      Game.SetSubAreaCurrentSetup("collision_camera_009", "PostOmega_002", true)
    end
    if Game.GetEntity("SpawnGroup019") ~= nil then
      Game.GetEntity("SpawnGroup019").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s090_area9.AreAllOmegasDead()
  return Scenario.ReadFromBlackboard("entity_SG_Omega_001_deaths", false) and Scenario.ReadFromBlackboard("entity_SG_Omega_002_deaths", false) and Scenario.ReadFromBlackboard("entity_SG_Omega_003_deaths", false)
end
function s090_area9.AllOmegasDeadCallback()
  if s090_area9.AreAllOmegasDead() then
    if s090_area9.bAfterOmegasKilledMusicChange then
      s090_area9.bAfterOmegasKilledMusicChange = false
    end
    Game.SetSubAreaCurrentSetup("collision_camera_008", "PostOmegas", true)
    Game.SetSubAreaCurrentSetup("collision_camera_016", "PostOmegas", true, true)
    Game.SetSubAreaCurrentSetup("collision_camera_012", "PostOmegas", true)
    return true
  end
  return false
end
function s090_area9.OnEnter_SetCheckpoint_001_Omega_003()
  Game.SetBossCheckPointNames("ST_SG_Omega_003", "ST_SG_Omega_003_Out", "SG_Omega_003", "", "")
end
function s090_area9.OnOmega_003_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Omega_003")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door015")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Omega")
    _ARG_1_.AI:AddLandmark("LM_CrushingJumpLeft", "LM_CrushingJumpLeft_003")
    _ARG_1_.AI:AddLandmark("LM_CrushingJumpRight", "LM_CrushingJumpRight_003")
    _ARG_1_.AI:AddLandmark("LM_SlapLeft", "LM_SlapLeft_003")
    _ARG_1_.AI:AddLandmark("LM_SlapRight", "LM_SlapRight_003")
    _ARG_1_.AI:AddLandmark("LM_PlasmaArcLeft", "LM_PlasmaArcLeft_003")
    _ARG_1_.AI:AddLandmark("LM_PlasmaArcRight", "LM_PlasmaArcRight_003")
    _ARG_1_.AI:AddLandmark("LM_ArenaLeft", "LM_ArenaLeft_003")
    _ARG_1_.AI:AddLandmark("LM_ArenaRight", "LM_ArenaRight_003")
    _ARG_1_.AI.iNumStalactites = 37
  end
end
function s090_area9.OnEnter_Omega_003_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Omega_003_deaths", false) then
    Game.SetSubAreaEnvironmentLocked(false, false, false)
    if s090_area9.AreAllOmegasDead() then
      s090_area9.AllOmegasDeadCallback()
      Game.SetSubAreaCurrentSetup("collision_camera_013", "PostOmegas", true)
    else
      Game.SetSubAreaCurrentSetup("collision_camera_012", "PostOmega_003", true)
      Game.SetSubAreaCurrentSetup("collision_camera_013", "PostOmega_003", true)
    end
    if Game.GetEntity("SpawnGroup020") ~= nil then
      Game.GetEntity("SpawnGroup020").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s090_area9.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s090_area9.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s090_area9.OnDrivelStr_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_001")
  end
end
function s090_area9.OnDrivelStr_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_002")
  end
end
function s090_area9.OnDrivelStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_003")
  end
end
function s090_area9.OnDrivelStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_004")
  end
end
function s090_area9.OnDrivelStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_005")
  end
end
function s090_area9.OnDrivelStr_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_006")
  end
end
function s090_area9.OnDrivelStr_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_007")
  end
end
function s090_area9.OnDrivelStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_008")
  end
end
function s090_area9.OnDrivelStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_009")
  end
end
function s090_area9.OnDrivelStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_010")
  end
end
function s090_area9.OnDrivelStr_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_011")
  end
end
function s090_area9.OnDrivelStr_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_012")
  end
end
function s090_area9.OnDrivelStr_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_013")
  end
end
function s090_area9.OnGulluggStr_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s090_area9.OnGulluggStr_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s090_area9.OnGulluggStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s090_area9.OnGulluggStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s090_area9.OnGulluggStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s090_area9.OnGulluggStr_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s090_area9.OnGulluggStr_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s090_area9.OnGulluggStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s090_area9.OnGulluggStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s090_area9.OnGunzoo_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_007")
  end
end
function s090_area9.OnGunzoo_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_008")
  end
end
function s090_area9.OnGunzoo_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_009")
  end
end
function s090_area9.OnGunzoo_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_012")
  end
end
function s090_area9.OnGunzoo_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_013")
  end
end
function s090_area9.OnGunzoo_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_015")
  end
end
function s090_area9.OnGunzoo_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_016")
  end
end
function s090_area9.OnGunzoo_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_018")
  end
end
function s090_area9.OnGunzoo_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_020")
  end
end
function s090_area9.OnGunzoo_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_021")
  end
end
function s090_area9.OnGunzoo_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_025")
  end
end
function s090_area9.OnGunzoo_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_027")
  end
end
function s090_area9.OnGunzoo_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_028")
  end
end
function s090_area9.OnGunzoo_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_029")
  end
end
function s090_area9.OnGunzoo_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_030")
  end
end
function s090_area9.OnGunzoo_031_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_031")
  end
end
function s090_area9.OnGunzoo_032_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_032")
  end
end
function s090_area9.OnGrapplePullFinished(_ARG_0_, _ARG_1_)
  if _ARG_0_ ~= nil and _ARG_0_.sName == "LE_GrappleMov_002" and _ARG_1_ and Game.GetEntity("LE_Fan_001") ~= nil then
    Game.GetEntity("LE_Fan_001").BOMBFAN:SetIsWorking(not _ARG_1_)
  end
end
function s090_area9.OnFansInit()
  if Game.GetEntity("LE_Fan_001") ~= nil then
    Game.GetEntity("LE_Fan_001").BOMBFAN:SetIsWorking(not Blackboard.GetProp("s090_area9", "entity_LE_GrappleMov_002_used"))
  end
end
s090_area9.bAfterOmegasKilledMusicChange = false
function s090_area9.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_2_ ~= _ARG_0_ then
    Game.SetInGameMusicState("RELAX", false)
  end
  if s090_area9.AreAllOmegasDead() and (_ARG_2_ == "collision_camera_009" or _ARG_2_ == "collision_camera_016" or _ARG_2_ == "collision_camera_013" or _ARG_2_ == "collision_camera_012") and _ARG_3_ ~= "PostOmegas" then
    Game.PlayMusicStream(0, "streams/music/m_allarea_b99.wav", -1, -1, -1, 2, 2, 1)
    s090_area9.bAfterOmegasKilledMusicChange = true
  end
  if _ARG_2_ == "collision_camera_014" and not Scenario.ReadFromBlackboard("entity_SG_Omega_001_deaths", false) then
    Game.SetSceneGroupEnabledByName("sg_SubArea_Omega_001_Wall", true)
  else
    Game.SetSceneGroupEnabledByName("sg_SubArea_Omega_001_Wall", false)
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s090_area9.OnEnter_Activate_ChangeCamera_005_001()
  Game.EnableTrigger("TG_Deactivate_ChangeCamera_005_001")
end
function s090_area9.OnEnter_Deactivate_ChangeCamera_005_001()
  Game.DisableTrigger("TG_ChangeCamera_005_001")
end
function s090_area9.OnExit_Deactivate_ChangeCamera_005_001()
  Game.EnableTrigger("TG_ChangeCamera_005_001")
  Game.DisableTrigger("TG_Deactivate_ChangeCamera_005_001")
end
function s090_area9.OnEnter_ChangeCamera_005()
  Game.SetCollisionCameraLocked("collision_camera_005_B", true)
end
function s090_area9.OnExit_ChangeCamera_005()
  Game.SetCollisionCameraLocked("collision_camera_005_B", false)
  Game.EnableTrigger("TG_ChangeCamera_005_001")
  Game.DisableTrigger("TG_Deactivate_ChangeCamera_005_001")
end
function s090_area9.OnEnter_ChangeCamera_006()
  Game.SetSubAreaCurrentSetup("collision_camera_006", "ChangeCamera_006", false)
end
function s090_area9.OnExit_ChangeCamera_006()
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Default", false)
end
function s090_area9.OnEnter_ChangeCamera_022()
  Game.SetCollisionCameraLocked("collision_camera_022_B", true)
end
function s090_area9.OnExit_ChangeCamera_022()
  Game.SetCollisionCameraLocked("collision_camera_022_B", false)
end
function s090_area9.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s090_area9.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s090_area9.LaunchSpecialEvent09_01()
  if Game.GetEntity("LE_Event_09_01") ~= nil then
    Game.GetEntity("LE_Event_09_01").ANIMATION:SetAction("event")
  end
  Game.DisableTrigger("TG_Event_09_01")
end
