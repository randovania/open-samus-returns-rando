Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s025_area2b.main()
  Scenario.InitGUI()
end
function s025_area2b.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s025_area2b.SetupDebugGameBlackboard()
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
function s025_area2b.InitFromBlackboard()
  if Game.GetEntity("LE_Event_02b1") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent02b1Launched") then
    Game.GetEntity("LE_Event_02b1"):Disable()
  end
  if Game.GetEntity("LE_Event_02b2") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent02b2Launched") then
    Game.GetEntity("LE_Event_02b2"):Disable()
  end
  if Game.GetEntity("LE_Event_02b3") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent02b3Launched") then
    Game.GetEntity("LE_Event_02b3"):Disable()
  end
end
function s025_area2b.OnReloaded()
end
function s025_area2b.OnExit()
end
function s025_area2b.OnEnter_ActivationTeleport_02_04()
  Game.OnTeleportApproached("LE_Teleporter_02_04")
end
s025_area2b.tDNAScanLandmarks = {
  SG_Gamma_001 = {
    "LM_ADNScanner_Samus_Gamma_001_001",
    "LM_ADNScanner_Samus_Gamma_001_002",
    "LM_ADNScanner_Samus_Gamma_001_003",
    "LM_ADNScanner_Samus_Gamma_001_004",
    "LM_ADNScanner_Samus_Gamma_001_005",
    "LM_ADNScanner_Samus_Gamma_001_006",
    "LM_ADNScanner_Samus_Gamma_001_007",
    "LM_ADNScanner_Samus_Gamma_001_008",
    "LM_ADNScanner_Samus_Gamma_001_009",
    "LM_ADNScanner_Samus_Gamma_001_010",
    "LM_ADNScanner_Samus_Gamma_001_011",
    "LM_ADNScanner_Samus_Gamma_001_012",
    "LM_ADNScanner_Samus_Gamma_001_013"
  }
}
function s025_area2b.OnLE_Platform_Elevator_FromArea02A(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s020_area2", "ST_FromArea02B", _ARG_2_)
end
function s025_area2b.PreLE_Platform_Elevator_FromArea02A()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s025_area2b.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_3_ ~= "PostVariaSuit" then
    Game.SetSubAreaEnvironmentLocked(false, false, false)
  end
  if _ARG_2_ == "collision_camera037" and not Scenario.ReadFromBlackboard("GammaIntroCutscenePlayed", false) then
    s025_area2b.LaunchFirstTimeGammaPresentation()
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s025_area2b.OnStartVariaSuitCutscene()
  Game.SetSubAreaEnvironmentLocked(false, false, false)
  Game.OnSuitCutsceneLaunched()
end
function s025_area2b.OnEndVariaSuitCutscene()
  Game.TeleportEntityToLandmark("Samus", "LM_VariaSuit_Cutscene", true, 0, true, 0, 0, 0)
  Game.GetPlayer().ANIMATION:SetAction("relax", true)
  Game.SetGameModeStartButtonForbidden("INGAME", false)
  Game.GetPlayer().MODELUPDATER.sModelAlias = "Varia"
  SpecialEnergyCloud.ActivateSpecialEnergy("TG_SpecialEnergyCloud_VariaSuite")
  Game.SetSubAreaCurrentSetup("collision_camera011", "PostVariaSuit", true, true)
  Game.FadeIn(0.3)
  Game.SetPlayerInputEnabled(false, false)
  Game.AddSF(0.3, "s025_area2b.VariaSuitPicked", "")
  Game.HUDIdleScreenLeave()
  Game.HUDAvailabilityGoOff(false, false, false, false)
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(true)
  Game.SaveGame("checkpoint", "AfterNewAbilityAcquired", "", true)
end
function s025_area2b.VariaSuitPicked()
  guicallbacks.OnPickableItemPickedUp("#GUI_ITEM_ACQUIRED_VARIA_SUIT", false)
  Game.SetPlayerInputEnabled(true, false)
end
function s025_area2b.OnEnter_SetCheckpoint_001_Gamma_001()
  Game.SetBossCheckPointNames("ST_SG_Gamma_001", "ST_SG_Gamma_001_Out", "SG_Gamma_001", "", "")
end
function s025_area2b.OnEnter_SetCheckpoint_002_Gamma_001()
  Game.SetBossCheckPointNames("ST_SG_Gamma_001B", "ST_SG_Gamma_001B_Out", "SG_Gamma_001", "", "")
end
function s025_area2b.OnGamma_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door010")
    -- _ARG_1_.AI:AddBossDoor("Door018")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma001_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma001_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma001_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma001_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma001_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma001_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma001_Idle")
  end
end
function s025_area2b.OnEnter_Gamma_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Gamma_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera037", "PostGamma_001", true)
    if Game.GetEntity("SpawnGroup034") ~= nil then
      Game.GetEntity("SpawnGroup034").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s025_area2b.OnGravittBuried_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s025_area2b.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s025_area2b.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s025_area2b.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s025_area2b.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s025_area2b.OnGullugg_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s025_area2b.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s025_area2b.OnGullugg_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s025_area2b.OnGullugg_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_016")
  end
end
function s025_area2b.OnGullugg_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_020")
  end
end
function s025_area2b.OnGullugg_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_021")
  end
end
function s025_area2b.OnGullugg_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_022")
  end
end
function s025_area2b.OnGullugg_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_023")
  end
end
function s025_area2b.OnGullugg_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_025")
  end
end
function s025_area2b.OnGullugg_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_026")
  end
end
function s025_area2b.OnGullugg_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_027")
  end
end
function s025_area2b.OnGullugg_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_028")
  end
end
function s025_area2b.OnGullugg_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_029")
  end
end
function s025_area2b.OnGullugg_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_030")
  end
end
function s025_area2b.OnGullugg_031_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_031")
  end
end
function s025_area2b.OnDrivel_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_001")
  end
end
function s025_area2b.OnDrivel_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_002")
  end
end
function s025_area2b.OnDrivel_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_003")
  end
end
function s025_area2b.OnDrivel_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_004")
  end
end
function s025_area2b.OnDrivel_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_005")
  end
end
function s025_area2b.OnDrivel_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_006")
  end
end
function s025_area2b.OnDrivel_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_008")
  end
end
function s025_area2b.OnDrivel_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_009")
  end
end
function s025_area2b.OnParabite_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddIdlePath("ParabitePath_Idle_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_Attack_001", "ParabitePath_001_001")
    _ARG_1_.CONTROLLER:AddShapePath("LS_Parabite_001_Attack_002", "ParabitePath_001_002")
    _ARG_1_.CONTROLLER.eMode = "StaticAttack"
  end
end
function s025_area2b.LaunchFirstTimeGammaPresentation()
  Scenario.WriteToBlackboard("GammaIntroCutscenePlayed", "b", true)
  s025_area2b.OnGammaPresentationCutsceneStart()
  -- Game.LaunchCutscene("cutscenes/introgamma/takes/01/introgamma01.bmscu")
  Game.MetroidRadarForceStateOnBegin(2, -1, true, true)
end
function s025_area2b.OnGammaPresentationCutsceneStart()
  if Game.GetEntity("SG_Gamma_001") ~= nil then
    Game.GetEntity("SG_Gamma_001").SPAWNGROUP:EnableSpawnGroup()
    Game.AddSF(0.5, "Game.MetroidRadarForceStateOnEnd", "")
    if Game.GetEntityFromSpawnPoint("SP_Gamma_001") ~= nil then
      Game.GetEntityFromSpawnPoint("SP_Gamma_001").AI:SetBossCamera(true)
    end
  end
end
function s025_area2b.OnGammaPresentationCutsceneEnd()
end
function s025_area2b.LaunchSpecialEvent02b1()
  if Blackboard.GetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS") > 0 then
    if Game.GetEntity("LE_Event_02b1") ~= nil then
      Game.GetEntity("LE_Event_02b1").ANIMATION:SetAction("event")
      Scenario.WriteToBlackboard("SpecialEvent02b1Launched", "b", true)
    end
    Game.DisableTrigger("TG_Event_02b1")
  end
end
function s025_area2b.LaunchSpecialEvent02b2()
  if Blackboard.GetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS") > 0 then
    if Game.GetEntity("LE_Event_02b2") ~= nil then
      Game.GetEntity("LE_Event_02b2").ANIMATION:SetAction("event")
      Scenario.WriteToBlackboard("SpecialEvent02b2Launched", "b", true)
    end
    Game.DisableTrigger("TG_Event_02b2")
  end
end
function s025_area2b.LaunchSpecialEvent02b3()
  if Blackboard.GetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS") > 0 then
    if Game.GetEntity("LE_Event_02b3") ~= nil then
      Game.GetEntity("LE_Event_02b3").ANIMATION:SetAction("event")
      Scenario.WriteToBlackboard("SpecialEvent02b3Launched", "b", true)
    end
    Game.DisableTrigger("TG_Event_02b3")
  end
end
function s025_area2b.OnEnter_ChangeCamera_012()
  Game.SetCollisionCameraLocked("collision_camera012_B", true)
end
function s025_area2b.OnExit_ChangeCamera_012()
  Game.SetCollisionCameraLocked("collision_camera012_B", false)
end
function s025_area2b.OnEnter_ChangeCamera_015()
  Game.SetCollisionCameraLocked("collision_camera015_B", true)
end
function s025_area2b.OnExit_ChangeCamera_015()
  Game.SetCollisionCameraLocked("collision_camera015_B", false)
end
function s025_area2b.OnEnter_ChangeCamera_016()
  Game.SetCollisionCameraLocked("collision_camera016_B", true)
end
function s025_area2b.OnExit_ChangeCamera_016()
  Game.SetCollisionCameraLocked("collision_camera016_B", false)
end
