Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s010_area1.main()
  Scenario.InitGUI()
end
function s010_area1.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s010_area1.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_BOMB", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_ICE_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPIDER_BALL", "f", 0)
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
function s010_area1.InitFromBlackboard()
  if Scenario.ReadFromBlackboard("Alpha_PreSpawn11Event", false) then
    if Game.GetEntity("LE_Alpha_PreSpawn11Event") ~= nil then
      Game.GetEntity("LE_Alpha_PreSpawn11Event"):DelMe()
    end
    Game.DisableTrigger("TG_Alpha_PreSpawn11Event")
  end
  Game.SetCollisionCameraTransitionOverride("collision_camera_008", "collision_camera_037", 2.5, 0.1)
  Game.SetCollisionCameraTransitionOverride("collision_camera_030", "collision_camera_038", 2.5, 0.1)
end
function s010_area1.OnReloaded()
end
function s010_area1.OnExit()
end
function s010_area1.OnEnter_ActivationDNA()
  -- Game.OnDNAMechApproached("LE_ChozoUnlockAreaDNA", 4)
end
function s010_area1.OnEnter_ActivationTeleport_01_01()
end
s010_area1.tDNAScanLandmarks = {
  SG_Alpha_001 = {
    "LM_ADNScanner_Samus_Alpha001_001",
    "LM_ADNScanner_Samus_Alpha001_002",
    "LM_ADNScanner_Samus_Alpha001_003",
    "LM_ADNScanner_Samus_Alpha001_004",
    "LM_ADNScanner_Samus_Alpha001_005",
    "LM_ADNScanner_Samus_Alpha001_006",
    "LM_ADNScanner_Samus_Alpha001_007",
    "LM_ADNScanner_Samus_Alpha001_008",
    "LM_ADNScanner_Samus_Alpha001_009",
    "LM_ADNScanner_Samus_Alpha001_010",
    "LM_ADNScanner_Samus_Alpha001_011"
  },
  SG_Alpha_002 = {
    "LM_ADNScanner_Samus_Alpha002_001",
    "LM_ADNScanner_Samus_Alpha002_002",
    "LM_ADNScanner_Samus_Alpha002_003",
    "LM_ADNScanner_Samus_Alpha002_004",
    "LM_ADNScanner_Samus_Alpha002_005",
    "LM_ADNScanner_Samus_Alpha002_006"
  },
  SG_Alpha_003 = {
    "LM_ADNScanner_Samus_Alpha003_001",
    "LM_ADNScanner_Samus_Alpha003_002",
    "LM_ADNScanner_Samus_Alpha003_003",
    "LM_ADNScanner_Samus_Alpha003_004",
    "LM_ADNScanner_Samus_Alpha003_005"
  },
  SG_Alpha_004 = {
    "LM_ADNScanner_Samus_Alpha004_001",
    "LM_ADNScanner_Samus_Alpha004_002",
    "LM_ADNScanner_Samus_Alpha004_003",
    "LM_ADNScanner_Samus_Alpha004_004",
    "LM_ADNScanner_Samus_Alpha004_005",
    "LM_ADNScanner_Samus_Alpha004_006",
    "LM_ADNScanner_Samus_Alpha004_007",
    "LM_ADNScanner_Samus_Alpha004_008",
    "LM_ADNScanner_Samus_Alpha004_009",
    "LM_ADNScanner_Samus_Alpha004_010",
    "LM_ADNScanner_Samus_Alpha004_011",
    "LM_ADNScanner_Samus_Alpha004_012",
    "LM_ADNScanner_Samus_Alpha004_013"
  }
}
function s010_area1.OnLE_Platform_Elevator_FromArea00(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s000_surface", "ST_FromArea01", _ARG_2_)
end
function s010_area1.OnLE_Platform_Elevator_FromArea02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s028_area2c", "ST_FromArea01", _ARG_2_)
end
function s010_area1.PreLE_Platform_Elevator_FromArea00()
  GUI.ElevatorSetTarget("s010_area1_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s010_area1.PreLE_Platform_Elevator_FromArea02()
  GUI.ElevatorSetTarget("s020_area2_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s010_area1.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea00" then
    GUI.ElevatorSetTarget("s010_area1_elevator", true)
  elseif _ARG_0_ == "ST_FromArea02" then
    GUI.ElevatorSetTarget("s020_area2_elevator", false)
  end
end
function s010_area1.OnHazarousPoolDrain(_ARG_0_)
  Game.SetSubAreaCurrentSetup("collision_camera_000", "Hazarous_empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_051", "Hazarous_empty", true)
end
function s010_area1.OnEnterHazardous()
  PoisonZone.OnEnter()
  Game.SetSubAreaCurrentSetup("collision_camera_000", "Enter_Hazardous", false)
end
function s010_area1.OnExitHazardous()
  PoisonZone.OnExit()
  Game.SetSubAreaCurrentSetup("collision_camera_000", "Default", false)
end
function s010_area1.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s010_area1.OnMoheekPlat_Clockwise_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sMode", "CLOCKWISE")
  end
end
function s010_area1.OnMoheekPlat_Counterclockwise_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sMode", "COUNTERCLOCKWISE")
  end
end
function s010_area1.OnGravittBuried_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s010_area1.OnGravitt_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
    _ARG_1_.AI:AddBlackboardParam("fDistanceToAppear", 400)
  end
end
function s010_area1.OnGravitt_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
    _ARG_1_.AI:AddBlackboardParam("fDistanceToAppear", 400)
  end
end
function s010_area1.OnGravitt_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fDistanceToAppear", 600)
  end
end
function s010_area1.OnGravitt_036_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fDistanceToAppear", 500)
  end
end
function s010_area1.OnChuteLeech_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 2000)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 2000)
  end
end
function s010_area1.OnChuteLeech_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 1300)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 1100)
  end
end
function s010_area1.OnChuteLeech_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 1300)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 1100)
  end
end
function s010_area1.OnChuteLeech_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 1400)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 1100)
  end
end
function s010_area1.OnChuteLeech_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 1300)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 1100)
  end
end
function s010_area1.OnChuteLeech_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 1500)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 1000)
  end
end
function s010_area1.OnChuteLeech_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 2000)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 800)
  end
end
function s010_area1.OnDrivel_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_001")
  end
end
function s010_area1.OnDrivel_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_002")
  end
end
function s010_area1.OnDrivel_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_003")
  end
end
function s010_area1.OnDrivel_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_004")
  end
end
function s010_area1.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s010_area1.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s010_area1.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s010_area1.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s010_area1.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s010_area1.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s010_area1.OnGullugg_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s010_area1.OnGullugg_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s010_area1.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s010_area1.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s010_area1.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s010_area1.OnGullugg_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_017")
  end
end
function s010_area1.OnGullugg_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_018")
  end
end
function s010_area1.OnGullugg_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_019")
  end
end
function s010_area1.OnGullugg_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_020")
  end
end
function s010_area1.OnGullugg_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_021")
  end
end
function s010_area1.OnGullugg_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_024")
  end
end
function s010_area1.OnGullugg_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_025")
  end
end
function s010_area1.OnGullugg_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_026")
  end
end
function s010_area1.OnGullugg_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_027")
  end
end
function s010_area1.OnGullugg_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_028")
  end
end
function s010_area1.OnGullugg_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_029")
  end
end
function s010_area1.OnGullugg_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_030")
  end
end
function s010_area1.OnGullugg_031_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_031")
  end
end
function s010_area1.OnGullugg_032_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_032")
  end
end
function s010_area1.OnGullugg_033_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_033")
  end
end
function s010_area1.OnGullugg_034_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_034")
  end
end
function s010_area1.OnGullugg_035_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_035")
  end
end
function s010_area1.OnGullugg_036_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_036")
  end
end
function s010_area1.OnGullugg_038_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_038")
  end
end
function s010_area1.OnGullugg_040_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_040")
  end
end
function s010_area1.OnGullugg_041_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_041")
  end
end
function s010_area1.OnGullugg_042_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_042")
  end
end
function s010_area1.OnGullugg_043_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_043")
  end
end
function s010_area1.OnGullugg_044_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_044")
  end
end
function s010_area1.OnGullugg_045_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_045")
  end
end
function s010_area1.OnGullugg_046_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_046")
  end
end
function s010_area1.OnGullugg_047_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_047")
  end
end
function s010_area1.OnGullugg_048_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_048")
  end
end
function s010_area1.OnGullugg_050_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_050")
  end
end
function s010_area1.OnGullugg_051_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_051")
  end
end
function s010_area1.OnGullugg_052_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_052")
  end
end
function s010_area1.OnGullugg_053_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_053")
  end
end
function s010_area1.OnGullugg_054_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_054")
  end
end
function s010_area1.OnGullugg_055_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_055")
  end
end
function s010_area1.OnGullugg_056_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_056")
  end
end
function s010_area1.OnGullugg_057_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_057")
  end
end
function s010_area1.OnGullugg_058_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_058")
  end
end
function s010_area1.OnAlpha_001_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_001") ~= nil and Game.GetEntity("Alpha_001").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_001").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_001_Intro") ~= nil and Game.GetEntity("Alpha_001_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_001_Intro").SPAWNPOINT:Deactivate()
  end
  s010_area1.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
end
function s010_area1.Spawn_Alpha_001_Intro()
  Game.DisableTrigger("TG_Alpha_001_Intro")
  Game.DisableTrigger("TG_SetBreakables_PuzzleIceBeam")
  if Game.GetEntity("SG_Alpha_001") ~= nil then
    Game.GetEntity("SG_Alpha_001").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s010_area1.OnEnter_SetCheckpoint_001_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001", "ST_SG_Alpha_001_Out", "SG_Alpha_001", "", "")
end
function s010_area1.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_001")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
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
function s010_area1.OnEnter_SetCheckpoint_001_Alpha_002()
  Game.SetBossCheckPointNames("ST_SG_Alpha_002", "ST_SG_Alpha_002_Out", "SG_Alpha_002", "", "")
end
function s010_area1.OnAlpha_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_002")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door014")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Alpha_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha002_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha002_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha002_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha002_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha002_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha002_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha002_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha002_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha002_Mines_001")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha002_Idle")
  end
end
function s010_area1.OnEnter_SetCheckpoint_001_Alpha_003()
  Game.SetBossCheckPointNames("ST_SG_Alpha_003", "ST_SG_Alpha_003_Out", "SG_Alpha_003", "", "")
end
function s010_area1.OnAlpha_003_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_003")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door015")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Alpha_003")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha003_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha003_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha003_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha003_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha003_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha003_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha003_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha003_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha003_Mines_001")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha003_Idle")
  end
end
function s010_area1.OnAlpha_004_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_004") ~= nil and Game.GetEntity("Alpha_004").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_004").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_004_Intro") ~= nil and Game.GetEntity("Alpha_004_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_004_Intro").SPAWNPOINT:Deactivate()
  end
  s010_area1.OnAlpha_004_Generated(_ARG_0_, _ARG_1_)
end
function s010_area1.Spawn_Alpha_004_Intro()
  Game.DisableTrigger("TG_Alpha_004_Intro")
  if Game.GetEntity("SG_Alpha_004") ~= nil then
    Game.GetEntity("SG_Alpha_004").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s010_area1.OnEnter_SetCheckpoint_001_Alpha_004()
  Game.SetBossCheckPointNames("ST_SG_Alpha_004", "ST_SG_Alpha_004", "SG_Alpha_004", "", "")
end
function s010_area1.OnEnter_SetCheckpoint_002_Alpha_004()
  Game.SetBossCheckPointNames("ST_SG_Alpha_004B", "ST_SG_Alpha_004B_Out", "SG_Alpha_004", "", "")
end
function s010_area1.OnAlpha_004_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_004")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door016")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha004_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha004_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha004_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha004_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha004_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha004_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha004_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha004_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha004_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha004_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha004_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha004_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha004_Idle")
  end
end
function s010_area1.OnEnter_Alpha_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_054", "PostAlpha_001", true)
    if Game.GetEntity("SpawnGroup057") ~= nil then
      Game.GetEntity("SpawnGroup057").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s010_area1.OnEnter_Alpha_002_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_002_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_025", "PostAlpha_002", true)
    if Game.GetEntity("SpawnGroup054") ~= nil then
      Game.GetEntity("SpawnGroup054").SPAWNGROUP:EnableSpawnGroup()
      Game.GetEntity("SpawnGroup053").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s010_area1.OnEnter_Alpha_003_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_003_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_027", "PostAlpha_003", true)
    if Game.GetEntity("SpawnGroup056") ~= nil then
      Game.GetEntity("SpawnGroup056").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s010_area1.OnEnter_Alpha_004_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_004_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_017", "PostAlpha_004", true)
    if Game.GetEntity("SpawnGroup055") ~= nil then
      Game.GetEntity("SpawnGroup055").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s010_area1.PreSpawn11Event()
  Game.DisableTrigger("TG_Alpha_PreSpawn11Event")
  if Game.GetEntity("LE_Alpha_PreSpawn11Event") ~= nil then
    Game.GetEntity("LE_Alpha_PreSpawn11Event").ANIMATION:SetAction("prespawn11run", true)
    Scenario.WriteToBlackboard("Alpha_PreSpawn11Event", "b", true)
  end
end
-- function s010_area1.LaunchIntroTeleporter01Cutscene()
--   bArea2Discovered = Blackboard.GetProp("s020_area2|s025_area2b|s028_area2c", "s020_area2_discovered")
--   if bArea2Discovered ~= nil then
--     if bArea2Discovered ~= true then
--      Game.AddEntityToUpdateInCutscene("LE_Teleporter_01_01")
--      Game.AddEntityToUpdateInCutscene("LE_Platform_Teleporter_01_01")
--      Game.LaunchCutscene("cutscenes/introteleporterarea01/takes/01/introteleporterarea0101.bmscu")
--     else
--       Game.OnTeleportApproached("LE_Teleporter_01_01")
--     end
--   else
--     Game.AddEntityToUpdateInCutscene("LE_Teleporter_01_01")
--     Game.AddEntityToUpdateInCutscene("LE_Platform_Teleporter_01_01")
--    Game.LaunchCutscene("cutscenes/introteleporterarea01/takes/01/introteleporterarea0101.bmscu")
--   end
--   if Game.GetPlayer() ~= nil then
--     Game.GetPlayer().MOVEMENT:StopForcedAnalogInput()
--   end
-- end
-- function s010_area1.OnEndIntroTeleporter01Cutscene()
--   Game.RemoveEntityToUpdateInCutscene("LE_Teleporter_01_01")
--   Game.RemoveEntityToUpdateInCutscene("LE_Platform_Teleporter_01_01")
function s010_area1.OnEnter_ActivationTeleport_01_01()
  Game.OnTeleportApproached("LE_Teleporter_01_01")
  Game.UpdateCurrentMinimapCellIconState()
end
function s010_area1.LaunchSpecialEvent01()
  if Game.GetEntity("LE_Event_01a") ~= nil then
    Game.GetEntity("LE_Event_01a").ANIMATION:SetAction("eventa")
  end
  if Game.GetEntity("LE_Event_01b") ~= nil then
    Game.GetEntity("LE_Event_01b").ANIMATION:SetAction("eventb")
  end
  if Game.GetEntity("LE_Event_01c") ~= nil then
    Game.GetEntity("LE_Event_01c").ANIMATION:SetAction("eventc")
  end
end
function s010_area1.Enter_Area_OneWayDoor()
  Game.SetCollisionCameraLocked("collision_camera_016_B", true)
end
function s010_area1.Exit_Area_OneWayDoor()
  Game.SetCollisionCameraLocked("collision_camera_016_B", false)
end
function s010_area1.OnEnter_CameraBomb()
  Game.SetSubAreaCurrentSetup("collision_camera_008", "EnterCameraBomb", false, false)
end
function s010_area1.OnExit_CameraBomb()
  Game.SetSubAreaCurrentSetup("collision_camera_008", "Default", false, false)
end
function s010_area1.OnEnter_CameraIce()
  Game.SetSubAreaCurrentSetup("collision_camera_030", "EnterCameraIce", false, false)
end
function s010_area1.OnExit_CameraIce()
  Game.SetSubAreaCurrentSetup("collision_camera_030", "Default", false, false)
end
function s010_area1.OnEnter_ChangeCamera_043_A()
  Game.SetSubAreaCurrentSetup("collision_camera_043", "Default", false, false)
end
function s010_area1.OnEnter_ChangeCamera_043_B()
  Game.SetSubAreaCurrentSetup("collision_camera_043", "ChangeCamera", false, false)
end
function s010_area1.OnEnter_ChangeCamera_023()
  Game.SetCollisionCameraLocked("collision_camera_023_B", true)
end
function s010_area1.OnExit_ChangeCamera_023()
  Game.SetCollisionCameraLocked("collision_camera_023_B", false)
end
function s010_area1.OnEnter_ChangeCamera_018()
  Game.SetCollisionCameraLocked("collision_camera_018_B", true)
end
function s010_area1.OnExit_ChangeCamera_018()
  Game.SetCollisionCameraLocked("collision_camera_018_B", false)
end
function s010_area1.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ == "collision_camera_042" and _ARG_2_ == "collision_camera_049" and Scenario.ReadFromBlackboard("TG_Intro_TeleporterArea01_TRIGGER__DefaultOnEnter_Done", false) == false and Game.GetPlayer() ~= nil then
    --Game.GetPlayer().MOVEMENT:StartForcedAnalogInput(1, 0)
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s010_area1.OnEnter_MinimapSecretUncover_001()
  Game.MinimapUncoverSpecifiedCellSecretRight(31, 19)
end
function s010_area1.OnEnter_MinimapSecretUncover_002()
  Game.MinimapUncoverSpecifiedCellSecretLeft(32, 19)
  Game.MinimapUncoverSpecifiedCellSecretRight(32, 19)
end
function s010_area1.OnEnter_MinimapSecretUncover_003()
  Game.MinimapUncoverSpecifiedCellSecretLeft(33, 19)
end
function s010_area1.OnEnter_SetBreakables_PuzzleIceBeam()
  Game.SetSubAreaCurrentSetup("collision_camera_024", "PuzzleIceBeam", false)
end
function s010_area1.OnExit_SetBreakables_PuzzleIceBeam()
  Game.SetSubAreaCurrentSetup("collision_camera_024", "Default", false)
end
function s010_area1.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s010_area1.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
