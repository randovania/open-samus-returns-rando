Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
Game.ImportLibrary("actors/props/spenergycloud/scripts/spenergycloud.lua", false)
function s028_area2c.main()
  Scenario.InitGUI()
end
function s028_area2c.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s028_area2c.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_WAVE_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SPAZER_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_PLASMA_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPACE_JUMP", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_VARIA_SUIT", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
end
function s028_area2c.OnEnter_ActivationDNA()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA", 8)
end
function s028_area2c.OnEnter_ActivationTeleport_02_01()
  Game.OnTeleportApproached("LE_Teleporter_02_01")
end
s028_area2c.tDNAScanLandmarks = {
  SG_Alpha_002 = {
    "LM_ADNScanner_Samus_Alpha_002_001",
    "LM_ADNScanner_Samus_Alpha_002_002",
    "LM_ADNScanner_Samus_Alpha_002_004",
    "LM_ADNScanner_Samus_Alpha_002_005",
    "LM_ADNScanner_Samus_Alpha_002_006",
    "LM_ADNScanner_Samus_Alpha_002_007",
    "LM_ADNScanner_Samus_Alpha_002_008",
    "LM_ADNScanner_Samus_Alpha_002_009",
    "LM_ADNScanner_Samus_Alpha_002_010",
    "LM_ADNScanner_Samus_Alpha_002_011"
  }
}
function s028_area2c.OnLE_Platform_Elevator_FromArea01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s010_area1", "ST_FromArea02", _ARG_2_)
end
function s028_area2c.OnLE_Platform_Elevator_FromArea03(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s030_area3", "ST_FromArea02", _ARG_2_)
end
function s028_area2c.PreLE_Platform_Elevator_FromArea01()
  GUI.ElevatorSetTarget("s020_area2_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s028_area2c.PreLE_Platform_Elevator_FromArea03()
  GUI.ElevatorSetTarget("s030_area3_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s028_area2c.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea01" then
    GUI.ElevatorSetTarget("s020_area2_elevator", true)
  elseif _ARG_0_ == "ST_FromArea03" then
    GUI.ElevatorSetTarget("s030_area3_elevator", false)
  end
end
function s028_area2c.InitFromBlackboard()
end
function s028_area2c.OnReloaded()
end
function s028_area2c.OnExit()
end
function s028_area2c.OnLE_Platform_Elevator_FromArea02A(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s020_area2", "ST_FromArea02C", _ARG_2_)
end
function s028_area2c.PreLE_Platform_Elevator_FromArea02A()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s028_area2c.LaunchSpecialEnergyCutscene()
  Game.LaunchCutscene("cutscenes/energyshield/takes/01/energyshield01.bmscu")
end
function s028_area2c.OnStartSpecialEnergyCutscene()
end
function s028_area2c.OnEndSpecialEnergyCutscene()
  guicallbacks.OnPickableItemPickedUp("#GUI_ITEM_ACQUIRED_LIGHTNING_ARMOR", true)
end
function s028_area2c.OnHazarousPoolDrain(_ARG_0_)
  Game.SetSubAreaCurrentSetup("collision_camera", "Hazarous_empty", true)
end
function s028_area2c.OnEnterHazardous()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera", "Enter_Hazardous", false)
end
function s028_area2c.OnExitHazardous()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera", "Default", false)
end
function s028_area2c.OnAlpha_002_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_002") ~= nil and Game.GetEntity("Alpha_002").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_002").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_002_Intro") ~= nil and Game.GetEntity("Alpha_002_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_002_Intro").SPAWNPOINT:Deactivate()
  end
  s028_area2c.OnAlpha_002_Generated(_ARG_0_, _ARG_1_)
end
function s028_area2c.Spawn_Alpha_002_Intro()
  Game.DisableTrigger("TG_Alpha_002_Intro")
  if Game.GetEntity("SG_Alpha_002") ~= nil then
    Game.GetEntity("SG_Alpha_002").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s028_area2c.OnEnter_SetCheckpoint_001_Alpha_002()
  Game.SetBossCheckPointNames("ST_SG_Alpha_002", "ST_SG_Alpha_002_Out", "SG_Alpha_002", "", "")
end
function s028_area2c.OnEnter_SetCheckpoint_002_Alpha_002()
  Game.SetBossCheckPointNames("ST_SG_Alpha_002B", "ST_SG_Alpha_002B_Out", "SG_Alpha_002", "", "")
end
function s028_area2c.OnAlpha_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_002")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door008")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha002_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha002_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha002_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha002_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha002_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha002_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha002_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha002_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha002_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha002_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha002_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha002_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha002_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha002_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha002_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha002_Idle")
  end
end
function s028_area2c.OnEnter_Alpha_002_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_002_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_007", "PostAlpha_002", true)
    if Game.GetEntity("SpawnGroup022") ~= nil then
      Game.GetEntity("SpawnGroup022").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.DisableTrigger("TG_SetCheckpoint_001_Alpha_002")
    Game.DisableTrigger("TG_SetCheckpoint_002_Alpha_002")
  end
end
function s028_area2c.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s028_area2c.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s028_area2c.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s028_area2c.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s028_area2c.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s028_area2c.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s028_area2c.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s028_area2c.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s028_area2c.OnGullugg_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s028_area2c.OnGullugg_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s028_area2c.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s028_area2c.OnGullugg_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s028_area2c.OnGullugg_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_014")
  end
end
function s028_area2c.OnGullugg_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s028_area2c.OnGullugg_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_016")
  end
end
function s028_area2c.OnGullugg_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_017")
  end
end
function s028_area2c.OnGullugg_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_018")
  end
end
function s028_area2c.OnParabite_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_Attack_001", "ParabitePath_001_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_Attack_002", "ParabitePath_001_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s028_area2c.OnParabite_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_002")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_002_Attack_001", "ParabitePath_002_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_002_Attack_002", "ParabitePath_002_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s028_area2c.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ ~= "collision_camera" or _ARG_2_ ~= "collision_camera_003" or not Scenario.ReadFromBlackboard("CamAreaPresentation", false) then
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s028_area2c.LaunchAreaPresentation()
  Scenario.WriteToBlackboard("CamAreaPresentation", "b", true)
  Game.LaunchCutscene("cutscenes/area2cam/takes/01/area2cam01.bmscu")
  if Game.GetEntity("TG_Area2Cam") ~= nil then
    Game.GetEntity("TG_Area2Cam"):Disable()
  end
end
function s028_area2c.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s028_area2c.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s028_area2c.OnEnter_ChangeCamera_003()
  Game.SetCollisionCameraLocked("collision_camera_003_B", true)
end
function s028_area2c.OnExit_ChangeCamera_003()
  Game.SetCollisionCameraLocked("collision_camera_003_B", false)
end
