Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
s110_surfaceb = {
  bAfterCredits = false,
  bInsideClouds = false,
  bFirstTimeCompleted = false
}
function s110_surfaceb.main()
  Scenario.InitGUI()
end
function s110_surfaceb.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_BABY_HATCHLING", "f", 1)
end
function s110_surfaceb.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s110_surfaceb.OnLE_Platform_Elevator_FromArea10(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s100_area10", "ST_FromAreaSurfaceB", _ARG_2_)
end
function s110_surfaceb.PreLE_Platform_Elevator_FromArea10()
  GUI.ElevatorSetTarget("s000_surface_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s110_surfaceb.ElevatorSetTarget(_ARG_0_)
  GUI.ElevatorSetTarget("s000_surface_elevator", false)
end
function s110_surfaceb.InitFromBlackboard()
  s110_surfaceb.SetLowModelsVisibility(false)
  if Game.GetItemAmount(Game.GetPlayerName(), "ITEM_ADN") < 39 and Game.GetItemAmount(Game.GetPlayerName(), "ITEM_BABY_HATCHLING") < 1 then
    Game.PlayMusicStream(0, "streams/music/t_m2_surface_arr1.wav", -1, -1, -1, 2, 2, 1)
end
end
function s110_surfaceb.OnReloaded()
end
function s110_surfaceb.OnLoaded(_ARG_0_, _ARG_1_)
  print("OnLoaded: " .. _ARG_0_ .. "," .. _ARG_1_)
  if _ARG_0_ == "c50_gui" and _ARG_1_ == "s020_credits" then
    s110_surfaceb.bFirstTimeCompleted = not Game.IsGameCompleted()
    Game.SaveGameComplete()
    s110_surfaceb.bAfterCredits = true
  end
  s110_surfaceb.InitializeRidleyStorms()
end
function s110_surfaceb.InitializeRidleyStorms()
  if Game.GetEntity("LE_RidleyStorm") ~= nil and Game.GetEntity("LE_RidleyStorm").CONTROLLER ~= nil then
    Game.GetEntity("LE_RidleyStorm").CONTROLLER:AddConstant("ridleystorm", "MP_FXMeshMtl00_1", 0, "Thunder0")
    Game.GetEntity("LE_RidleyStorm").CONTROLLER:AddConstant("ridleystorm", "MP_FXMeshMtl00_3", 0, "Thunder1")
    Game.GetEntity("LE_RidleyStorm").CONTROLLER:AddConstant("ridleystorm", "MP_FXMeshMtl00_11", 0, "Thunder2")
  end
  if Game.GetEntity("LE_PreRain") ~= nil and Game.GetEntity("LE_PreRain").CONTROLLER ~= nil then
    Game.GetEntity("LE_PreRain").CONTROLLER:AddConstant("ridleystormpre", "MP_FXMeshMtl00_1", 0, "PreThunder2")
    Game.GetEntity("LE_PreRain").CONTROLLER:AddConstant("ridleystormpre", "MP_FXMeshMtl00_3", 0, "PreThunder3")
    Game.GetEntity("LE_PreRain").CONTROLLER:AddLight("preray01")
  end
end
function s110_surfaceb.OnExit()
  s110_surfaceb.SetLowModelsVisibility(false)
end
function s110_surfaceb.RecoverEnergy()
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().LIFE.fCurrentLife = Game.GetPlayer().LIFE.fCurrentLife + 200
  end
end
function s110_surfaceb.OnEnter_ActivationTeleport_00b_01()
  Game.OnTeleportApproached("LE_Teleporter_00b_01")
end
function s110_surfaceb.OnRidleyStartPoint()
  Game.HUDIdleScreenLeave()
end
function s110_surfaceb.HideIngameEntitiesRidleyCutscene()
  Game.ForceConvertToSamus()
  if Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus"):SetVisible(false)
  end
  if Game.GetEntityFromSpawnPoint("SP_Ridley") ~= nil then
    Game.GetEntityFromSpawnPoint("SP_Ridley"):SetVisible(false)
  end
  if Game.GetEntity("Baby Hatchling") ~= nil then
    Game.GetEntity("Baby Hatchling"):SetVisible(false)
  end
end
function s110_surfaceb.OnRidley_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Ridley")
  end
end
function s110_surfaceb.OnPlayerDead(_ARG_0_)
  if Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus").MODELUPDATER:SetVertexLightsEnabled(false)
  end
  if Game.GetEntity("morphball") ~= nil then
    Game.GetEntity("morphball").MODELUPDATER:SetVertexLightsEnabled(false)
  end
  s110_surfaceb.SetLowModelsVisibility(false)
end
function s110_surfaceb.SetLowModelsVisibility(_ARG_0_)
  if _ARG_0_ and Game.GetEntity("Samus") ~= nil and Game.GetItemAmount(Game.GetPlayerName(), "ITEM_GRAVITY_SUIT") == 1 then
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Body_Ch", false)
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", true)
  elseif not _ARG_0_ and Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Body_Ch", true)
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", false)
  end
  if Game.GetEntityFromSpawnPoint("SP_Ridley") ~= nil then
    Game.GetEntityFromSpawnPoint("SP_Ridley").MODELUPDATER:SetMeshVisible("C01_Body_Ch", not _ARG_0_)
    Game.GetEntityFromSpawnPoint("SP_Ridley").MODELUPDATER:SetMeshVisible("C01_Wings_Ch", not _ARG_0_)
    Game.GetEntityFromSpawnPoint("SP_Ridley").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", _ARG_0_)
  end
end
function s110_surfaceb.OnEnter_SetCheckpoint_001_Ridley()
  Game.SetBossCheckPointNames("ST_SG_Ridley", "ST_SG_Ridley", "SG_Ridley", "", "")
end
function s110_surfaceb.LaunchRidleyIntro()
  Game.FadeOut(0.3)
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().INPUT:IgnoreInput(true, false)
    Game.GetPlayer().MOVEMENT:StartForcedAnalogInput(1, 0)
  end
  Game.AddSF(0.31, "s110_surfaceb.ScheduledTeleportRidleyIntro", "")
  if Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus").MODELUPDATER:SetVertexLightsEnabled(true)
  end
  if Game.GetEntity("morphball") ~= nil then
    Game.GetEntity("morphball").MODELUPDATER:SetVertexLightsEnabled(true)
  end
  s110_surfaceb.SetRidleyStormSoundEnabled(false)
end
function s110_surfaceb.PlayMusicOnSkip(_ARG_0_)
  Game.PlayMusicFromLoopStart(_ARG_0_)
end
function s110_surfaceb.OnRidley1Skip()
  s110_surfaceb.PlayMusicOnSkip("m_boss_ridley01")
end
function s110_surfaceb.OnRidley2Skip()
  Game.StopMusicWithFade(0.4, true)
  Game.AddSF(0.5, "s110_surfaceb.PlayMusicOnSkip", "s", "m_boss_ridley_second99")
end
function s110_surfaceb.OnRidley3Skip()
  Game.StopMusicWithFade(0.4, true)
  Game.AddSF(0.5, "s110_surfaceb.PlayMusicOnSkip", "s", "m_boss_ridley_third99")
end
function s110_surfaceb.ScheduledTeleportRidleyIntro()
  Game.LockSamusOnMinimap()
  if Game.GetEntity("SP_Ridley") ~= nil and Game.GetPlayer() ~= nil then
    Game.GetPlayer().vPos = Game.GetEntity("SP_Ridley").vPos
    Game.GetPlayer().MOVEMENT:StopForcedAnalogInput()
  end
  Game.AddSF(0, "s110_surfaceb.ScheduledLaunchRidleyIntro", "")
end
function s110_surfaceb.ScheduledLaunchRidleyIntro()
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().INPUT:IgnoreInput(false, true)
  end
  Game.LaunchCutscene("cutscenes/ridley1/takes/10/ridley110.bmscu")
end
function s110_surfaceb.OnStartRidleyIntro()
  s110_surfaceb.HideIngameEntitiesRidleyCutscene()
  Game.SetSceneGroupEnabledByName("sg_debris01", false)
  Game.SetSceneGroupEnabledByName("sg_debris02", false)
  Game.SetSceneGroupEnabledByName("sg_debris03", false)
  s110_surfaceb.AddLightToRidleyStorm("ray03")
  Game.AddEntityToUpdateInCutscene("LE_RidleyStorm")
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(false)
  end
  if Game.GetEntity("LE_RidleyClouds") ~= nil then
    Game.GetEntity("LE_RidleyClouds"):SetVisible(false)
  end
  Game.SetSceneGroupEnabledByName("sg_circus", true)
end
function s110_surfaceb.OnStartLastTakeRidleyIntro()
end
function s110_surfaceb.OnEndRidleyIntro()
  Game.UnlockSamusOnMinimap()
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(true)
  end
  if Game.GetEntity("LE_RidleyClouds") ~= nil then
    Game.GetEntity("LE_RidleyClouds"):SetVisible(true)
  end
  Game.SetSubAreaCurrentSetup("collision_camera_021", "RidleyCombat", true, true)
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  Game.SetScenarioItemEnabledByName("ray02", false)
  Game.SetScenarioItemEnabledByName("ray01", false)
  Game.SetScenarioItemEnabledByName("ray03", false)
  s110_surfaceb.RemoveLightFromRidleyStorm("ray03")
  Game.SetSceneGroupEnabledByName("sg_circus", false)
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().MOVEMENT:StopForcedAnalogInput()
  end
end
function s110_surfaceb.LaunchRidleyStage2Cutscene()
  Game.LaunchCutscene("cutscenes/ridley2/takes/10/ridley210.bmscu")
end
function s110_surfaceb.OnStartRidleyStage2()
  if Game.GetEntity("Baby Hatchling") ~= nil then
    Game.GetEntity("Baby Hatchling").MODELUPDATER:Unlink()
  end
  s110_surfaceb.AddLightToRidleyStorm("ray03")
  Game.SetScenarioItemEnabledByName("ray03", true)
  Game.AddEntityToUpdateInCutscene("LE_RidleyStorm")
  s110_surfaceb.HideIngameEntitiesRidleyCutscene()
  Game.SetSceneGroupEnabledByName("sg_circus", true)
  Game.PickUpAllDroppedItems(false)
end
function s110_surfaceb.OnBeforeEndRidleyStage2()
  if Game.GetEntity("Baby Hatchling") ~= nil then
    Game.GetEntity("Baby Hatchling"):SetVisible(true)
    Game.GetEntity("Baby Hatchling").ANIMATION:SetAction("ridleystage2", true)
  end
  Game.AddEntityToUpdateInCutscene("Baby Hatchling")
  Game.AddEntityToUpdateInCutscene("LE_SamusShip")
end
function s110_surfaceb.OnEndRidleyStage2()
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(true)
  end
  Game.RemoveEntityToUpdateInCutscene("Baby Hatchling")
  Game.RemoveEntityToUpdateInCutscene("LE_SamusShip")
  Game.SetSceneGroupEnabledByName("sg_circus", false)
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  s110_surfaceb.RemoveLightFromRidleyStorm("ray03")
  Game.SetScenarioItemEnabledByName("ray03", false)
  Game.SetScenarioItemEnabledByName("ray02", false)
  Game.SetScenarioItemEnabledByName("ray01", false)
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().LIFE:SetInvulnerableWithReaction(false)
  end
end
function s110_surfaceb.OnRidleyStage2HideShip()
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(false)
  end
end
function s110_surfaceb.OnRidleyStage2ShowShip()
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(true)
  end
end
function s110_surfaceb.LaunchRidleyStage3Cutscene()
  Game.LaunchCutscene("cutscenes/ridley3/takes/10/ridley310.bmscu")
end
function s110_surfaceb.OnStartRidleyStage3()
  s110_surfaceb.HideIngameEntitiesRidleyCutscene()
  Game.SetSceneGroupEnabledByName("sg_circus", true)
  s110_surfaceb.AddLightToRidleyStorm("ray03")
  Game.SetScenarioItemEnabledByName("ray03", true)
  Game.AddEntityToUpdateInCutscene("LE_RidleyStorm")
  Game.PickUpAllDroppedItems(false)
end
function s110_surfaceb.OnEndRidleyStage3()
  Game.SetSceneGroupEnabledByName("sg_circus", false)
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  s110_surfaceb.RemoveLightFromRidleyStorm("ray03")
  Game.SetScenarioItemEnabledByName("ray03", false)
  Game.SetScenarioItemEnabledByName("ray02", false)
  Game.AddSF(0.3, "s110_surfaceb.RecoverEnergy", "")
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().LIFE:SetInvulnerableWithReaction(false)
  end
end
function s110_surfaceb.LaunchRidleyDeadCutscene()
  GUI.ForceIdleCinematicControlledOn()
  Game.LaunchCutscene("cutscenes/ridley4/takes/10/ridley410.bmscu")
  s110_surfaceb.SetLowModelsVisibility(false)
end
function s110_surfaceb.OnStartRidleyDead()
  Game.AddEntityToUpdateInCutscene("LE_RidleyStorm")
  s110_surfaceb.AddLightToRidleyStorm("ray03")
  Game.SetScenarioItemEnabledByName("ray03", true)
  s110_surfaceb.HideIngameEntitiesRidleyCutscene()
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(false)
  end
end
function s110_surfaceb.OnEndRidleyDead()
  Game.SetScenarioItemEnabledByName("ray02", false)
  Game.SetScenarioItemEnabledByName("ray01", false)
  Game.SetScenarioItemEnabledByName("false", true)
  s110_surfaceb.RemoveLightFromRidleyStorm("ray03")
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().LIFE:SetInvulnerableWithReaction(false)
  end
  Game.SetSubAreaEnvironmentLocked(false, true, true)
  Game.SetSubAreaCurrentSetup("collision_camera_021", "PostCredits", true, true)
end
function s110_surfaceb.AddLightToRidleyStorm(_ARG_0_)
  Game.SetScenarioItemEnabledByName(_ARG_0_, true)
  if Game.GetEntity("LE_RidleyStorm") ~= nil and Game.GetEntity("LE_RidleyStorm").CONTROLLER ~= nil then
    Game.GetEntity("LE_RidleyStorm").CONTROLLER:AddLight(_ARG_0_)
  end
end
function s110_surfaceb.RemoveLightFromRidleyStorm(_ARG_0_)
  Game.SetScenarioItemEnabledByName(_ARG_0_, false)
  if Game.GetEntity("LE_RidleyStorm") ~= nil and Game.GetEntity("LE_RidleyStorm").CONTROLLER ~= nil then
    Game.GetEntity("LE_RidleyStorm").CONTROLLER:RemoveLight(_ARG_0_)
  end
end
function s110_surfaceb.LaunchCredits()
  Game.ShowEndGameCredits(true)
end
function s110_surfaceb.SetRidleyStormEnabled(_ARG_0_)
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  if Game.GetEntity("LE_RidleyStorm") ~= nil then
    if _ARG_0_ then
      Game.GetEntity("LE_RidleyStorm"):Enable()
    else
      Game.GetEntity("LE_RidleyStorm"):Disable()
    end
  end
end
function s110_surfaceb.SetRidleyStormSoundEnabled(_ARG_0_)
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  if Game.GetEntity("LE_RidleyStorm") ~= nil and Game.GetEntity("LE_RidleyStorm").CONTROLLER ~= nil then
    Game.GetEntity("LE_RidleyStorm").CONTROLLER:SetSoundEnabled(_ARG_0_)
  end
end
function s110_surfaceb.LaunchPostCreditsCutscene()
  Game.HideScenarioItemByName("ridleystorm", true)
  Game.HideScenarioItemByName("animstormdebris", true)
  Game.HideScenarioItemByName("animstormhurricane", true)
  Game.HideScenarioItemByName("storm002", true)
  Game.HideScenarioItemByName("ridleystorm", true)
  Game.HideScenarioItemByName("storm01", true)
  Game.SetSceneGroupEnabledByName("sg_debris01", false)
  Game.SetSceneGroupEnabledByName("sg_debris02", false)
  Game.SetSceneGroupEnabledByName("sg_debris03", false)
  Game.SetSceneGroupEnabledByName("sg_hurricane", false)
  Game.SetScenarioItemEnabledByName("ray02", false)
  Game.SetScenarioItemEnabledByName("ray01", false)
  Game.SetScenarioItemEnabledByName("ray03", false)
  Game.RemoveEntityToUpdateInCutscene("LE_RidleyStorm")
  if Game.GetEntity("LE_SamusShip") ~= nil then
    Game.GetEntity("LE_SamusShip"):SetVisible(false)
  end
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer():Disable()
  end
  s110_surfaceb.HideIngameEntitiesRidleyCutscene()
  s110_surfaceb.SetRidleyStormEnabled(false)
  if Game.GetGameCompletedOnRidleyDead() then
    GUI.ForceIdleCinematicControlledOn()
  end
  Game.LaunchCutscene("cutscenes/postcredits/takes/10/postcredits10.bmscu")
end
function s110_surfaceb.OnEndPostCreditsCutscene()
  GUI.ForceIdleCinematicControlledOff()
end
function s110_surfaceb.OnRidleyPresetChange(_ARG_0_, _ARG_1_)
  if _ARG_1_ == 1 then
    s110_surfaceb.LaunchRidleyStage2Cutscene()
  elseif _ARG_1_ == 2 then
    s110_surfaceb.LaunchRidleyStage3Cutscene()
  end
end
function s110_surfaceb.OnRidleyDead(_ARG_0_)
  Game.SetGameCompletedOnRidleyDead(Game.IsGameCompleted())
  if Game.GetEntityFromSpawnPoint("SP_Ridley") ~= nil then
    Game.GetEntityFromSpawnPoint("SP_Ridley"):DelMe()
  end
  if Game.GetEntity("SG_Ridley") ~= nil then
    Game.GetEntity("SG_Ridley").SPAWNGROUP:DisableSpawnGroup()
  end
  Game.SetSubAreaLocked("collision_camera_021", false)
  Game.SetSubAreaCurrentSetup("collision_camera_021", "AfterRidley", true, true)
end
function s110_surfaceb.OnRidleyDeathCamera()
  Game.HUDIdleScreenGo()
end
function s110_surfaceb.LaunchRidleyDrainedALeft()
  Game.LaunchCutscene("cutscenes/ridleydrained/takes/01/ridleydrained01.bmscu")
  Game.SetSceneGroupEnabledByName("sg_circus", true)
end
function s110_surfaceb.LaunchRidleyDrainedARight()
  Game.LaunchCutscene("cutscenes/ridleydrained/takes/02/ridleydrained02.bmscu")
  Game.SetSceneGroupEnabledByName("sg_circus", true)
end
function s110_surfaceb.LaunchRidleyDrainedBLeft()
  Game.LaunchCutscene("cutscenes/ridleydrained/takes/03/ridleydrained03.bmscu")
  Game.SetSceneGroupEnabledByName("sg_circus", true)
end
function s110_surfaceb.LaunchRidleyDrainedBRight()
  Game.LaunchCutscene("cutscenes/ridleydrained/takes/04/ridleydrained04.bmscu")
  Game.SetSceneGroupEnabledByName("sg_circus", true)
end
function s110_surfaceb.OnEndDrainedCutscene()
  Game.SetSceneGroupEnabledByName("sg_circus", false)
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().LIFE:SetInvulnerableWithReaction(false)
  end
end
function s110_surfaceb.OnStartRidleyTake20()
  Game.HideScenarioItemByName("storm002", true)
  Game.HideScenarioItemByName("surfacemodel01_015", true)
end
function s110_surfaceb.OnEndRidleyTake20()
  Game.HideScenarioItemByName("storm002", false)
  Game.HideScenarioItemByName("surfacemodel01_015", false)
end
function s110_surfaceb.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s110_surfaceb.OnGullugg_B_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_001")
  end
end
function s110_surfaceb.OnGullugg_B_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_002")
  end
end
function s110_surfaceb.OnGullugg_B_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_003")
  end
end
function s110_surfaceb.OnGullugg_B_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_004")
  end
end
function s110_surfaceb.OnGullugg_B_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_005")
  end
end
function s110_surfaceb.OnGullugg_B_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_006")
  end
end
function s110_surfaceb.OnGullugg_B_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_007")
  end
end
function s110_surfaceb.OnGullugg_B_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_008")
  end
end
function s110_surfaceb.OnGullugg_B_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_009")
  end
end
function s110_surfaceb.OnGullugg_B_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_010")
  end
end
function s110_surfaceb.OnGullugg_B_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_011")
  end
end
function s110_surfaceb.OnGullugg_B_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_012")
  end
end
function s110_surfaceb.OnGullugg_B_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_013")
  end
end
function s110_surfaceb.OnGullugg_B_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_014")
  end
end
function s110_surfaceb.OnGullugg_B_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_015")
  end
end
function s110_surfaceb.OnGullugg_B_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_016")
  end
end
function s110_surfaceb.OnGullugg_B_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_017")
  end
end
function s110_surfaceb.OnGullugg_B_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_018")
  end
end
function s110_surfaceb.OnGullugg_B_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_B_019")
  end
end
function s110_surfaceb.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s110_surfaceb.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s110_surfaceb.ResetRaysMaterialAnimation()
  Game.HideScenarioItemByName("ridleystorm", true, true)
  Game.HideScenarioItemByName("storm01", true, true)
  Game.HideScenarioItemByName("ridleystorm", false, true)
  Game.HideScenarioItemByName("storm01", false, true)
end
function s110_surfaceb.ShowRays()
  Game.HideScenarioItemByName("ridleystorm", false, false)
  Game.HideScenarioItemByName("storm01", false, false)
end
function s110_surfaceb.HideRays()
  Game.HideScenarioItemByName("ridleystorm", true, false)
  Game.HideScenarioItemByName("storm01", true, false)
end
function s110_surfaceb.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  Game.SetScenarioItemEnabledByName("ray02", false)
  Game.SetScenarioItemEnabledByName("ray01", false)
  Game.SetSceneGroupEnabledByName("sg_debris02", false)
  Game.SetSceneGroupEnabledByName("sg_debris03", false)
  if _ARG_2_ == "collision_camera_000" and Game.GetItemAmount(Game.GetPlayerName(), "ITEM_ADN") < 39 then
    Scenario.LoadNewScenario("s000_surface", "ST_Surface_Connector")
  end
  if _ARG_2_ == "collision_camera_021" and _ARG_0_ == "collision_camera_021" and _ARG_3_ == "RidleyCombat" then
    if Game.GetEntity("SG_Ridley") ~= nil then
      Game.GetEntity("SG_Ridley").SPAWNGROUP:EnableSpawnGroup()
      if Game.GetEntityFromSpawnPoint("SP_Ridley") ~= nil then
        Game.GetEntityFromSpawnPoint("SP_Ridley").AI:SetBossCamera(true)
      end
      if Game.GetEntity("Baby Hatchling") ~= nil and Game.GetEntityFromSpawnPoint("SP_Ridley") ~= nil then
        Game.GetEntity("Baby Hatchling").MODELUPDATER:LinkTo(Game.GetEntityFromSpawnPoint("SP_Ridley").sName, "L01_Hand_SKN", false, 100, 0, -45, 1.57, -0.7, 0)
      end
    end
    s110_surfaceb.SetLowModelsVisibility(true)
  end
  if _ARG_2_ == "collision_camera_021" and _ARG_0_ == "collision_camera_021" and _ARG_3_ == "AfterRidley" then
    s110_surfaceb.LaunchRidleyDeadCutscene()
  end
  if _ARG_0_ == "collision_camera_021" and _ARG_2_ == "collision_camera_021" and _ARG_3_ == "PostCredits" then
    if not Game.IsCreditsDisabled() then
      if not s110_surfaceb.bAfterCredits then
        s110_surfaceb.LaunchCredits()
      end
    else
      s110_surfaceb.bFirstTimeCompleted = not Game.IsGameCompleted()
      Game.SaveGameComplete()
      s110_surfaceb.LaunchPostCreditsCutscene()
      s110_surfaceb.bAfterCredits = false
    end
    s110_surfaceb.HideRays()
  else
    s110_surfaceb.ShowRays()
  end
  if _ARG_0_ == "" and _ARG_2_ == "collision_camera_021" and _ARG_3_ == "PostCredits" then
    s110_surfaceb.LaunchPostCreditsCutscene()
    s110_surfaceb.bAfterCredits = false
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s110_surfaceb.OnPostCreditsEnd()
  if s110_surfaceb.bFirstTimeCompleted then
    Game.StopEnvironmentSound()
    Game.AddGUISF(2.5, GUI.MainMenuGoToState, "i", 28)
  else
    Game.GoToMainMenu()
  end
end
