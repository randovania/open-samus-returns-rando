Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s020_area2.main()
  Scenario.InitGUI()
end
function s020_area2.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s020_area2.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
end
function s020_area2.LaunchSpecialEvent02()
  if Game.GetEntity("LE_Event_02") ~= nil then
    Game.GetEntity("LE_Event_02").ANIMATION:SetAction("event")
  end
end
function s020_area2.OnUnlockAreaUse()
  Scenario.FadeOutAndLoad("c10_samus", "s030_area3", "StartPointReturnArea", 0.5)
end
function s020_area2.OnReturnAreaUse()
  Scenario.FadeOutAndLoad("c10_samus", "s010_area1", "StartPointUnlockArea", 0.5)
end
function s020_area2.OnReturnAreaStart(_ARG_0_, _ARG_1_)
  Scenario.SetSmartObjectStateUse("LE_ChozoReturnArea", "systemmechbackout")
end
function s020_area2.OnUnlockAreaStart(_ARG_0_, _ARG_1_)
  Scenario.SetSmartObjectStateUse("LE_ChozoUnlockArea", "unlockareaout")
end
function s020_area2.InitFromBlackboard()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Arachnus_001_deaths", 0) and Game.GetEntity("LE_StatueArachnus") ~= nil then
    Game.GetEntity("LE_StatueArachnus").ANIMATION:SetAction("relaxbroken", true)
  end
end
function s020_area2.OnReloaded()
end
function s020_area2.OnExit()
end
function s020_area2.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_2_ == "collision_camera_006" then
    Game.DelSF("s020_area2.CloseDoor004")
    Game.AddSF(0.1, "s020_area2.CloseDoor004", "")
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s020_area2.CloseDoor004()
  if Game.GetEntity("Door004") ~= nil then
    if Game.GetEntity("Door004").LIFE:CanBeClosedSafely() then
      Game.GetEntity("Door004").LIFE:CloseDoor()
      Game.GetEntity("Door004").LIFE:SetInvulnerableFor(2)
    else
      Game.AddSF(0.1, "s020_area2.CloseDoor004", "")
    end
  end
end
function s020_area2.OnEnter_ActivationTeleport_02_02()
  Game.OnTeleportApproached("LE_Teleporter_02_02")
end
function s020_area2.OnEnter_ActivationTeleport_02_03()
  Game.OnTeleportApproached("LE_Teleporter_02_03")
end
s020_area2.tDNAScanLandmarks = {
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
    "LM_ADNScanner_Samus_Alpha_001_015",
    "LM_ADNScanner_Samus_Alpha_001_016",
    "LM_ADNScanner_Samus_Alpha_001_017",
    "LM_ADNScanner_Samus_Alpha_001_018",
    "LM_ADNScanner_Samus_Alpha_001_019",
    "LM_ADNScanner_Samus_Alpha_001_020",
    "LM_ADNScanner_Samus_Alpha_001_021",
    "LM_ADNScanner_Samus_Alpha_001_022",
    "LM_ADNScanner_Samus_Alpha_001_023"
  },
  SG_Alpha_003 = {
    "LM_ADNScanner_Samus_Alpha_003_001",
    "LM_ADNScanner_Samus_Alpha_003_002",
    "LM_ADNScanner_Samus_Alpha_003_003",
    "LM_ADNScanner_Samus_Alpha_003_004",
    "LM_ADNScanner_Samus_Alpha_003_005",
    "LM_ADNScanner_Samus_Alpha_003_006",
    "LM_ADNScanner_Samus_Alpha_003_007",
    "LM_ADNScanner_Samus_Alpha_003_008",
    "LM_ADNScanner_Samus_Alpha_003_009",
    "LM_ADNScanner_Samus_Alpha_003_010",
    "LM_ADNScanner_Samus_Alpha_003_011",
    "LM_ADNScanner_Samus_Alpha_003_012",
    "LM_ADNScanner_Samus_Alpha_003_013",
    "LM_ADNScanner_Samus_Alpha_003_014",
    "LM_ADNScanner_Samus_Alpha_003_015",
    "LM_ADNScanner_Samus_Alpha_003_016",
    "LM_ADNScanner_Samus_Alpha_003_017",
    "LM_ADNScanner_Samus_Alpha_003_018",
    "LM_ADNScanner_Samus_Alpha_003_019",
    "LM_ADNScanner_Samus_Alpha_003_020",
    "LM_ADNScanner_Samus_Alpha_003_021"
  },
  SG_Alpha_004 = {
    "LM_ADNScanner_Samus_Alpha_004_001",
    "LM_ADNScanner_Samus_Alpha_004_002",
    "LM_ADNScanner_Samus_Alpha_004_003",
    "LM_ADNScanner_Samus_Alpha_004_004",
    "LM_ADNScanner_Samus_Alpha_004_005",
    "LM_ADNScanner_Samus_Alpha_004_006",
    "LM_ADNScanner_Samus_Alpha_004_007",
    "LM_ADNScanner_Samus_Alpha_004_008",
    "LM_ADNScanner_Samus_Alpha_004_009",
    "LM_ADNScanner_Samus_Alpha_004_010",
    "LM_ADNScanner_Samus_Alpha_004_011",
    "LM_ADNScanner_Samus_Alpha_004_012",
    "LM_ADNScanner_Samus_Alpha_004_013",
    "LM_ADNScanner_Samus_Alpha_004_014",
    "LM_ADNScanner_Samus_Alpha_004_015",
    "LM_ADNScanner_Samus_Alpha_004_016",
    "LM_ADNScanner_Samus_Alpha_004_017",
    "LM_ADNScanner_Samus_Alpha_004_018",
    "LM_ADNScanner_Samus_Alpha_004_019",
    "LM_ADNScanner_Samus_Alpha_004_020",
    "LM_ADNScanner_Samus_Alpha_004_021",
    "LM_ADNScanner_Samus_Alpha_004_022"
  },
  SG_Alpha_005 = {
    "LM_ADNScanner_Samus_Alpha_005_001",
    "LM_ADNScanner_Samus_Alpha_005_002",
    "LM_ADNScanner_Samus_Alpha_005_003",
    "LM_ADNScanner_Samus_Alpha_005_004",
    "LM_ADNScanner_Samus_Alpha_005_005",
    "LM_ADNScanner_Samus_Alpha_005_006",
    "LM_ADNScanner_Samus_Alpha_005_007",
    "LM_ADNScanner_Samus_Alpha_005_008",
    "LM_ADNScanner_Samus_Alpha_005_009",
    "LM_ADNScanner_Samus_Alpha_005_010"
  },
  SG_Alpha_006 = {
    "LM_ADNScanner_Samus_Alpha_006_001",
    "LM_ADNScanner_Samus_Alpha_006_002",
    "LM_ADNScanner_Samus_Alpha_006_003",
    "LM_ADNScanner_Samus_Alpha_006_004",
    "LM_ADNScanner_Samus_Alpha_006_005",
    "LM_ADNScanner_Samus_Alpha_006_006",
    "LM_ADNScanner_Samus_Alpha_006_007"
  },
  SG_Alpha_007 = {
    "LM_ADNScanner_Samus_Alpha_007_001",
    "LM_ADNScanner_Samus_Alpha_007_002",
    "LM_ADNScanner_Samus_Alpha_007_003",
    "LM_ADNScanner_Samus_Alpha_007_004",
    "LM_ADNScanner_Samus_Alpha_007_005",
    "LM_ADNScanner_Samus_Alpha_007_006",
    "LM_ADNScanner_Samus_Alpha_007_007",
    "LM_ADNScanner_Samus_Alpha_007_008",
    "LM_ADNScanner_Samus_Alpha_007_009",
    "LM_ADNScanner_Samus_Alpha_007_010",
    "LM_ADNScanner_Samus_Alpha_007_011",
    "LM_ADNScanner_Samus_Alpha_007_012"
  }
}
function s020_area2.OnLE_Platform_Elevator_FromArea02B(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s025_area2b", "ST_FromArea02A", _ARG_2_)
end
function s020_area2.OnLE_Platform_Elevator_FromArea02C(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s028_area2c", "ST_FromArea02A", _ARG_2_)
end
function s020_area2.PreLE_Platform_Elevator_FromArea02B()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s020_area2.PreLE_Platform_Elevator_FromArea02C()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s020_area2.OnArachnus_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    Game.SetBossCheckPointNames("ST_SG_Arachnus", "ST_SG_Arachnus_Out", "SG_Arachnus_001", "", "")
    _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Arachnus")
  end
end
function s020_area2.OnEnter_Arachnus_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Arachnus_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_006", "PostArachnus_001", true)
    Game.SetSubAreaCurrentSetup("collision_camera_007", "PostArachnus_001", true)
    Game.SetSubAreaCurrentSetup("collision_camera_038", "PostArachnus_001", true)
    if 0 < Blackboard.GetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL") and Game.GetEntity("SpawnGroup051") ~= nil then
      Game.GetEntity("SpawnGroup051").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnEnter_SetCheckpoint_001_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001", "ST_SG_Alpha_001_Out", "SG_Alpha_001", "", "")
end
function s020_area2.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_001")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door020")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI.bUseSpawnGroupEdges = false
    _ARG_1_.AI:SetMultiLayerArenaPoly(0, "LS_Alpha_001_Down")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha001_001")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha001_002")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha001_003")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(0, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(0, "PATH_Alpha001_Mines_002")
    _ARG_1_.AI:AddMultiLayerArenaIdleLogicPath(0, "PATH_Alpha001_Idle_001")
    _ARG_1_.AI:SetMultiLayerArenaPoly(1, "LS_Alpha_001_Up")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(1, "PATH_Alpha001_004")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(1, "PATH_Alpha001_005")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(1, "PATH_Alpha001_006")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(1, "PATH_Alpha001_Mines_003")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(1, "PATH_Alpha001_Mines_004")
    _ARG_1_.AI:AddMultiLayerArenaIdleLogicPath(1, "PATH_Alpha001_Idle_002")
  end
end
function s020_area2.OnAlpha_003_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_003") ~= nil and Game.GetEntity("Alpha_003").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_003").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_003_Intro") ~= nil and Game.GetEntity("Alpha_003_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_003_Intro").SPAWNPOINT:Deactivate()
  end
  s020_area2.OnAlpha_003_Generated(_ARG_0_, _ARG_1_)
end
function s020_area2.Spawn_Alpha_003_Intro()
  Game.DisableTrigger("TG_Alpha_003_Intro")
  if Game.GetEntity("SG_Alpha_003") ~= nil then
    Game.GetEntity("SG_Alpha_003").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s020_area2.OnEnter_SetCheckpoint_001_Alpha_003()
  Game.SetBossCheckPointNames("ST_SG_Alpha_003", "ST_SG_Alpha_003_Out", "SG_Alpha_003", "", "")
end
function s020_area2.OnEnter_SetCheckpoint_002_Alpha_003()
  Game.SetBossCheckPointNames("ST_SG_Alpha_003B", "ST_SG_Alpha_003B_Out", "SG_Alpha_003", "", "")
end
function s020_area2.OnAlpha_003_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_003")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door021")
    -- _ARG_1_.AI:AddBossDoor("Door009")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha003_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha003_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha003_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha003_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha003_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha003_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha003_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha003_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha003_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha003_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha003_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha003_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha003_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha003_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha003_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha003_Idle")
  end
end
function s020_area2.OnEnter_SetCheckpoint_001_Alpha_004()
  Game.SetBossCheckPointNames("ST_SG_Alpha_004", "ST_SG_Alpha_004_Out", "SG_Alpha_004", "", "")
end
function s020_area2.OnAlpha_004_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_004")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door010")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI.bUseSpawnGroupEdges = false
    _ARG_1_.AI:SetMultiLayerArenaPoly(0, "LS_Alpha_004_Down")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha004_001")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha004_002")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha004_003")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(0, "PATH_Alpha004_004")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(0, "PATH_Alpha004_Mines_001")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(0, "PATH_Alpha004_Mines_002")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(0, "PATH_Alpha004_Mines_003")
    _ARG_1_.AI:AddMultiLayerArenaIdleLogicPath(0, "PATH_Alpha004_Idle_001")
    _ARG_1_.AI:SetMultiLayerArenaPoly(1, "LS_Alpha_004_Up")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(1, "PATH_Alpha004_005")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(1, "PATH_Alpha004_006")
    _ARG_1_.AI:AddMultiLayerArenaLogicPath(1, "PATH_Alpha004_007")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(1, "PATH_Alpha004_Mines_004")
    _ARG_1_.AI:AddMultiLayerArenaElectricMinesLogicPath(1, "PATH_Alpha004_Mines_005")
    _ARG_1_.AI:AddMultiLayerArenaIdleLogicPath(1, "PATH_Alpha004_Idle_002")
    _ARG_1_.AI.bCanUseMinesIfHangInNeutralZone = false
  end
end
function s020_area2.OnAlpha_005_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_005") ~= nil and Game.GetEntity("Alpha_005").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_005").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_005_Intro") ~= nil and Game.GetEntity("Alpha_005_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_005_Intro").SPAWNPOINT:Deactivate()
  end
  s020_area2.OnAlpha_005_Generated(_ARG_0_, _ARG_1_)
end
function s020_area2.Spawn_Alpha_005_Intro()
  Game.DisableTrigger("TG_Alpha_005_Intro")
  if Game.GetEntity("SG_Alpha_005") ~= nil then
    Game.GetEntity("SG_Alpha_005").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s020_area2.OnEnter_SetCheckpoint_001_Alpha_005()
  Game.SetBossCheckPointNames("ST_SG_Alpha_005", "ST_SG_Alpha_005_Out", "SG_Alpha_005", "", "")
end
function s020_area2.OnAlpha_005_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_005")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door022")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Alpha_005")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha005_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha005_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha005_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha005_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha005_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha005_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha005_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha005_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha005_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha005_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha005_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha005_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha005_Idle")
  end
end
function s020_area2.OnEnter_SetCheckpoint_001_Alpha_006()
  Game.SetBossCheckPointNames("ST_SG_Alpha_006", "ST_SG_Alpha_006_Out", "SG_Alpha_006", "", "")
end
function s020_area2.OnAlpha_006_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_006")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door017")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha006_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha006_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha006_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha006_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha006_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha006_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha006_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha006_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha006_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha006_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha006_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha006_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha006_Idle")
  end
end
function s020_area2.OnAlpha_007_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_007") ~= nil and Game.GetEntity("Alpha_007").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_007").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_007_Intro") ~= nil and Game.GetEntity("Alpha_007_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_007_Intro").SPAWNPOINT:Deactivate()
  end
  s020_area2.OnAlpha_007_Generated(_ARG_0_, _ARG_1_)
end
function s020_area2.Spawn_Alpha_007_Intro()
  Game.DisableTrigger("TG_Alpha_007_Intro")
  if Game.GetEntity("SG_Alpha_007") ~= nil then
    Game.GetEntity("SG_Alpha_007").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s020_area2.OnEnter_SetCheckpoint_001_Alpha_007()
  Game.SetBossCheckPointNames("ST_SG_Alpha_007", "ST_SG_Alpha_007_Out", "SG_Alpha_007", "", "")
end
function s020_area2.OnAlpha_007_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_007")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha007_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha007_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha007_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha007_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha007_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha007_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha007_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha007_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha007_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha007_Mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha007_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha007_Mines_002")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha007_Idle")
  end
end
function s020_area2.OnEnter_Alpha_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_033", "PostAlpha_001", true)
    if Game.GetEntity("SpawnGroup035") ~= nil then
      Game.GetEntity("SpawnGroup035").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnEnter_Alpha_003_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_003_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_028", "PostAlpha_003", true)
    if Game.GetEntity("SpawnGroup036") ~= nil then
      Game.GetEntity("SpawnGroup036").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnEnter_Alpha_004_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_004_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_030", "PostAlpha_004", true)
    if Game.GetEntity("SpawnGroup037") ~= nil then
      Game.GetEntity("SpawnGroup037").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnEnter_Alpha_005_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_005_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_035", "PostAlpha_005", true)
    if Game.GetEntity("SpawnGroup038") ~= nil then
      Game.GetEntity("SpawnGroup038").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnEnter_Alpha_006_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_006_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_036", "PostAlpha_006", true)
    if Game.GetEntity("SpawnGroup039") ~= nil then
      Game.GetEntity("SpawnGroup039").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnEnter_Alpha_007_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_007_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_040", "PostAlpha_007", true)
    if Game.GetEntity("SpawnGroup040") ~= nil then
      Game.GetEntity("SpawnGroup040").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s020_area2.OnDrivel_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_001")
  end
end
function s020_area2.OnDrivel_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_002")
  end
end
function s020_area2.OnDrivel_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_003")
  end
end
function s020_area2.OnDrivel_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_005")
  end
end
function s020_area2.OnDrivel_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_006")
  end
end
function s020_area2.OnDrivel_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_007")
  end
end
function s020_area2.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s020_area2.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s020_area2.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s020_area2.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s020_area2.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s020_area2.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s020_area2.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s020_area2.OnGullugg_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_014")
  end
end
function s020_area2.OnGullugg_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s020_area2.OnGullugg_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_016")
  end
end
function s020_area2.OnGullugg_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_018")
  end
end
function s020_area2.OnGullugg_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_019")
  end
end
function s020_area2.OnGullugg_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_020")
  end
end
function s020_area2.OnGullugg_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_021")
  end
end
function s020_area2.OnGullugg_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_022")
  end
end
function s020_area2.OnGullugg_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_023")
  end
end
function s020_area2.OnGullugg_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_024")
  end
end
function s020_area2.OnGullugg_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_025")
  end
end
function s020_area2.OnGullugg_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_026")
  end
end
function s020_area2.OnGullugg_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_027")
  end
end
function s020_area2.OnGullugg_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_028")
  end
end
function s020_area2.OnGullugg_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_029")
  end
end
function s020_area2.OnGullugg_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_030")
  end
end
function s020_area2.OnChuteLeech_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fWidthToAppear", 2000)
    _ARG_1_.AI:AddBlackboardParam("fHeightToAppear", 2000)
  end
end
function s020_area2.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s020_area2.OnGlowflyPuzzle_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fDirX", -1)
    _ARG_1_.AI:AddBlackboardParam("bClockwise", false)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", false)
    _ARG_1_.AI:AddBlackboardParam("sBurrowName", "LE_Glowfly_Burrow_001")
    _ARG_1_.AI:AddBlackboardParam("sBurrowName_B", "LE_Glowfly_Burrow_001_B")
    _ARG_1_.ANIMATION:SetDefaultLoop("run")
    _ARG_1_.MOVEMENT:SetGoingClockwise(false)
  end
end
function s020_area2.OnEnter_ChangeCamera_005()
  Game.SetCollisionCameraLocked("collision_camera_005_B", true)
end
function s020_area2.OnExit_ChangeCamera_005()
  Game.SetCollisionCameraLocked("collision_camera_005_B", false)
end
