Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s065_area6b.main()
  Scenario.InitGUI()
end
function s065_area6b.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s065_area6b.SetupDebugGameBlackboard()
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
function s065_area6b.InitFromBlackboard()
end
function s065_area6b.OnReloaded()
end
function s065_area6b.OnExit()
end
function s065_area6b.OnEnter_ActivationTeleport_06B_001()
  Game.OnTeleportApproached("LE_Teleporter_06B_001")
end
s065_area6b.tDNAScanLandmarks = {
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
  SG_Gamma_002 = {
    "LM_ADNScanner_Samus_Gamma_002_001",
    "LM_ADNScanner_Samus_Gamma_002_002",
    "LM_ADNScanner_Samus_Gamma_002_003",
    "LM_ADNScanner_Samus_Gamma_002_004",
    "LM_ADNScanner_Samus_Gamma_002_005",
    "LM_ADNScanner_Samus_Gamma_002_006",
    "LM_ADNScanner_Samus_Gamma_002_007",
    "LM_ADNScanner_Samus_Gamma_002_008",
    "LM_ADNScanner_Samus_Gamma_002_009",
    "LM_ADNScanner_Samus_Gamma_002_010"
  },
  SG_Gamma_003 = {
    "LM_ADNScanner_Samus_Gamma_003_001",
    "LM_ADNScanner_Samus_Gamma_003_002",
    "LM_ADNScanner_Samus_Gamma_003_003",
    "LM_ADNScanner_Samus_Gamma_003_004",
    "LM_ADNScanner_Samus_Gamma_003_005",
    "LM_ADNScanner_Samus_Gamma_003_006",
    "LM_ADNScanner_Samus_Gamma_003_007",
    "LM_ADNScanner_Samus_Gamma_003_008",
    "LM_ADNScanner_Samus_Gamma_003_009",
    "LM_ADNScanner_Samus_Gamma_003_010",
    "LM_ADNScanner_Samus_Gamma_003_011",
    "LM_ADNScanner_Samus_Gamma_003_012",
    "LM_ADNScanner_Samus_Gamma_003_013",
    "LM_ADNScanner_Samus_Gamma_003_014",
    "LM_ADNScanner_Samus_Gamma_003_015",
    "LM_ADNScanner_Samus_Gamma_003_016",
    "LM_ADNScanner_Samus_Gamma_003_019"
  }
}
function s065_area6b.OnLE_Platform_Elevator_FromArea06C_01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s067_area6c", "ST_FromArea06B_01", _ARG_2_)
end
function s065_area6b.OnLE_Platform_Elevator_FromArea06C_02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s067_area6c", "ST_FromArea06B_02", _ARG_2_)
end
function s065_area6b.PreLE_Platform_Elevator_FromArea06C_01()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s065_area6b.PreLE_Platform_Elevator_FromArea06C_02()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s065_area6b.OnGamma_002_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Gamma_002") ~= nil and Game.GetEntity("Gamma_002").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_002").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Gamma_002_Intro") ~= nil and Game.GetEntity("Gamma_002_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_002_Intro").SPAWNPOINT:Deactivate()
  end
  s065_area6b.OnGamma_002_Generated(_ARG_0_, _ARG_1_)
end
function s065_area6b.Spawn_Gamma_002_Intro()
  Game.DisableTrigger("TG_Gamma_002_Intro")
  if Game.GetEntity("SG_Gamma_002") ~= nil then
    Game.GetEntity("SG_Gamma_002").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s065_area6b.OnEnter_SetCheckpoint_001_Gamma_002()
  Game.SetBossCheckPointNames("ST_SG_Gamma_002", "ST_SG_Gamma_002", "SG_Gamma_002", "", "")
end
function s065_area6b.OnGamma_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_002")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door011")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Gamma_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma002_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma002_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma002_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma002_mines_004")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma002_mines_004")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma002_mines_004")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma002_Idle")
  end
end
function s065_area6b.OnEnter_Gamma_002_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Gamma_002_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_014", "PostGamma_002", true)
    if Game.GetEntity("SpawnGroup015") ~= nil then
      Game.GetEntity("SpawnGroup015").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s065_area6b.OnGamma_003_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Gamma_003") ~= nil and Game.GetEntity("Gamma_003").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_003").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Gamma_003_Intro") ~= nil and Game.GetEntity("Gamma_003_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_003_Intro").SPAWNPOINT:Deactivate()
  end
  s065_area6b.OnGamma_003_Generated(_ARG_0_, _ARG_1_)
end
function s065_area6b.Spawn_Gamma_003_Intro()
  Game.DisableTrigger("TG_Gamma_003_Intro")
  if Game.GetEntity("SG_Gamma_003") ~= nil then
    Game.GetEntity("SG_Gamma_003").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s065_area6b.OnEnter_SetCheckpoint_001_Gamma_003()
  Game.SetBossCheckPointNames("ST_SG_Gamma_003", "ST_SG_Gamma_003", "SG_Gamma_003", "", "")
end
function s065_area6b.OnGamma_003_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_003")
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma003_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma003_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma003_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma003_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma003_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma003_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma003_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma003_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma003_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma003_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma003_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma003_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma003_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma003_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma003_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma003_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma003_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma003_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma003_Idle")
  end
end
function s065_area6b.OnEnter_Gamma_003_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Gamma_003_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_015", "PostGamma_003", true)
    if Game.GetEntity("SpawnGroup016") ~= nil then
      Game.GetEntity("SpawnGroup016").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s065_area6b.OnEnter_SetCheckpoint_001_Zeta_001()
  Game.SetBossCheckPointNames("ST_SG_Zeta_001", "ST_SG_Zeta_001", "SG_Zeta_001", "", "")
end
function s065_area6b.OnZeta_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Zeta_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door012")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI.sNavigableAreaID = "SHAPE_Zeta001"
    _ARG_1_.AI:AddBossCamera("CAM_Zeta")
  end
end
function s065_area6b.OnEnter_Zeta_001_Dead()
  if Scenario.ReadFromBlackboard("entity_SG_Zeta_001_deaths", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_012", "PostZeta_001", true)
    if Game.GetEntity("SpawnGroup017") ~= nil then
      Game.GetEntity("SpawnGroup017").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s065_area6b.OnBlobthrower_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("bDetected", true)
    _ARG_1_.AI:AddRightSwarmPaths("Path_Blobthrower_001_RightPath", "Path_Blobthrower_001_RightAttackPath")
    _ARG_1_.AI:AddLeftSwarmPaths("Path_Blobthrower_001_LeftPath", "Path_Blobthrower_001_LeftAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_001_DeadPath")
    _ARG_1_.AI:AddDeadSwarmPaths("Path_Blobthrower_001_DeadPath", "Path_Blobthrower_001_DeadAttackPath")
  end
end
function s065_area6b.OnBlobthrower_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("bDetected", true)
    _ARG_1_.AI:AddRightSwarmPaths("Path_Blobthrower_002_RightPath", "Path_Blobthrower_002_RightAttackPath")
    _ARG_1_.AI:AddLeftSwarmPaths("Path_Blobthrower_002_LeftPath", "Path_Blobthrower_002_LeftAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_002_ChangePath")
    _ARG_1_.AI:AddDeadSwarmPaths("Path_Blobthrower_002_DeadPath", "Path_Blobthrower_002_DeadAttackPath")
  end
end
function s065_area6b.OnBlobthrower_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("bDetected", true)
    _ARG_1_.AI:AddRightSwarmPaths("Path_Blobthrower_003_RightPath", "Path_Blobthrower_003_RightAttackPath")
    _ARG_1_.AI:AddLeftSwarmPaths("Path_Blobthrower_003_LeftPath", "Path_Blobthrower_003_LeftAttackPath")
    _ARG_1_.AI:AddChangeSwarmPath("Path_Blobthrower_003_ChangePath")
    _ARG_1_.AI:AddDeadSwarmPaths("Path_Blobthrower_003_DeadPath", "Path_Blobthrower_003_DeadAttackPath")
  end
end
function s065_area6b.OnDrivel_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_001")
  end
end
function s065_area6b.OnDrivel_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_002")
  end
end
function s065_area6b.OnDrivel_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_003")
  end
end
function s065_area6b.OnDrivel_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_004")
  end
end
function s065_area6b.OnDrivel_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_005")
  end
end
function s065_area6b.OnDrivel_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_006")
  end
end
function s065_area6b.OnDrivel_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_008")
  end
end
function s065_area6b.OnDrivel_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_009")
  end
end
function s065_area6b.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s065_area6b.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s065_area6b.OnGullugg_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_018")
  end
end
function s065_area6b.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_001")
  end
end
function s065_area6b.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_012")
  end
end
function s065_area6b.OnGullugg_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_013")
  end
end
function s065_area6b.OnGullugg_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_014")
  end
end
function s065_area6b.OnGullugg_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggStrPath_015")
  end
end
function s065_area6b.OnGenericCrawler(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s065_area6b.OnMeboid_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_001")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s065_area6b.OnMeboid_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_002")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s065_area6b.OnMeboid_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_003")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s065_area6b.OnMeboid_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("MeboidPath_004")
    _ARG_1_.CONTROLLER.eMode = "Loop"
  end
end
function s065_area6b.OnParabite_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_001", "ParabitePath_001_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_002", "ParabitePath_001_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s065_area6b.OnParabite_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_002")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_002_001", "ParabitePath_002_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_002_002", "ParabitePath_002_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s065_area6b.OnPickedUp(_ARG_0_)
  if _ARG_0_ == "powerup_screwattack" then
    Game.SetSubAreaCurrentSetup("collision_camera_016", "After_Screw", true)
  end
end
function s065_area6b.OnEnter_ChangeCamera_002()
  Game.SetCollisionCameraLocked("collision_camera_002_B", true)
end
function s065_area6b.OnExit_ChangeCamera_002()
  Game.SetCollisionCameraLocked("collision_camera_002_B", false)
end
function s065_area6b.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end