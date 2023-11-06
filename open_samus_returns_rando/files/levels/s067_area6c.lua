Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s067_area6c.main()
  Scenario.InitGUI()
end
function s067_area6c.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s067_area6c.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_PLASMA_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_GRAPPLE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPACE_JUMP", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_VARIA_SUIT", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 1)
end
function s067_area6c.InitFromBlackboard()
end
function s067_area6c.OnReloaded()
end
function s067_area6c.OnExit()
end
function s067_area6c.OnEnter_ActivationTeleport_06C_001()
  Game.OnTeleportApproached("LE_Teleporter_06C_001")
end
s067_area6c.tDNAScanLandmarks = {
  SG_Zeta_002 = {
    "LM_ADNScanner_Samus_Zeta_002_001",
    "LM_ADNScanner_Samus_Zeta_002_002",
    "LM_ADNScanner_Samus_Zeta_002_003",
    "LM_ADNScanner_Samus_Zeta_002_004",
    "LM_ADNScanner_Samus_Zeta_002_005",
    "LM_ADNScanner_Samus_Zeta_002_006",
    "LM_ADNScanner_Samus_Zeta_002_007",
    "LM_ADNScanner_Samus_Zeta_002_008",
    "LM_ADNScanner_Samus_Zeta_002_009"
  },
  SG_Gamma_001 = {
    "LM_ADNScanner_Samus_Gamma_001_001",
    "LM_ADNScanner_Samus_Gamma_001_002",
    "LM_ADNScanner_Samus_Gamma_001_003",
    "LM_ADNScanner_Samus_Gamma_001_004",
    "LM_ADNScanner_Samus_Gamma_001_005",
    "LM_ADNScanner_Samus_Gamma_001_006"
  }
}
function s067_area6c.OnLE_Platform_Elevator_FromArea06B_01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s065_area6b", "ST_FromArea06C_01", _ARG_2_)
end
function s067_area6c.OnLE_Platform_Elevator_FromArea06B_02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s065_area6b", "ST_FromArea06C_02", _ARG_2_)
end
function s067_area6c.OnLE_Platform_Elevator_FromArea06A_01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s060_area6", "ST_FromArea06C_01", _ARG_2_)
end
function s067_area6c.OnLE_Platform_Elevator_FromArea06A_02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s060_area6", "ST_FromArea06C_02", _ARG_2_)
end
function s067_area6c.PreLE_Platform_Elevator_FromArea06B_01()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s067_area6c.PreLE_Platform_Elevator_FromArea06B_02()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s067_area6c.PreLE_Platform_Elevator_FromArea06A_01()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s067_area6c.PreLE_Platform_Elevator_FromArea06A_02()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s067_area6c.OnStartGravitySuitCutscene()
  Game.ForceConvertToSamus()
  if Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus"):SetVisible(false)
  end
  Game.OnSuitCutsceneLaunched()
end
function s067_area6c.OnEndGravitySuitCutscene()
  if Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus"):SetVisible(true)
  end
  Game.TeleportEntityToLandmark("Samus", "LM_GravitySuit_Cutscene", true, 0, true, 0, 0, 0)
  Game.GetPlayer().ANIMATION:SetAction("relax", true)
  Game.SetGameModeStartButtonForbidden("INGAME", false)
  Game.GetPlayer().MODELUPDATER.sModelAlias = "Gravity"
  SpecialEnergyCloud.ActivateSpecialEnergy("TG_SpecialEnergyCloud_GravitySuite")
  Game.FadeIn(0.3)
  Game.SetPlayerInputEnabled(false, false)
  Game.AddSF(0.3, "s067_area6c.GravitySuitPicked", "")
  Game.SetPlayerInputEnabled(false, false)
  Game.HUDIdleScreenLeave()
  Game.HUDAvailabilityGoOff(false, false, false, false)
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(true)
end
function s067_area6c.GravitySuitPicked()
  guicallbacks.OnPickableItemPickedUp("#GUI_ITEM_ACQUIRED_GRAVITY_SUIT", false)
  Game.SetPlayerInputEnabled(true, false)
end
function s067_area6c.OnGamma_001_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Gamma_001") ~= nil and Game.GetEntity("Gamma_001").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_001").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Gamma_001_Intro") ~= nil and Game.GetEntity("Gamma_001_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_001_Intro").SPAWNPOINT:Deactivate()
  end
  s067_area6c.OnGamma_001_Generated(_ARG_0_, _ARG_1_)
end
function s067_area6c.Spawn_Gamma_001_Intro()
  Game.DisableTrigger("TG_Gamma_001_Intro")
  if Game.GetEntity("SG_Gamma_001") ~= nil then
    Game.GetEntity("SG_Gamma_001").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s067_area6c.OnEnter_SetCheckpoint_001_Gamma_001()
  Game.SetBossCheckPointNames("ST_SG_Gamma_001", "ST_SG_Gamma_001_Out", "SG_Gamma_001", "", "")
end
function s067_area6c.OnGamma_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_001")
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Gamma_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma001_Idle")
  end
end
function s067_area6c.OnEnter_Gamma_001_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Gamma_001_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_022", "PostGamma_001", true)
    if Game.GetEntity("SpawnGroup013") ~= nil then
      Game.GetEntity("SpawnGroup013").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup024") ~= nil then
      Game.GetEntity("SpawnGroup024").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup025") ~= nil then
      Game.GetEntity("SpawnGroup025").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s067_area6c.OnZeta_002_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Zeta_002") ~= nil and Game.GetEntity("Zeta_002").SPAWNPOINT ~= nil then
    Game.GetEntity("Zeta_002").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Zeta_002_Intro") ~= nil and Game.GetEntity("Zeta_002_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Zeta_002_Intro").SPAWNPOINT:Deactivate()
  end
  s067_area6c.OnZeta_002_Generated(_ARG_0_, _ARG_1_)
end
function s067_area6c.Spawn_Zeta_002_Intro()
  Game.DisableTrigger("TG_Zeta_002_Intro")
  if Game.GetEntity("SG_Zeta_002") ~= nil then
    Game.GetEntity("SG_Zeta_002").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s067_area6c.OnEnter_SetCheckpoint_001_Zeta_002()
  Game.SetBossCheckPointNames("ST_SG_Zeta_002", "ST_SG_Zeta_002_Out", "SG_Zeta_002", "", "")
end
function s067_area6c.OnZeta_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Zeta_002")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door022")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI.sNavigableAreaID = "SHAPE_Zeta002"
    _ARG_1_.AI:AddBossCamera("CAM_Zeta")
  end
end
function s067_area6c.OnEnter_Zeta_002_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Zeta_002_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_025", "PostZeta_002", true)
    if Game.GetEntity("SpawnGroup014") ~= nil then
      Game.GetEntity("SpawnGroup014").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s067_area6c.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s067_area6c.OnGlowfly_LS_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", true)
    _ARG_1_.AI:AddBlackboardParam("sMode", "ROUTE")
  end
end
function s067_area6c.OnGunzoo_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_001")
  end
end
function s067_area6c.OnGunzoo_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_002")
  end
end
function s067_area6c.OnGunzoo_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_003")
  end
end
function s067_area6c.OnGunzoo_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_004")
  end
end
function s067_area6c.OnGunzoo_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_005")
  end
end
function s067_area6c.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s067_area6c.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s067_area6c.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s067_area6c.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s067_area6c.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s067_area6c.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s067_area6c.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s067_area6c.OnGullugg_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s067_area6c.OnGullugg_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s067_area6c.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s067_area6c.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s067_area6c.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s067_area6c.OnMeboid_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_001")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s067_area6c.OnMeboid_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_002")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s067_area6c.OnMeboid_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_003")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s067_area6c.OnMeboid_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_004")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s067_area6c.OnMeboid_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_005")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s067_area6c.OnMeboid_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_006")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s067_area6c.OnGawron_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(-250, 0, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s067_area6c.OnGawron_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 250, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s067_area6c.OnGawron_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s067_area6c.OnGawron_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("vOutOffset", V3D(0, 550, 0))
    _ARG_1_.AI:AddBlackboardParam("fSpeedMultiplier", 2)
  end
end
function s067_area6c.OnParabite_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_001", "ParabitePath_001_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_002", "ParabitePath_001_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s067_area6c.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s067_area6c.OnBeeSwarm_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_002_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_002_002")
  end
end
function s067_area6c.OnEnter_ChangeCamera_002()
  Game.SetCollisionCameraLocked("collision_camera_002_B", true)
end
function s067_area6c.OnExit_ChangeCamera_002()
  Game.SetCollisionCameraLocked("collision_camera_002_B", false)
end
function s067_area6c.OnEnter_ChangeCamera_018_Default()
  Game.SetSubAreaCurrentSetup("collision_camera_018", "Default", false)
end
function s067_area6c.OnEnter_ChangeCamera_018_Alternative()
  Game.SetSubAreaCurrentSetup("collision_camera_018", "ChangeCamera", false)
end
function s067_area6c.OnEnter_MinimapSecretUncover_001()
  Game.MinimapUncoverSpecifiedCellSecretRight(31, 34)
end
function s067_area6c.LaunchSpecialEvent06c()
  if Game.GetEntity("LE_Event_06c01") ~= nil then
    Game.GetEntity("LE_Event_06c01").ANIMATION:SetAction("event")
  end
  Game.DisableTrigger("TG_Event_06c01")
end
function s067_area6c.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end