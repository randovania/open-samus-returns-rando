Game.ImportLibrary("actors/props/damageplants/scripts/damageplants.lua", false)
Game.ImportLibrary("actors/props/heatzone/scripts/heatzone.lua", false)
Game.ImportLibrary("actors/props/poisonzone/scripts/poisonzone.lua", false)
Game.ImportLibrary("actors/props/waterzone/scripts/waterzone.lua", false)
function s100_area10.main()
  Scenario.InitGUI()
end
function s100_area10.SetupDebugGameBlackboard()
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
function s100_area10.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s100_area10.OnLE_Platform_Elevator_FromArea09(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s090_area9", "ST_FromArea10", _ARG_2_)
end
function s100_area10.OnLE_Platform_Elevator_FromAreaSurfaceB(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", "s110_surfaceb", "ST_FromArea10", _ARG_2_)
end
function s100_area10.PreLE_Platform_Elevator_FromArea09()
  GUI.ElevatorSetTarget("s100_area10_elevator", true)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s100_area10.PreLE_Platform_Elevator_FromAreaSurfaceB()
  GUI.ElevatorSetTarget("s000_surface_elevator", false)
  GUI.ElevatorStartUseActionStep1InterArea()
end
function s100_area10.ElevatorSetTarget(_ARG_0_)
  if _ARG_0_ == "ST_FromArea09" then
    GUI.ElevatorSetTarget("s100_area10_elevator", false)
  elseif _ARG_0_ == "ST_FromAreaSurfaceB" then
    GUI.ElevatorSetTarget("s000_surface_elevator", true)
  end
end
s100_area10.iNumMetroids = 10
s100_area10.iMetroidTotalCountIncrements = 0
function s100_area10.TestMetroidCount()
  Game.GetPlayer().INVENTORY:SetItemAmount("ITEM_METROID_COUNT", 39, true)
  Game.IncrementMetroidTotalCount(0)
  Game.GetPlayer().vPos = V3D(-4459.72, 10426.6, 0)
end
function s100_area10.InitFromBlackboard()
  Scenario.WriteToBlackboard("firstTimeMetroidHatchlingIntroPlayed", "b", true)
  Game.DisableEntity("LE_Baby_Hatchling")
  Game.DisableTrigger("TG_MetroidRadar")
  Game.GetEntity("LE_RandoDNA").USABLE:Activate(false)
  s100_area10.SetLowModelsVisibility(false)
  if Game.GetEntity("LE_ValveQueen") ~= nil then
    if Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") ~= nil and s100_area10.iNumMetroids == Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") then
      Game.GetEntity("LE_ValveQueen").MODELUPDATER:SetMeshVisible("Valve", false)
      Game.GetEntity("LE_ValveQueen").MODELUPDATER:SetMeshVisible("Valve_Break", true)
      Game.GetEntity("LE_ValveQueen").COLLISION.bEnabled = false
    else
      Game.GetEntity("LE_ValveQueen").MODELUPDATER:SetMeshVisible("Valve", true)
      Game.GetEntity("LE_ValveQueen").MODELUPDATER:SetMeshVisible("Valve_Break", false)
    end
  end
  if Scenario.ReadFromBlackboard("QueenDiscovered", false) and not Scenario.ReadFromBlackboard("QueenRoarLaunched", false) then
    Game.AddSF(1, "s100_area10.ScheduledQueenRoar", "")
  end
  if Game.GetEntity("LE_Event_1001") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent1001Launched") then
    Game.GetEntity("LE_Event_1001"):Disable()
  end
  if Game.GetEntity("LE_Event_1002") ~= nil and Scenario.ReadFromBlackboard("SpecialEvent1002Launched") then
    Game.GetEntity("LE_Event_1002"):Disable()
  end
end
function s100_area10.OnReloaded()
end
function s100_area10.OnExit()
  s100_area10.SetLowModelsVisibility(false)
end
function s100_area10.OnEnter_ActivationTeleport_10_01()
  Game.OnTeleportApproached("LE_Teleporter_10_01")
end
function s100_area10.OnEnter_ActivationTeleport_10_02()
  Game.OnTeleportApproached("LE_Teleporter_10_02")
end
function s100_area10.OnLarva_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_001")
    _ARG_1_.AI:AddDoorToLock("Door010")
    _ARG_1_.AI:AddDoorToLock("Door011")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_001")
  end
end
function s100_area10.OnLarva_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_002")
    _ARG_1_.AI:AddDoorToLock("Door011")
    _ARG_1_.AI:AddDoorToLock("Door012")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_002")
  end
end
function s100_area10.OnLarva_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_003")
    _ARG_1_.AI:AddDoorToLock("Door012")
    _ARG_1_.AI:AddDoorToLock("Door013")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_003")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_004")
  end
end
function s100_area10.OnLarva_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_004")
    _ARG_1_.AI:AddDoorToLock("Door012")
    -- _ARG_1_.AI:AddDoorToLock("Door013")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_003")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_004")
  end
end
function s100_area10.OnLarva_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_005")
    _ARG_1_.AI:AddDoorToLock("Door013")
    _ARG_1_.AI:AddDoorToLock("Door014")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_005")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_006")
  end
end
function s100_area10.OnLarva_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_006")
    _ARG_1_.AI:AddDoorToLock("Door013")
    _ARG_1_.AI:AddDoorToLock("Door014")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_005")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_006")
  end
end
function s100_area10.OnLarva_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_007")
    _ARG_1_.AI:AddDoorToLock("Door015")
    _ARG_1_.AI:AddDoorToLock("Door016")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_007")
  end
end
function s100_area10.OnLarva_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_008")
    _ARG_1_.AI:AddDoorToLock("Door016")
    _ARG_1_.AI:AddDoorToLock("Door017")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_008")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_009")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_010")
  end
end
function s100_area10.OnLarva_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_009")
    _ARG_1_.AI:AddDoorToLock("Door016")
    _ARG_1_.AI:AddDoorToLock("Door017")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_008")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_009")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_010")
  end
end
function s100_area10.OnLarva_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Larva_010")
    _ARG_1_.AI:AddDoorToLock("Door016")
    _ARG_1_.AI:AddDoorToLock("Door017")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_008")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_009")
    _ARG_1_.AI:AddSpawnPointToUnlock("Larva_010")
  end
end
function s100_area10.OnMetroidDead()
  -- Disable the intro and the camera change triggers if a Metroid has been defeated, which means that Reverse Area 8 should be enabled
  Game.DisableTrigger("TG_Intro_Larva")
  -- If going backwards, increment the Metroid counter on the first Metroid death only
  if Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") == 1 and s100_area10.iMetroidTotalCountIncrements == 0 then
    Game.AddSF(0.15, "s100_area10.IncrementMetroidTotalCount", "")
  end
  if Game.GetEntity("TG_ChangeCamera_IntroLarva") ~= nil then
    Game.GetEntity("TG_ChangeCamera_IntroLarva").TRIGGER:DisableTrigger()
  end
  if Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") ~= nil and s100_area10.iNumMetroids == Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") then
    if Game.GetEntity("LE_ValveQueen") ~= nil then
      Game.GetEntity("LE_ValveQueen").MODELUPDATER:SetMeshVisible("Valve", false)
      Game.GetEntity("LE_ValveQueen").MODELUPDATER:SetMeshVisible("Valve_Break", true)
      Game.GetEntity("LE_ValveQueen").COLLISION.bEnabled = false
    end
    Scenario.WriteToBlackboard("QueenDiscovered", "b", true)
    Game.AddSF(3.5, "s100_area10.ScheduledQueenRoar", "")
    for _FORV_6_, _FORV_7_ in pairs({
      "collision_camera_013",
      "collision_camera_014",
      "collision_camera_015",
      "collision_camera_016",
      "collision_camera_017",
      "collision_camera_019"
    }) do
      print(_FORV_7_)
      Game.SetSubAreaCurrentSetup(_FORV_7_, "PostMetroids_001", true)
    end
    for _FORV_7_, _FORV_8_ in pairs({
      "SpawnGroup029",
      "SpawnGroup030",
      "SpawnGroup031",
      "SpawnGroup032",
      "SpawnGroup033",
      "SpawnGroup070"
    }) do
      print(_FORV_8_)
      if Game.GetEntity(_FORV_8_) ~= nil then
        Game.GetEntity(_FORV_8_).SPAWNGROUP:EnableSpawnGroup()
      end
    end
    Game.SaveGame("checkpoint", "Checkpoint_LarvasOut", "ST_SG_Larva_010", true)
  end
end
function s100_area10.OnEnter_AllMetroids_Dead()
  if Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") ~= nil and s100_area10.iNumMetroids == Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") then
    Game.SetSubAreaCurrentSetup("collision_camera_018", "PostMetroids_001", true)
    for _FORV_5_, _FORV_6_ in pairs({
      "SpawnGroup035",
      "SpawnGroup036"
    }) do
      print(_FORV_6_)
      if Game.GetEntity(_FORV_6_) ~= nil then
        Game.GetEntity(_FORV_6_).SPAWNGROUP:EnableSpawnGroup()
      end
    end
  end
end
function s100_area10.ScheduledQueenRoar()
  if Game.GetPlayer() ~= nil and Game.GetPlayer().INPUT.bInputIgnored then
    Game.AddSF(0.1, "s100_area10.ScheduledQueenRoar", "")
  else
    Game.PlayCameraFXPreset("QUEEN_SPAWN")
    Game.PlayMusicStream(1, "streams/maps/queen_eventroar.wav", -1, -1, 0, 0, 0, 0)
    Scenario.WriteToBlackboard("QueenRoarLaunched", "b", true)
  end
end
s100_area10.fSafeFarPlaneFactor = -1
function s100_area10.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if Blackboard.GetProp("DEFEATED_ENEMIES", "Queen") ~= nil then
    Game.SetSceneGroupEnabledByName("sg_egg01", false)
    Game.SetSceneGroupEnabledByName("sg_egg02", true)
    Game.EnableEntity("LE_Baby_Hatchling")
    Game.GetEntity("LE_RandoDNA").USABLE:Activate(true)
  end
  if _ARG_2_ == "collision_camera_020" then
    s100_area10.fSafeFarPlaneFactor = Game.GetSafeFarPlaneFactor()
    Game.SetSafeFarPlaneFactor(-1)
  elseif _ARG_0_ == "collision_camera_020" then
    Game.SetSafeFarPlaneFactor(s100_area10.fSafeFarPlaneFactor)
  end
  if _ARG_0_ == "collision_camera_020" and _ARG_2_ == "collision_camera_022" then
    s100_area10.OnBabyCreationCutsceneTrigger()
  elseif _ARG_0_ == "collision_camera_019" and _ARG_2_ == "collision_camera_020" and Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") ~= nil and s100_area10.iNumMetroids == Blackboard.GetProp("DEFEATED_ENEMIES", "Metroid") then
    s100_area10.LaunchQueenIntro()
  end
  Game.BossCheckPointManagerForceUnlockDoors()
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s100_area10.OnPlayerDead(_ARG_0_)
  s100_area10.SetLowModelsVisibility(false)
end
function s100_area10.SetLowModelsVisibility(_ARG_0_)
  if _ARG_0_ and Game.GetEntity("Samus") ~= nil and Game.GetItemAmount(Game.GetPlayerName(), "ITEM_GRAVITY_SUIT") == 1 then
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Body_Ch", false)
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", true)
  elseif not _ARG_0_ and Game.GetEntity("Samus") ~= nil then
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Body_Ch", true)
    Game.GetEntity("Samus").MODELUPDATER:SetMeshVisible("C01_Combat_Ch", false)
  end
  if Game.GetEntityFromSpawnPoint("SP_Queen") ~= nil then
    Game.GetEntityFromSpawnPoint("SP_Queen").MODELUPDATER:SetMeshVisible("C01_Head_Ch", not _ARG_0_)
    Game.GetEntityFromSpawnPoint("SP_Queen").MODELUPDATER:SetMeshVisible("C01_Headcombat_Ch", _ARG_0_)
  end
end
function s100_area10.LaunchQueenIntro()
  if not Scenario.ReadFromBlackboard("IntroQueenPlayed", false) then
    Game.LaunchCutscene("cutscenes/introqueen/takes/01/introqueen01.bmscu")
    Scenario.WriteToBlackboard("IntroQueenPlayed", "b", true)
  end
  Game.MetroidRadarForceStateOnBegin(2, -1, true, true)
  s100_area10.SetLowModelsVisibility(true)
end
s100_area10.sg_vignette_01_visible = false
function s100_area10.OnStartIntroQueenCutscene()
  if Game.GetEntity("SG_Queen") ~= nil then
    Game.GetEntity("SG_Queen").SPAWNGROUP:EnableSpawnGroup()
    if Game.GetEntityFromSpawnPoint("SP_Queen") ~= nil then
      Game.GetEntityFromSpawnPoint("SP_Queen"):SetVisible(false)
      Game.GetEntityFromSpawnPoint("SP_Queen").AI:SetBossCamera(true)
      Game.GetEntityFromSpawnPoint("SP_Queen").AI:ResetTileGroup(20)
      Game.GetEntityFromSpawnPoint("SP_Queen").AI:ResetTileGroup(22)
      Game.GetEntityFromSpawnPoint("SP_Queen").AI:ResetTileGroup(25)
    end
  end
  Game.SetSceneGroupEnabledByName("sg_vignette_20", false)
  Game.SetSceneGroupEnabledByName("sg_vignette_09", false)
  s100_area10.sg_vignette_01_visible = Game.GetSceneGroupEnabledByName("sg_vignette_01")
  if s100_area10.sg_vignette_01_visible then
    Game.SetSceneGroupEnabledByName("sg_vignette_01", false)
  end
end
function s100_area10.OnEndIntroQueenCutscene()
  Game.AddSF(1, "Game.MetroidRadarForceStateOnEnd", "")
  Game.SetSceneGroupEnabledByName("sg_vignette_20", true)
  Game.SetSceneGroupEnabledByName("sg_vignette_09", true)
  if s100_area10.sg_vignette_01_visible then
    Game.SetSceneGroupEnabledByName("sg_vignette_01", true)
  end
  Game.SetSubAreaCurrentSetup("collision_camera_020", "CombatQueen", true)
end
function s100_area10.LaunchQueenSpitCutscene()
  Game.LaunchCutscene("cutscenes/metroidqueenspit/takes/01/metroidqueenspit01.bmscu")
end
function s100_area10.LaunchQueenSpitPowerBombCutscene()
  Game.LaunchCutscene("cutscenes/metroidqueenspitpowerbomb/takes/01/metroidqueenspitpowerbomb01.bmscu")
end
function s100_area10.OnEnter_SetCheckpoint_001_Queen()
  Game.SetBossCheckPointNames("ST_SG_Queen", "ST_SG_Queen_Out", "SG_Queen", "", "")
end
function s100_area10.OnQueenGenerated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Queen")
    _ARG_1_.AI:SetBossCamera(true)
  end
end
function s100_area10.OnQueenDead(_ARG_0_)
  Blackboard.SetProp("DEFEATED_ENEMIES", "Queen", "i", 1)
  Game.SetSubAreaCurrentSetup("collision_camera_020", "PostMetroids_001", true)
  Game.LaunchCutscene("cutscenes/metroidqueendeath/takes/01/metroidqueendeath01.bmscu")
  s100_area10.SetLowModelsVisibility(false)
end
function s100_area10.OnStartQueenDeathCutscene()
  Game.ForceConvertToSamus()
  Game.SetSceneGroupEnabledByName("sg_vignette_20", false)
  Game.SetSceneGroupEnabledByName("sg_vignette_09", false)
  s100_area10.sg_vignette_01_visible = Game.GetSceneGroupEnabledByName("sg_vignette_01")
  if s100_area10.sg_vignette_01_visible then
    Game.SetSceneGroupEnabledByName("sg_vignette_01", false)
  end
end
function s100_area10.OnEndQueenDeathCutscene()
  if Game.GetPlayer() ~= nil then
    Game.GetPlayer().LIFE:SetInvulnerableWithReaction(false)
  end
  Game.EnableTrigger("TG_BabyCreation")
  Game.SetSceneGroupEnabledByName("sg_vignette_20", true)
  Game.SetSceneGroupEnabledByName("sg_vignette_09", true)
  if s100_area10.sg_vignette_01_visible then
    Game.SetSceneGroupEnabledByName("sg_vignette_01", true)
  end
  Game.SetBreakableTileWeaponHitLocked(false)
  Game.SaveGame("checkpoint", "Checkpoint_AfterQueen", "ST_Queen_001_Checkpoint", true)
end
function s100_area10.OnBabyCreationCutsceneTrigger()
  if not Scenario.ReadFromBlackboard("firstTimeMetroidHatchlingIntroPlayed", false) then
  --   Game.LaunchCutscene("cutscenes/metroidhatchlingintro/takes/01/metroidhatchlingintro01.bmscu")
    if Game.GetEntity("TG_Intro_BabyHatchling") ~= nil then
      Game.SetSubAreasPreferredTransitionType("None")
      Game.GetEntity("TG_Intro_BabyHatchling").TRIGGER:DisableTrigger()
    end
  end
end
function s100_area10.OnMetroidHatchlingIntroCutsceneLaunch()
  -- if Scenario.ReadFromBlackboard("firstTimeMetroidHatchlingIntroPlayed", true) then
  -- if Game.GetDefaultPlayer() ~= nil then
  --   Game.GetDefaultPlayer().BABYHATCHLINGCREATION:SpawnBaby()
  --   Game.GetDefaultPlayer().GUN:SelectGun("IceBeam", true)
  -- end
    -- Game.SetSceneGroupEnabledByName("sg_egg01", false)
    -- Game.SetSceneGroupEnabledByName("sg_egg02", false)
  -- end
end
function s100_area10.OnMetroidHatchlingIntroCutsceneLastTake()
  Game.SetSceneGroupEnabledByName("sg_egg02", true)
  Game.SetSubAreaCurrentSetup("collision_camera_022", "PostMetroids_001", true)
end
function s100_area10.OnMetroidHatchlingIntroCutsceneEnd()
  Game.SetSubAreaCurrentSetup("collision_camera_020", "PostBabyHatchling", true)
  if Game.GetEntity("TG_ChangeEggMetroid") ~= nil then
    Game.GetEntity("TG_ChangeEggMetroid").TRIGGER:EnableTrigger()
  end
end
function s100_area10.OnEnter_ChangeEgg()
  if Scenario.ReadFromBlackboard("firstTimeMetroidHatchlingIntroPlayed", false) then
    Game.SetSceneGroupEnabledByName("sg_egg01", false)
    Game.SetSceneGroupEnabledByName("sg_egg02", true)
  end
end
function s100_area10.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s100_area10.OnGenericGlowfly_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("bPlatform", true)
    _ARG_1_.AI:AddBlackboardParam("sMode", "ROUTE")
  end
end
function s100_area10.OnBeeSwarm_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_001_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_001_002")
  end
end
function s100_area10.OnBeeSwarm_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.CONTROLLER ~= nil then
    _ARG_1_.CONTROLLER:AddLogicPath("BeeSwarmPath_002_001")
    _ARG_1_.CONTROLLER:AddAttackPath("BeeSwarmPath_002_002")
  end
end
function s100_area10.OnGravittBuried_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s100_area10.OnGunzoo_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_001")
  end
end
function s100_area10.OnGunzoo_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_002")
  end
end
function s100_area10.OnGunzoo_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_003")
  end
end
function s100_area10.OnGunzoo_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_004")
  end
end
function s100_area10.OnGunzoo_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_005")
  end
end
function s100_area10.OnGunzoo_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_006")
  end
end
function s100_area10.OnGunzoo_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_007")
  end
end
function s100_area10.OnGunzoo_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_008")
  end
end
function s100_area10.OnGunzoo_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_009")
  end
end
function s100_area10.OnGunzoo_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_011")
  end
end
function s100_area10.OnGunzoo_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_016")
  end
end
function s100_area10.OnGunzoo_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_017")
  end
end
function s100_area10.OnGunzoo_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_018")
  end
end
function s100_area10.OnGunzoo_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_019")
  end
end
function s100_area10.OnGunzoo_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_020")
  end
end
function s100_area10.OnGunzoo_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GunzooPath_021")
  end
end
function s100_area10.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_001")
  end
end
function s100_area10.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_002")
  end
end
function s100_area10.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_003")
  end
end
function s100_area10.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_004")
  end
end
function s100_area10.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_005")
  end
end
function s100_area10.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_006")
  end
end
function s100_area10.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggNormalPath_007")
  end
end
function s100_area10.OnGulluggStr_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s100_area10.OnGulluggStr_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s100_area10.OnGulluggStr_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s100_area10.OnGulluggStr_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s100_area10.OnGulluggStr_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s100_area10.OnGulluggStr_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s100_area10.OnGulluggStr_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s100_area10.OnGulluggStr_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s100_area10.OnGulluggStr_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s100_area10.OnGulluggStr_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s100_area10.OnGulluggStr_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_014")
  end
end
function s100_area10.OnGulluggStr_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s100_area10.OnGulluggStr_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_017")
  end
end
function s100_area10.OnGulluggStr_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_018")
  end
end
function s100_area10.OnGulluggStr_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_019")
  end
end
function s100_area10.OnGulluggStr_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_020")
  end
end
function s100_area10.OnGulluggStr_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_021")
  end
end
function s100_area10.OnGulluggStr_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_022")
  end
end
function s100_area10.OnGulluggStr_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_023")
  end
end
function s100_area10.OnGulluggStr_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_024")
  end
end
function s100_area10.OnGulluggStr_025_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_025")
  end
end
function s100_area10.OnGulluggStr_026_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_026")
  end
end
function s100_area10.OnGulluggStr_027_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_027")
  end
end
function s100_area10.OnGulluggStr_028_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_028")
  end
end
function s100_area10.OnGulluggStr_029_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_029")
  end
end
function s100_area10.OnGulluggStr_030_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_030")
  end
end
function s100_area10.OnGulluggStr_031_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_031")
  end
end
function s100_area10.OnGulluggStr_032_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_032")
  end
end
function s100_area10.OnGulluggStr_033_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_033")
  end
end
function s100_area10.OnGulluggStr_034_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_034")
  end
end
function s100_area10.OnGulluggStr_035_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_035")
  end
end
function s100_area10.OnGulluggStr_036_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_036")
  end
end
function s100_area10.OnGulluggStr_037_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_037")
  end
end
function s100_area10.OnGulluggStr_038_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_038")
  end
end
function s100_area10.OnGulluggStr_039_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_039")
  end
end
function s100_area10.OnGulluggStr_040_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_040")
  end
end
function s100_area10.OnGulluggStr_041_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_041")
  end
end
function s100_area10.OnGulluggStr_042_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_042")
  end
end
function s100_area10.OnGulluggStr_043_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_043")
  end
end
function s100_area10.OnGulluggStr_044_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_044")
  end
end
function s100_area10.OnGulluggStr_045_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_045")
  end
end
function s100_area10.OnGulluggStr_046_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_046")
  end
end
function s100_area10.OnGulluggStr_047_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_047")
  end
end
function s100_area10.OnGulluggStr_048_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_048")
  end
end
function s100_area10.OnGulluggStr_049_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_049")
  end
end
function s100_area10.OnGulluggStr_050_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_050")
  end
end
function s100_area10.OnGulluggStr_051_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_051")
  end
end
function s100_area10.OnGulluggStr_052_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_052")
  end
end
function s100_area10.OnGulluggStr_053_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_053")
  end
end
function s100_area10.OnGulluggStr_054_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_054")
  end
end
function s100_area10.OnGulluggStr_055_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_055")
  end
end
function s100_area10.OnGulluggStr_056_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_056")
  end
end
function s100_area10.OnGulluggStr_057_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_057")
  end
end
function s100_area10.OnMetroidRadarTriggerOnEnter()
  s100_area10.ProcessMetroidRadarDistance()
end
function s100_area10.OnMetroidRadarTriggerOnExit()
  Game.DelSF("s100_area10.ProcessMetroidRadarDistance")
end
function s100_area10.ProcessMetroidRadarDistance()
  if Game.GetPlayer() ~= nil and Game.GetEntity("SG_Larva_001") ~= nil then
    if 1 - 6000 / 6000 == 0 then
      Game.MetroidRadarForceStateOnBegin(0, 0, false, false)
    else
      Game.MetroidRadarForceStateOnBegin(1, 1 - 6000 / 6000, true, false)
    end
    Game.AddSF(0.1, "s100_area10.ProcessMetroidRadarDistance", "")
  end
end
function s100_area10.LaunchMetroidBossPresentation()
  Game.SaveGame("checkpoint", "Checkpoint_LarvasIn", "ST_SG_Larva_001", true)
  Game.DelSF("s100_area10.ProcessMetroidRadarDistance")
  Game.DisableTrigger("TG_MetroidRadar")
  Game.DisableTrigger("TG_Intro_Larva")
  Game.HUDAvailabilityGoOff(false, true, false, false)
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(true)
  Game.AddSF(1, "s100_area10.StartMetroidCountIncrement", "")
  if Game.GetEntity("SG_Larva_001") ~= nil then
    Game.GetEntity("SG_Larva_001").SPAWNGROUP:EnableSpawnGroup()
  end
  Game.SetSubAreaCurrentSetup("collision_camera_008", "Default", true, true)
  Game.LaunchCutscene("cutscenes/intrometroidboss/takes/01/intrometroidboss01.bmscu")
  if Game.GetEntity("Door010") ~= nil then
    Game.GetEntity("Door010").LIFE:SetInvulnerable(false)
  end
  if Game.GetEntity("TG_ChangeCamera_IntroLarva") ~= nil then
    Game.GetEntity("TG_ChangeCamera_IntroLarva").TRIGGER:DisableTrigger()
  end
end
function s100_area10.LaunchMetroidBossPresentationCutsceneEnd()
  Game.HUDAvailabilityGoOn()
  Game.SetIgnoreHUDAvailabilityActivationByAbilityComponent(false)
  Scenario.WriteToBlackboard("MetroidDiscovered", "b", true)
  Game.AddSF(2.25, "Game.MetroidRadarForceStateOnEnd", "")
end
function s100_area10.OnEnter_ChangeCamera_IntroLarva()
  if Game.GetEntity("Door010") ~= nil then
    Game.GetEntity("Door010").LIFE:SetInvulnerable(true)
  end
  Game.SetSubAreaCurrentSetup("collision_camera_008", "ChangeCamera_IntroLarva", false)
end
function s100_area10.StartMetroidCountIncrement()
  Game.MetroidRadarForceStateOnBegin(1, 0.8, true, false)
  s100_area10.iMetroidTotalCountIncrements = 0
  Game.AddSF(2, "s100_area10.IncrementMetroidTotalCount", "")
end
function s100_area10.IncrementMetroidTotalCount()
  Game.IncrementMetroidTotalCount(1)
  s100_area10.iMetroidTotalCountIncrements = s100_area10.iMetroidTotalCountIncrements + 1
  if s100_area10.iMetroidTotalCountIncrements < s100_area10.iNumMetroids then
    Game.AddSF(0.15, "s100_area10.IncrementMetroidTotalCount", "")
  else
    Game.MetroidRadarForceStateOnBegin(2, 0.8, false, false)
  end
end
function s100_area10.OnEnter_EnableFade()
  Game.SetSubAreasPreferredTransitionType("Fade")
end
function s100_area10.OnExit_DisableFade()
  Game.SetSubAreasPreferredTransitionType("None")
end
function s100_area10.LaunchSpecialEvent1001()
  if Game.GetEntity("LE_Event_1001") ~= nil then
    Game.GetEntity("LE_Event_1001").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("SpecialEvent1001Launched", "b", true)
  end
end
function s100_area10.LaunchSpecialEvent1002()
  if Game.GetEntity("LE_Event_1002") ~= nil then
    Game.GetEntity("LE_Event_1002").ANIMATION:SetAction("event")
    Scenario.WriteToBlackboard("SpecialEvent1002Launched", "b", true)
  end
end
function s100_area10.OnEnter_ChangeCamera_024()
  Game.SetCollisionCameraLocked("collision_camera_024_B", true)
end
function s100_area10.OnExit_ChangeCamera_024()
  Game.SetCollisionCameraLocked("collision_camera_024_B", false)
end
function s100_area10.OnEnter_ChangeCamera_024_Disable()
  Game.SetSubAreaCurrentSetup("collision_camera_024", "Disable_Camera", false)
end
function s100_area10.OnEnter_ChangeCamera_024_Enable()
  Game.SetSubAreaCurrentSetup("collision_camera_024", "Default", false)
end
function s100_area10.OnEnter_ChangeCamera_021()
  Game.SetCollisionCameraLocked("collision_camera_021_B", true)
end
function s100_area10.OnExit_ChangeCamera_021()
  Game.SetCollisionCameraLocked("collision_camera_021_B", false)
end
function s100_area10.OnEnter_ChangeCamera_010()
  Game.SetCollisionCameraLocked("collision_camera_010_B", true)
end
function s100_area10.OnExit_ChangeCamera_010()
  Game.SetCollisionCameraLocked("collision_camera_010_B", false)
end
