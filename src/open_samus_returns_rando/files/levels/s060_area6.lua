Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
Game.ImportLibrary("actors/props/spenergycloud/scripts/spenergycloud.lua", false)
function s060_area6.main()
  Scenario.InitGUI()
end
s060_area6.tDNAScanLandmarks = {
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
    "LM_ADNScanner_Samus_Alpha_001_010"
  },
  SG_Gamma_004 = {
    "LM_ADNScanner_Samus_Gamma_004_001",
    "LM_ADNScanner_Samus_Gamma_004_002",
    "LM_ADNScanner_Samus_Gamma_004_003",
    "LM_ADNScanner_Samus_Gamma_004_004",
    "LM_ADNScanner_Samus_Gamma_004_005",
    "LM_ADNScanner_Samus_Gamma_004_006",
    "LM_ADNScanner_Samus_Gamma_004_007",
    "LM_ADNScanner_Samus_Gamma_004_008",
    "LM_ADNScanner_Samus_Gamma_004_009",
    "LM_ADNScanner_Samus_Gamma_004_010",
    "LM_ADNScanner_Samus_Gamma_004_011",
    "LM_ADNScanner_Samus_Gamma_004_012",
    "LM_ADNScanner_Samus_Gamma_004_013",
    "LM_ADNScanner_Samus_Gamma_004_014",
    "LM_ADNScanner_Samus_Gamma_004_015"
  }
}
function s060_area6.OnLE_Platform_Elevator_FromArea04(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s040_area4", "ST_FromArea06", _ARG_2_)
end
function s060_area6.OnLE_Platform_Elevator_FromArea07(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s070_area7", "ST_FromArea06", _ARG_2_)
end
function s060_area6.PreLE_Platform_Elevator_FromArea04()
  GUI.ElevatorSetTarget("s060_area6_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s060_area6.PreLE_Platform_Elevator_FromArea07()
  GUI.ElevatorSetTarget("s070_area7_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s060_area6.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea04" then
    GUI.ElevatorSetTarget("s060_area6_elevator", true)
  elseif _ARG_0_ == "ST_FromArea07" then
    GUI.ElevatorSetTarget("s070_area7_elevator", false)
  end
end
function s060_area6.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s060_area6.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
end
function s060_area6.InitFromBlackboard()
end
function s060_area6.OnReloaded()
end
function s060_area6.OnExit()
end
function s060_area6.OnEnter_ActivationDNA()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA", 7)
end
function s060_area6.OnEnter_ActivationTeleport_06A_001()
  Game.OnTeleportApproached("LE_Teleporter_06A_001")
end
function s060_area6.OnEnter_ActivationTeleport_06A_002()
  Game.OnTeleportApproached("LE_Teleporter_06A_002")
end
function s060_area6.OnHazarousPoolDrain(_ARG_0_)
  Game.SetSubAreaCurrentSetup("collision_camera_004", "Hazarous_Empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_017", "Hazarous_Empty", true)
end
function s060_area6.OnEnterHazardous()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_004", "Enter_Hazardous", false)
end
function s060_area6.OnExitHazardous()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_004", "Default", false)
end
function s060_area6.LaunchSpecialEnergyCutscene()
  Game.LaunchCutscene("cutscenes/phasedisplacement/takes/01/phasedisplacement01.bmscu")
end
function s060_area6.OnStartSpecialEnergyCutscene()
end
function s060_area6.OnEndSpecialEnergyCutscene()
  guicallbacks.OnPickableItemPickedUp("#GUI_ITEM_ACQUIRED_PHASE_DISPLACEMENT", true)
end
function s060_area6.OnLE_Platform_Elevator_FromArea06C_01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s067_area6c", "ST_FromArea06A_01", _ARG_2_)
end
function s060_area6.OnLE_Platform_Elevator_FromArea06C_02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s067_area6c", "ST_FromArea06A_02", _ARG_2_)
end
function s060_area6.PreLE_Platform_Elevator_FromArea06C_01()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s060_area6.PreLE_Platform_Elevator_FromArea06C_02()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s060_area6.OnEnter_SetCheckpoint_001_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001", "ST_SG_Alpha_001", "SG_Alpha_001", "", "")
end
function s060_area6.OnEnter_SetCheckpoint_002_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001B", "ST_SG_Alpha_001B_Out", "SG_Alpha_001", "", "")
end
function s060_area6.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_001")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door020")
    -- _ARG_1_.AI:AddBossDoor("Door021")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha001_Idle")
  end
end
function s060_area6.OnEnter_Alpha_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_012", "PostAlpha_001", true)
    if Game.GetEntity("SpawnGroup026") ~= nil then
      Game.GetEntity("SpawnGroup026").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup027") ~= nil then
      Game.GetEntity("SpawnGroup027").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.EnableEntity("ChuteLeech_011")
  end
end
function s060_area6.OnEnter_SetCheckpoint_001_Gamma_004()
  Game.SetBossCheckPointNames("ST_SG_Gamma_004", "ST_SG_Gamma_004_Out", "SG_Gamma_004", "", "")
end
function s060_area6.OnGamma_004_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_004")
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma004_Idle")
  end
end
function s060_area6.OnEnter_Gamma_004_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Gamma_004_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_016", "PostGamma_004", true)
    Game.SetSubAreaCurrentSetup("collision_camera_013", "PostGamma_004", true)
    if Game.GetEntity("SpawnGroup028") ~= nil then
      Game.GetEntity("SpawnGroup028").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup029") ~= nil then
      Game.GetEntity("SpawnGroup029").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s060_area6.OnGulluggStr_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_001")
  end
end
function s060_area6.OnGulluggStr_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_002")
  end
end
function s060_area6.OnGulluggStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_003")
  end
end
function s060_area6.OnGulluggStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_004")
  end
end
function s060_area6.OnGulluggStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_005")
  end
end
function s060_area6.OnGulluggStr_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_006")
  end
end
function s060_area6.OnGulluggStr_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_007")
  end
end
function s060_area6.OnGulluggStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_008")
  end
end
function s060_area6.OnGulluggStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_009")
  end
end
function s060_area6.OnGulluggStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_010")
  end
end
function s060_area6.OnGulluggStr_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_011")
  end
end
function s060_area6.OnGulluggStr_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_012")
  end
end
function s060_area6.OnGulluggStr_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_013")
  end
end
function s060_area6.OnGulluggStr_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_014")
  end
end
function s060_area6.OnGulluggStr_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_015")
  end
end
function s060_area6.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s060_area6.OnMeboid_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_001")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s060_area6.OnMeboid_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_002")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s060_area6.OnMeboid_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_003")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s060_area6.OnMeboid_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_004")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s060_area6.OnMeboid_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_005")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s060_area6.OnMeboid_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_006")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s060_area6.OnEnter_ChangeCamera_001()
  Game.SetCollisionCameraLocked("collision_camera_001_B", true)
end
function s060_area6.OnExit_ChangeCamera_001()
  Game.SetCollisionCameraLocked("collision_camera_001_B", false)
end
function s060_area6.OnEnter_ChangeCamera_006()
  Game.SetCollisionCameraLocked("collision_camera_006_B", true)
end
function s060_area6.OnExit_ChangeCamera_006()
  Game.SetCollisionCameraLocked("collision_camera_006_B", false)
end

function s060_area6.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end