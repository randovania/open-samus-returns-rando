Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
Game.ImportLibrary("actors/props/firsttimednastatuehint/scripts/firsttimednastatuehint.lua", false)
Game.ImportLibrary("actors/props/firsttimecameras/scripts/firsttimecameras.lua", false)
Game.ImportLibrary("actors/props/spenergycloud/scripts/spenergycloud.lua", false)
function s000_surface.main()
  Scenario.InitGUI()
end
function s000_surface.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s000_surface.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_MORPH_BALL", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_CHARGE_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY", "f", 0)
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
  Game.WriteToGameBlackboardSection("PlayedCutscenes", "cutscenes/planetarrival/takes/10/planetarrival10.bmscu", true)
end
function s000_surface.OnLE_Platform_Elevator_FromArea01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s010_area1", "ST_FromArea00", _ARG_2_)
end
function s000_surface.OnLE_Platform_Elevator_FromArea10(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s100_area10", "ST_FromAreaSurface", _ARG_2_)
end
function s000_surface.PreLE_Platform_Elevator_FromArea01()
  GUI.ElevatorSetTarget("s010_area1_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s000_surface.PreLE_Platform_Elevator_FromArea10()
  GUI.ElevatorSetTarget("s000_surface_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s000_surface.ElevatorSetTarget(_ARG_0_)
  GUI.ElevatorSetTarget("s010_area1_elevator", false)
end
function s000_surface.OnShipStartPointTeleport(_ARG_0_, _ARG_1_)
  _ARG_1_.ANIMATION:SetAction("waiting", true)
  if Game.GetEntity("LE_SamusShip") ~= nil and Game.GetEntity("LE_SamusShip").SMARTOBJECT ~= nil then
    Game.GetEntity("LE_SamusShip").SMARTOBJECT:OnStartUse()
    if Game.GetFromGameBlackboardSection("PlayedCutscenes", "cutscenes/planetarrival/takes/10/planetarrival10.bmscu") then
      Game.HUDIdleScreenLeave()
    end
  end
end
function s000_surface.InitFromBlackboard()
  if Scenario.ReadFromBlackboard("LarvaPresentationPlayed", false) then
    Game.DisableTrigger("TG_Intro_MetroidSurface")
  else
    Game.SaturateSpawnGroup("SpawnGroup008")
  end
  if Scenario.ReadFromBlackboard("AlphaIntroPlayed", false) then
    Game.DisableTrigger("TG_Intro_Alpha")
  end
  -- if not Blackboard.GetProp("DEFEATED_ENEMIES", "Queen") or not (Blackboard.GetProp("DEFEATED_ENEMIES", "Queen") > 0) then
  Game.DisableEntity("LE_Queen_Door")
  -- else
  --   Game.SetSubAreaCurrentSetup("collision_camera_016", "PostQueen", true)
  --   Game.EnableEntity("LE_Queen_Door")
  -- end
  if Scenario.ReadFromBlackboard("MeleeReminderTutoPlayed", false) then
    Game.DisableTrigger("TG_StartMeleeReminderTuto")
    Game.DisableTrigger("TG_EndMeleeReminderTuto")
  end
  if not Game.GetFromGameBlackboardSection("PlayedCutscenes", "cutscenes/planetarrival/takes/10/planetarrival10.bmscu") then
    Game.AddEntityToUpdateInCutscene("LE_SamusShip")
    Game.SetPlayerInputEnabled(false, false)
    s000_surface.LaunchPlanetArrival()
  end
end
function s000_surface.OnReloaded()
end
function s000_surface.OnExit()
  GUI.ForceEndMeleeReminderTutorial()
end
function s000_surface.OnEnter_ActivationTeleport_00_01()
  Game.OnTeleportApproached("LE_Teleporter_00_01")
end
s000_surface.tDNAScanLandmarks = {
  SG_Alpha_001 = {
    "LM_ADNScanner_Samus_001",
    "LM_ADNScanner_Samus_002",
    "LM_ADNScanner_Samus_003",
    "LM_ADNScanner_Samus_004",
    "LM_ADNScanner_Samus_005",
    "LM_ADNScanner_Samus_006",
    "LM_ADNScanner_Samus_007",
    "LM_ADNScanner_Samus_008",
    "LM_ADNScanner_Samus_009",
    "LM_ADNScanner_Samus_010"
  }
}
function s000_surface.OnEndPlanetArrival()
  Game.SetPlayerInputEnabled(true, false)
  Game.RemoveEntityToUpdateInCutscene("LE_SamusShip")
  Game.HUDIdleScreenLeave()
end
function s000_surface.LaunchSpecialEnergyCutscene()
  Game.LaunchCutscene("cutscenes/scaningpulse/takes/01/scaningpulse01.bmscu")
  Game.ScanningPulseTutorialSE_A()
end
function s000_surface.OnStartSpecialEnergyCutscene()
  Game.AddEntityToUpdateInCutscene("TG_SpecialEnergyCloud")
end
function s000_surface.OnEndSpecialEnergyCutscene()
  Game.UpdateLegendSpecialEnergyBestowalStatue()
  guicallbacks.OnScanningPulsePickedUp()
end
function s000_surface.LaunchIntroTeleporterCutscene()
  -- Game.AddEntityToUpdateInCutscene("LE_Teleporter_00_01")
  -- Game.AddEntityToUpdateInCutscene("morphball")
  -- Game.AddEntityToUpdateInCutscene("Samus")
  -- Game.LaunchCutscene("cutscenes/introteleporter/takes/01/introteleporter01.bmscu")
end
function s000_surface.OnStartIntroTeleporterCutscene()
end
function s000_surface.OnEndIntroTeleporterCutscene()
  -- if Game.GetEntity("Samus") ~= nil then
  --   Game.GetEntity("Samus"):SetVisible(true)
  -- end
  -- Game.RemoveEntityToUpdateInCutscene("LE_Teleporter_00_01")
  -- Game.RemoveEntityToUpdateInCutscene("morphball")
  -- Game.RemoveEntityToUpdateInCutscene("Samus")
end
function s000_surface.LaunchIntroMetroidLarvaSurfacePresentation()
  Scenario.WriteToBlackboard("IntroMetroidLarvaSurfacePlayed", "b", true)
  Game.ForceConvertToSamus()
  Game.AddEntityToUpdateInCutscene("morphball")
  Game.AddEntityToUpdateInCutscene("Samus")
  Game.SetPlayerInputEnabled(false, false)
  Game.LaunchCutscene("cutscenes/intrometroidlarvasurface/takes/01/intrometroidlarvasurface01.bmscu")
  Game.SetSubAreaEnabled("collision_camera_010", true, true)
  Game.SetSubAreaLocked("collision_camera_010", true)
  Game.SetSceneGroupEnabledByName("sg_hornoadcorpse", false)
  Game.HUDAvailabilityGoOff(false, true, false, false)
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(true)
end
function s000_surface.OnStartMetroidRadarSlowBlinking()
  Game.MetroidRadarForceStateOnBegin(1, 0.1, true, false)
end
function s000_surface.OnEndMetroidRadarSlowBlinking()
  Game.MetroidRadarForceStateOnEnd(0, -1, true)
end
function s000_surface.IntroMetroidLarvaSurfacePresentationOnEnd()
  Game.SetSubAreaLocked("collision_camera_010", false)
  Game.SetSceneGroupEnabledByName("sg_hornoadcorpse", true)
  Game.RemoveEntityToUpdateInCutscene("morphball")
  Game.RemoveEntityToUpdateInCutscene("Samus")
  Game.SetPlayerInputEnabled(true, false)
  Game.DesaturateSpawnGroup("SpawnGroup008")
  Scenario.WriteToBlackboard("LarvaPresentationPlayed", "b", true)
  if not Blackboard.GetProp("GAME", "AMIIBO_MENU_UNLOCKED") then
    GUI.LaunchMessageSequence(1)
  else
    Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(false)
    Game.HUDAvailabilityGoOn()
  end
  Game.UnlockAmiiboMenu()
  Game.SaveGame("checkpoint", "AmiiboUnlocked", "ST_Checkpoint_AmiiboUnlocked", false)
end
function s000_surface.LaunchFirstTimeAlphaPresentation()
  s000_surface.OnAlphaPresentationCutsceneLaunch()
  -- Game.AddEntityToUpdateInCutscene("morphball")
  -- Game.AddEntityToUpdateInCutscene("Samus")
  -- Game.LaunchCutscene("cutscenes/introalpha/takes/01/introalpha01.bmscu")
  -- Game.SetPlayerInputEnabled(false, false)
end
function s000_surface.OnAlphaPresentationCutsceneLaunch()
  Game.MetroidRadarForceStateOnBegin(2, -1, true, true)
  Game.SetSceneGroupEnabledByName("sg_BrokenEggCinematic", false)
  if Game.GetEntity("SG_Alpha_001") ~= nil then
    Game.GetEntity("SG_Alpha_001").SPAWNGROUP:EnableSpawnGroup()
    Game.AddSF(0.5, "Game.MetroidRadarForceStateOnEnd", "")
    if Game.GetEntityFromSpawnPoint("SP_Alpha_001") ~= nil then
      -- Game.GetEntityFromSpawnPoint("SP_Alpha_001").AI:SetBossCamera(true)
      Game.StopEntitySound(Game.GetEntityFromSpawnPoint("SP_Alpha_001").sName, "actors/alpha/alpha_loop.wav", 0)
    end
  end
end
function s000_surface.OnAlphaPresentationCutsceneShowEgg()
  Game.SetSceneGroupEnabledByName("sg_BrokenEggCinematic", true)
end
function s000_surface.OnAlphaPresentationCutsceneLastTake()
  if Game.GetEntity("morphball") ~= nil then
    Game.SetPlayerInputEnabled(true, false)
    Game.ForceConvertToSamus()
    Game.SetPlayerInputEnabled(false, false)
  end
end
function s000_surface.OnAlphaPresentationCutsceneEnd()
  Game.SetPlayerInputEnabled(true, false)
  Game.RemoveEntityToUpdateInCutscene("morphball")
  Game.RemoveEntityToUpdateInCutscene("Samus")
  if Game.GetEntityFromSpawnPoint("SP_Alpha_001") ~= nil then
    Game.PlayEntityLoop("actors/alpha/alpha_loop.wav", Game.GetEntityFromSpawnPoint("SP_Alpha_001").sName, 0.5, 300, 1800, 1, false)
  end
  GUI.StartMeleeReminderTutorial()
end
function s000_surface.OnEnter_SetCheckpoint_001_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001", "ST_SG_Alpha_001_Out", "SG_Alpha_001", "", "")
end
function s000_surface.OnEnter_SetCheckpoint_002_Alpha_001()
  Game.SetBossCheckPointNames("ST_SG_Alpha_001B", "ST_SG_Alpha_001B", "SG_Alpha_001", "", "")
end
function s000_surface.OnAlpha_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_001")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door013")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Alpha001_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Alpha001_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Alpha001_Mines_001")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Alpha001_Idle")
  end
end
function s000_surface.OnEnter_Alpha_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_010", "PostAlpha_001", true)
    Game.DisableEntity("TG_Intro_Alpha")
  end
end
function s000_surface.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s000_surface.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s000_surface.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s000_surface.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s000_surface.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s000_surface.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s000_surface.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s000_surface.OnGullugg_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s000_surface.OnGullugg_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s000_surface.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s000_surface.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s000_surface.OnGullugg_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s000_surface.OnGullugg_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_014")
  end
end
function s000_surface.OnGullugg_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s000_surface.OnGullugg_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_016")
  end
end
function s000_surface.OnGullugg_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_017")
  end
end
function s000_surface.OnGullugg_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_018")
  end
end
function s000_surface.OnGullugg_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_019")
  end
end
function s000_surface.OnGullugg_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_020")
  end
end
function s000_surface.OnGullugg_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_021")
  end
end
function s000_surface.OnGullugg_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_022")
  end
end
function s000_surface.OnGullugg_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_023")
  end
end
function s000_surface.OnGullugg_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_024")
  end
end
function s000_surface.OnGullugg_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_025")
  end
end
function s000_surface.OnGullugg_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_026")
  end
end
function s000_surface.OnGravittBuried_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s000_surface.OnGullugg_B_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_012")
  end
end
function s000_surface.OnGullugg_B_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_013")
  end
end
function s000_surface.OnGullugg_B_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_014")
  end
end
function s000_surface.OnGullugg_B_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_015")
  end
end
function s000_surface.OnGullugg_B_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_016")
  end
end
function s000_surface.OnGullugg_B_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_017")
  end
end
function s000_surface.OnGullugg_B_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_018")
  end
end
function s000_surface.OnGullugg_B_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_019")
  end
end
function s000_surface.OnGullugg_B_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_020")
  end
end
function s000_surface.EnableHazarous(_ARG_0_, _ARG_1_)
  if _ARG_1_ then
    Game.DisableTrigger("TG_Camera_Teleporter_001")
  else
    Game.EnableTrigger("TG_Camera_Teleporter_001")
  end
end
function s000_surface.OnHazarousPoolDrain(_ARG_0_)
  Game.SetSubAreaCurrentSetup("collision_camera_004", "Hazarous_empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_005", "Hazarous_empty", true)
  Game.SetSubAreaCurrentSetup("collision_camera_006", "Hazarous_empty", true)
end
function s000_surface.OnEnterHazardous()
  PoisonZone.OnEnter()
  -- Game.SetSubAreaCurrentSetup("collision_camera_004", "Enter_Hazardous", true)
  -- Game.SetSubAreaCurrentSetup("collision_camera_005", "Enter_Hazardous", true)
end
function s000_surface.OnExitHazardous()
  PoisonZone.OnExit()
  -- Game.SetSubAreaCurrentSetup("collision_camera_004", "Default", false)
  -- Game.SetSubAreaCurrentSetup("collision_camera_005", "Default", false)
end
function s000_surface.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_2_ == "collision_camera_002" and Scenario.ReadFromBlackboard("MeleeTutoPlayed", false) and not Scenario.ReadFromBlackboard("MeleeReminderTutoPlayed", false) then
    GUI.StartMeleeReminderTutorial()
  elseif _ARG_0_ == "collision_camera_002" and _ARG_2_ == "collision_camera_016" and not Scenario.ReadFromBlackboard("MeleeReminderTutoPlayed", false) then
    GUI.EndMeleeReminderTutorial()
    Game.DelSF("s000_surface.ScheduledStartMeleeReminderTutorial")
    Game.DelSF("GUI.StartMeleeReminderTutorial")
  elseif (_ARG_0_ == "collision_camera_024" and not Scenario.ReadFromBlackboard("alpha_killed", false)) then
    s000_surface.LaunchFirstTimeAlphaPresentation()
  end
  if _ARG_2_ == "collision_camera_017" then
    Scenario.LoadNewScenario("s110_surfaceb", "ST_SurfaceB_Connector")
  end
  --if _ARG_0_ == "collision_camera_002" and _ARG_2_ == "collision_camera_003" and not Scenario.ReadFromBlackboard("FirstTimeChozoStatuePlayed", false) then
  --  s000_surface.LaunchFirstTimeChozoStatuePresentation()
  --elseif _ARG_0_ == "collision_camera_016" and _ARG_2_ == "collision_camera_002" and not Scenario.ReadFromBlackboard("MeleeTutoPlayed", false) then
  --  s000_surface.LaunchMeleeTutoCutscene()
  if _ARG_2_ == "collision_camera_004" and not Scenario.ReadFromBlackboard("FirstTimeDNAStatuePlayed", false) then
    s000_surface.LaunchFirstTimeDNAStatuePresentation()
  end
  --elseif _ARG_0_ == "collision_camera_014" and _ARG_2_ == "collision_camera_023" and not Scenario.ReadFromBlackboard("IntroMetroidLarvaSurfacePlayed", false) then
  --  s000_surface.LaunchIntroMetroidLarvaSurfacePresentation()
  --end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s000_surface.LaunchFirstTimeChozoStatuePresentation()
  Scenario.WriteToBlackboard("FirstTimeChozoStatuePlayed", "b", true)
  Game.LaunchCutscene("cutscenes/firstchozostatue/takes/01/firstchozostatue01.bmscu")
  if Game.GetEntity("TG_Intro_ChozoStatue") ~= nil then
    Game.GetEntity("TG_Intro_ChozoStatue").TRIGGER:DisableTrigger()
  end
end
function s000_surface.OnEnter_ChangeHazardousSetup()
  -- Game.SetSubAreaCurrentSetup("collision_camera_004", "Hazardous_CameraAlphaDead", true)
  -- Game.SetSubAreaCurrentSetup("collision_camera_005", "Hazardous_CameraAlphaDead", true)
end
function s000_surface.OnEnter_RestoreHazardousSetup()
  -- Game.SetSubAreaCurrentSetup("collision_camera_004", "Default", true)
  -- Game.SetSubAreaCurrentSetup("collision_camera_005", "Default", true)
end
function s000_surface.LaunchFirstTimeBestowalStatuePresentation()
  --Game.LaunchCutscene("cutscenes/introspenergystatue/takes/01/introspenergystatue01.bmscu")
end
function s000_surface.OnStartIntroSpecialEnergyStatue01()
  Game.AddEntityToUpdateInCutscene("TG_SpecialEnergyCloud")
end
function s000_surface.LaunchPlanetArrival()
  Game.AddGUISF(0.75, GUI.ForceIdleCinematicControlledOn, "")
  Game.LaunchCutscene("cutscenes/planetarrival/takes/10/planetarrival10.bmscu")
end
function s000_surface.OnSkipPlanetArrival()
  Game.StopMusic(false, "EVENT")
end
function s000_surface.LaunchFirstTimeDNAStatuePresentation()
  Scenario.WriteToBlackboard("FirstTimeDNAStatuePlayed", "b", true)
  -- Game.LaunchCutscene("cutscenes/introdnastatue/takes/01/introdnastatue01.bmscu")
  if Game.GetEntity("TG_Intro_DNAStatue") ~= nil then
    Game.GetEntity("TG_Intro_DNAStatue").TRIGGER:DisableTrigger()
  end
  Game.ActivateTotalMissileDrop(true)
end
function s000_surface.LaunchMeleeTutoCutscene()
  Scenario.WriteToBlackboard("MeleeTutoPlayed", "b", true)
  Game.AddEntityToUpdateInCutscene("Samus")
  Game.LaunchCutscene("cutscenes/meleetuto/takes/01/meleetuto01.bmscu")
  if Game.GetEntity("TG_MeleeTutoCutscene") ~= nil then
    Game.GetEntity("TG_MeleeTutoCutscene").TRIGGER:DisableTrigger()
  end
  Game.HUDAvailabilityGoOff(false, false, false, false)
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(true)
  Scenario.WriteToBlackboard("entity_tutorial_aiming_done", "b", true)
end
function s000_surface.OnDnaAbsorbAnimation()
  Game.SetInGameMusicState("DEATH")
  Scenario.WriteToBlackboard("alpha_killed", "b", true)
end
function s000_surface.OnMeleeTutoButtonPressed()
  Game.ChangeCutscene("cutscenes/meleetuto/takes/03/meleetuto03.bmscu")
end
function s000_surface.OnMeleeTutoCutsceneEnd()
  Game.RemoveEntityToUpdateInCutscene("Samus")
  Game.RemoveSpawnPointEntityToUpdateInCutscene("Gullugg_002")
  Game.OnMeleeTutorial("Gullugg_002")
  Game.HUDAvailabilityGoOn()
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(false)
  Game.AddSF(0.1, "s000_surface.ScheduledStartMeleeReminderTutorial", "")
end
function s000_surface.QTECutsceneLaunched()
  GUI.StartMeleeTutorial()
end
function s000_surface.QTECutsceneEnded()
  GUI.EndMeleeTutorial()
end
function s000_surface.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s000_surface.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s000_surface.OnEnter_ChangeCamera_003()
  Game.SetCollisionCameraLocked("collision_camera_003_B", true)
end
function s000_surface.OnExit_ChangeCamera_003()
  Game.SetCollisionCameraLocked("collision_camera_003_B", false)
end
function s000_surface.OnEnter_ChangeCamera_011()
  Game.SetCollisionCameraLocked("collision_camera_011_B", true)
end
function s000_surface.OnExit_ChangeCamera_011()
  Game.SetCollisionCameraLocked("collision_camera_011_B", false)
end
function s000_surface.OnStartMeleeReminderTutoTrigger()
  GUI.StartMeleeReminderTutorial()
  Game.DelSF("s000_surface.ScheduledStartMeleeReminderTutorial")
  Game.DelSF("GUI.StartMeleeReminderTutorial")
end
function s000_surface.ScheduledStartMeleeReminderTutorial()
  if Game.GetEntityFromSpawnPoint("Gullugg_002") ~= nil then
    if Game.GetEntityFromSpawnPoint("Gullugg_002").ANIMATION:HasTrack("Crazy") then
      Game.AddSF(0.1, "s000_surface.ScheduledStartMeleeReminderTutorial", "")
    elseif Game.GetEntityFromSpawnPoint("Gullugg_002").LIFE.fCurrentLife <= 0 then
      Game.AddSF(1.5, "GUI.StartMeleeReminderTutorial", "")
    else
      GUI.StartMeleeReminderTutorial()
    end
  else
    Game.AddSF(1.5, "GUI.StartMeleeReminderTutorial", "")
  end
end
function s000_surface.OnEndMeleeReminderTutoTrigger()
  GUI.EndMeleeReminderTutorial()
  Game.DelSF("s000_surface.ScheduledStartMeleeReminderTutorial")
  Game.DelSF("GUI.StartMeleeReminderTutorial")
  Game.DisableTrigger("TG_StartMeleeReminderTuto")
  Game.DisableTrigger("TG_EndMeleeReminderTuto")
  Scenario.WriteToBlackboard("MeleeReminderTutoPlayed", "b", true)
end
