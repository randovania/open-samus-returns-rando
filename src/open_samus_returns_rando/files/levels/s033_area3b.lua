function s033_area3b.main()
  Scenario.InitGUI()
end
function s033_area3b.SetupDebugGameBlackboard()
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
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_WAVE_BEAM", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_SPAZER_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_WEAPON_PLASMA_BEAM", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPRING_BALL", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_HIGH_JUMP_BOOTS", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPACE_JUMP", "f", 0)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_VARIA_SUIT", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_SCANNING_PULSE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_SHIELD", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_ENERGY_WAVE", "f", 1)
  Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_SPECIAL_ENERGY_PHASE_DISPLACEMENT", "f", 0)
end
function s033_area3b.GetOnDeathOverrides()
  return {GoToMainMenu = false}
end
function s033_area3b.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
  if _ARG_0_ ~= "collision_camera_031" or _ARG_2_ ~= "collision_camera_031" then
    Game.SetSubAreaEnvironmentLocked(false, false, false)
  end
  if _ARG_2_ == "collision_camera_008" and Scenario.ReadFromBlackboard("entity_SG_Gamma_001_deaths", 0) == 0 then
    Game.SetSceneGroupEnabledByName("sg_SubArea_Gamma_001_Wall", true)
  else
    Game.SetSceneGroupEnabledByName("sg_SubArea_Gamma_001_Wall", false)
  end
  Scenario.OnSubAreaChange(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_, _ARG_4_)
end
function s033_area3b.LaunchMinerBotDemolishCutscene()
  if Game.GetEntity("LE_ManicMiner") ~= nil then
    Game.GetEntity("LE_ManicMiner"):Disable()
  end
  if Game.GetEntity("LE_ManicMinerDemolish") ~= nil then
    Game.GetEntity("LE_ManicMinerDemolish"):Disable()
  end
  if Game.GetPlayer() ~= nil then
    -- Game.GetPlayer().ANIMATION:SetAction("manicminerbotarea3", true)
    Game.GetPlayer().MOVEMENT:ForceDetachGrapple(true)
  end
  -- Game.LaunchCutscene("cutscenes/intromanicminerbotarea3/takes/01/intromanicminerbotarea301.bmscu")
  Scenario.WriteToBlackboard("MinerBotDemolishCutsceneLaunched", "b", true)
  Game.SetSubAreaEnvironmentLocked(false, false, true)
  Game.SetSubAreaCurrentSetup("collision_camera_031", "PostManicMiner", true)
end
function s033_area3b.Spawn_Alpha_002_Intro()
  Game.DisableTrigger("TG_Alpha_002_Intro")
  if Game.GetEntity("SG_Alpha_002") ~= nil then
    Game.GetEntity("SG_Alpha_002").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s033_area3b.OnAlpha_002_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Alpha_002") ~= nil and Game.GetEntity("Alpha_002").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_002").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Alpha_002_Intro") ~= nil and Game.GetEntity("Alpha_002_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Alpha_002_Intro").SPAWNPOINT:Deactivate()
  end
  s033_area3b.OnAlpha_002_Generated(_ARG_0_, _ARG_1_)
end
function s033_area3b.OnEnter_SetCheckpoint_001_Alpha_002()
  Game.SetBossCheckPointNames("ST_SG_Alpha_002", "ST_SG_Alpha_002_Out", "SG_Alpha_002", "", "")
end
function s033_area3b.OnAlpha_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_002")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door016")
    -- _ARG_1_.AI:AddBossDoor("Door018")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Alpha_002")
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
function s033_area3b.OnEnter_Alpha_002_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_002_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_007", "PostAlpha_002", true)
    if Game.GetEntity("SpawnGroup009") ~= nil then
      Game.GetEntity("SpawnGroup009").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s033_area3b.OnEnter_SetCheckpoint_001_Alpha_003()
  Game.SetBossCheckPointNames("ST_SG_Alpha_003", "ST_SG_Alpha_003B_Out", "SG_Alpha_003", "", "")
end
function s033_area3b.OnEnter_SetCheckpoint_002_Alpha_003()
  Game.SetBossCheckPointNames("ST_SG_Alpha_003B", "ST_SG_Alpha_003B_Out", "SG_Alpha_003", "", "")
end
function s033_area3b.OnAlpha_003_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Alpha_003")
  if _ARG_1_ ~= nil and _ARG_1_.AI ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door017")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Alpha")
    _ARG_1_.AI:AddBossCameraFloorLandmark("LM_Alpha_003")
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
function s033_area3b.OnEnter_Alpha_003_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Alpha_003_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_038", "PostAlpha_003", true)
    if Game.GetEntity("SpawnGroup010") ~= nil then
      Game.GetEntity("SpawnGroup010").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.DisableTrigger("TG_SetCheckpoint_001_Alpha_003")
    Game.DisableTrigger("TG_SetCheckpoint_002_Alpha_003")
  end
end
function s033_area3b.OnGamma_001_Intro_Generated(_ARG_0_, _ARG_1_)
  if Game.GetEntity("Gamma_001") ~= nil and Game.GetEntity("Gamma_001").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_001").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Gamma_001_Intro") ~= nil and Game.GetEntity("Gamma_001_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_001_Intro").SPAWNPOINT:Deactivate()
  end
  s033_area3b.OnGamma_001_Generated(_ARG_0_, _ARG_1_)
end
function s033_area3b.Spawn_Gamma_001_Intro()
  Game.DisableTrigger("TG_Gamma_001_Intro")
  if Game.GetEntity("SG_Gamma_001") ~= nil then
    Game.GetEntity("SG_Gamma_001").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s033_area3b.OnEnter_SetCheckpoint_001_Gamma_001()
  Game.SetBossCheckPointNames("ST_SG_Gamma_001", "ST_SG_Gamma_001B_Out", "SG_Gamma_001", "", "")
end
function s033_area3b.OnEnter_SetCheckpoint_002_Gamma_001()
  Game.SetBossCheckPointNames("ST_SG_Gamma_001B", "ST_SG_Gamma_001B_Out", "SG_Gamma_001", "", "")
end
function s033_area3b.OnGamma_001_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_001")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoor("Door002")
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
function s033_area3b.OnEnter_Gamma_001_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Gamma_001_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_008", "PostGamma_001", true)
    if Game.GetEntity("SpawnGroup012") ~= nil then
      Game.GetEntity("SpawnGroup012").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.DisableTrigger("TG_SetCheckpoint_001_Gamma_001")
    Game.DisableTrigger("TG_SetCheckpoint_002_Gamma_001")
    Game.SetSceneGroupEnabledByName("sg_SubArea_Gamma_001_Wall", false)
  end
end
function s033_area3b.OnGamma_002_Intro_Generated(_ARG_0_, _ARG_1_)
  s033_area3b.OnGamma_002_Generated(_ARG_0_, _ARG_1_)
end
function s033_area3b.Spawn_Gamma_002_Intro()
  Game.DisableTrigger("TG_Gamma_002_Intro")
  if Game.GetEntityFromSpawnPoint("Gamma_002_Intro") ~= nil then
    Game.GetEntityFromSpawnPoint("Gamma_002_Intro").ANIMATION:SetAction("spawn32", true)
  end
  if Game.GetEntity("Gamma_002") ~= nil and Game.GetEntity("Gamma_002").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_002").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Gamma_002_Intro") ~= nil and Game.GetEntity("Gamma_002_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_002_Intro").SPAWNPOINT:Deactivate()
  end
end
function s033_area3b.OnEnter_SetCheckpoint_001_Gamma_002()
  Game.SetBossCheckPointNames("ST_SG_Gamma_002", "ST_SG_Gamma_002", "SG_Gamma_002", "", "")
end
function s033_area3b.OnEnter_SetCheckpoint_002_Gamma_002()
  Game.SetBossCheckPointNames("ST_SG_Gamma_002", "ST_SG_Gamma_002_Out", "SG_Gamma_002", "", "")
end
function s033_area3b.OnGamma_002_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_002")
  if _ARG_1_ ~= nil then
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
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
function s033_area3b.OnEnter_Gamma_002_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Gamma_002_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_009", "PostGamma_002", true)
    if Game.GetEntity("SpawnGroup013") ~= nil then
      Game.GetEntity("SpawnGroup013").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
function s033_area3b.OnGamma_003_Discovered()
  if Game.GetEntityFromSpawnPoint("Gamma_003_Intro") ~= nil then
    Game.GetEntityFromSpawnPoint("Gamma_003_Intro").MOVEMENT:SetState("Flying")
    Game.GetEntityFromSpawnPoint("Gamma_003_Intro").ANIMATION:SetAction("waitinginlairendpre", false)
  end
  if Game.GetEntity("LE_Gamma_003_Valve") ~= nil then
    Game.GetEntity("LE_Gamma_003_Valve").ANIMATION:SetAction("use", false)
  end
  if Game.GetEntity("Gamma_003") ~= nil and Game.GetEntity("Gamma_003").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_003").SPAWNPOINT:Activate()
  end
  if Game.GetEntity("Gamma_003_Intro") ~= nil and Game.GetEntity("Gamma_003_Intro").SPAWNPOINT ~= nil then
    Game.GetEntity("Gamma_003_Intro").SPAWNPOINT:Deactivate()
  end
end
function s033_area3b.OnEnter_SetCheckpoint_001_Gamma_003()
  Game.SetBossCheckPointNames("ST_SG_Gamma_003", "ST_SG_Gamma_003_Out", "SG_Gamma_003", "", "")
end
function s033_area3b.OnGamma_003_Generated(_ARG_0_, _ARG_1_)
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
    _ARG_1_.AI.vInLairTilePos = V3D(3100, 4800, 0)
    _ARG_1_.AI.sInLairCallback = "s033_area3b.OnGamma_003_Discovered"
  end
end
function s033_area3b.OnEnter_Gamma_003_Dead()
  if 0 < Scenario.ReadFromBlackboard("entity_SG_Gamma_003_deaths", 0) then
    Game.SetSubAreaCurrentSetup("collision_camera_036", "PostGamma_003", true)
    if Game.GetEntity("SpawnGroup011") ~= nil then
      Game.GetEntity("SpawnGroup011").SPAWNGROUP:EnableSpawnGroup()
    end
    Game.DisableTrigger("TG_SetCheckpoint_001_Gamma_003")
    Game.DisableTrigger("TG_SetCheckpoint_002_Gamma_003")
  end
end
function s033_area3b.OnEnter_Gamma_003_EnableAttack()
  Game.DelSF("CurrentScenario.OnEnter_Gamma_003_DisableAttack")
  if Game.GetBoss() ~= nil then
    Game.GetBoss().AI.bIgnoreAttack = false
  end
end
function s033_area3b.OnEnter_Gamma_003_DisableAttack()
  Game.DelSF("CurrentScenario.OnEnter_Gamma_003_DisableAttack")
  if Game.GetBoss() ~= nil then
    if Game.GetBoss().MOVEMENT.bIsFlying then
      Game.GetBoss().AI.bIgnoreAttack = true
    else
      Game.AddSF(0.1, "CurrentScenario.OnEnter_Gamma_003_DisableAttack", "")
    end
  end
end
function s033_area3b.OnEnter_SetCheckpoint_Gamma_004()
  Game.SetBossCheckPointNames("ST_SG_Gamma_004", "ST_SG_Gamma_004", "", "SG_Gamma_004_B", "")
end
-- function s033_area3b.OnGamma_004_A_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_004", "A")
-- end
-- function s033_area3b.OnGamma_004_Intro_A_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_004_Intro_A") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_004_Intro_A").ANIMATION:SetAction("spawn")
--   end
--   s033_area3b.OnGamma_004_A_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s033_area3b.OnGamma_004_A_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_A_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_A_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_A_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_A_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_A_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_A_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_A_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_A_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_A_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_A_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_A_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_A_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_A_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_A_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_A_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_A_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_A_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_A_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma004_A_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_A_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_A_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_A_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_A_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
function s033_area3b.OnGamma_004_B_Trigger()
  if Game.GetEntity("SG_Gamma_004_B") ~= nil and Scenario.ReadFromBlackboard("entity_TG_Gamma_004_B_enabled", true) then
    Game.GetEntity("SG_Gamma_004_B").SPAWNGROUP:EnableSpawnGroup()
  end
end
function s033_area3b.OnGamma_004_Intro_B_Generated(_ARG_0_, _ARG_1_)
  -- if Game.GetEntity("LE_Valve_Gamma_004_Intro_B") ~= nil then
  --   Game.GetEntity("LE_Valve_Gamma_004_Intro_B").ANIMATION:SetAction("spawn")
  -- end
  s033_area3b.OnGamma_004_B_Generated(_ARG_0_, _ARG_1_)
end
function s033_area3b.OnGamma_004_B_Generated(_ARG_0_, _ARG_1_)
  Scenario.SetMetroidSpawngroupOnCurrentScenario(_ARG_0_, "SG_Gamma_004_B")
  if _ARG_1_ ~= nil then
    -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
    _ARG_1_.AI.bPlaceholder = false
    _ARG_1_.AI:AddBossCamera("CAM_Gamma")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_B_001")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_B_002")
    _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_B_003")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_B_001")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_B_002")
    _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_B_003")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_B_001")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_B_002")
    _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_B_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_B_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_B_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_B_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_B_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_B_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_B_mines_003")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_B_mines_001")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_B_mines_002")
    _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_B_mines_003")
    _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma004_B_Idle")
    -- Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_B_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_B_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
    -- if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_B_001")
    --   _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_B_002")
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
    --   _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
    -- end
  end
end
-- function s033_area3b.OnGamma_004_C_Trigger()
--   Gamma.OnMultiArenaTrigger("Gamma_004", "C")
-- end
-- function s033_area3b.OnGamma_004_Intro_C_Generated(_ARG_0_, _ARG_1_)
--   if Game.GetEntity("LE_Valve_Gamma_004_Intro_C") ~= nil then
--     Game.GetEntity("LE_Valve_Gamma_004_Intro_C").ANIMATION:SetAction("spawn")
--   end
--   s033_area3b.OnGamma_004_C_Generated(_ARG_0_, _ARG_1_)
-- end
-- function s033_area3b.OnGamma_004_C_Generated(_ARG_0_, _ARG_1_)
--   if _ARG_1_ ~= nil then
--     -- _ARG_1_.AI:AddBossDoorUnlockedOnDeath("Door014")
--     _ARG_1_.AI.bPlaceholder = false
--     _ARG_1_.AI:AddBossCamera("CAM_Gamma")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(0, "PATH_Gamma004_C_003")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(1, "PATH_Gamma004_C_003")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_C_001")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_C_002")
--     _ARG_1_.AI:AddPresetLogicPath(2, "PATH_Gamma004_C_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(0, "PATH_Gamma004_C_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(1, "PATH_Gamma004_C_mines_003")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_C_mines_001")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_C_mines_002")
--     _ARG_1_.AI:AddElectricMinesLogicPath(2, "PATH_Gamma004_C_mines_003")
--     _ARG_1_.AI:AddIdleLogicPath("PATH_Gamma004_C_Idle")
--     Gamma.SetArenaLife(_ARG_0_, _ARG_1_)
--     if Gamma.GetNumValveUsed(_ARG_0_) == 0 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_C_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_C_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.6)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 60)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--     if Gamma.GetNumValveUsed(_ARG_0_) == 1 then
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_C_001")
--       _ARG_1_.AI:AddValve("LE_Valve_Gamma_004_C_002")
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveLifePct", 0.3)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveTime", 90)
--       _ARG_1_.AI:AddBlackboardParam("fGotoValveSamusLife", 99)
--     end
--   end
-- end
function s033_area3b.OnEnter_Gamma_004_Dead()
  if Scenario.ReadFromBlackboard("Arena_Gamma_004_AllDead", false) then
    Game.SetSubAreaCurrentSetup("collision_camera_033", "PostGamma_004", true)
    Game.SetSubAreaCurrentSetup("collision_camera_034", "PostGamma_004", true)
    Game.SetSubAreaCurrentSetup("collision_camera_035", "PostGamma_004", true)
    Game.DisableTrigger("TG_SetCheckpoint_Gamma_004")
    if Game.GetEntity("SpawnGroup014") ~= nil then
      Game.GetEntity("SpawnGroup014").SPAWNGROUP:EnableSpawnGroup()
    end
    if Game.GetEntity("SpawnGroup015") ~= nil then
      Game.GetEntity("SpawnGroup015").SPAWNGROUP:EnableSpawnGroup()
    end
  end
end
s033_area3b.tDNAScanLandmarks = {
  SG_Alpha_002 = {
    "LM_ADNScanner_Samus_Alpha_002_001",
    "LM_ADNScanner_Samus_Alpha_002_002",
    "LM_ADNScanner_Samus_Alpha_002_003",
    "LM_ADNScanner_Samus_Alpha_002_004",
    "LM_ADNScanner_Samus_Alpha_002_005",
    "LM_ADNScanner_Samus_Alpha_002_006",
    "LM_ADNScanner_Samus_Alpha_002_007",
    "LM_ADNScanner_Samus_Alpha_002_008",
    "LM_ADNScanner_Samus_Alpha_002_009",
    "LM_ADNScanner_Samus_Alpha_002_010"
  },
  SG_Gamma_001 = {
    "LM_ADNScanner_Samus_Gamma_001_001",
    "LM_ADNScanner_Samus_Gamma_001_002",
    "LM_ADNScanner_Samus_Gamma_001_003",
    "LM_ADNScanner_Samus_Gamma_001_004",
    "LM_ADNScanner_Samus_Gamma_001_005",
    "LM_ADNScanner_Samus_Gamma_001_006",
    "LM_ADNScanner_Samus_Gamma_001_008",
    "LM_ADNScanner_Samus_Gamma_001_009",
    "LM_ADNScanner_Samus_Gamma_001_010",
    "LM_ADNScanner_Samus_Gamma_001_011",
    "LM_ADNScanner_Samus_Gamma_001_012",
    "LM_ADNScanner_Samus_Gamma_001_013"
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
    "LM_ADNScanner_Samus_Gamma_002_010",
    "LM_ADNScanner_Samus_Gamma_002_011",
    "LM_ADNScanner_Samus_Gamma_002_012",
    "LM_ADNScanner_Samus_Gamma_002_013",
    "LM_ADNScanner_Samus_Gamma_002_014",
    "LM_ADNScanner_Samus_Gamma_002_015"
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
    "LM_ADNScanner_Samus_Alpha_003_010"
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
    "LM_ADNScanner_Samus_Gamma_003_013"
  },
  SG_Gamma_004_A = {
    "LM_ADNScanner_Samus_Gamma_004_A_001",
    "LM_ADNScanner_Samus_Gamma_004_A_002",
    "LM_ADNScanner_Samus_Gamma_004_A_003",
    "LM_ADNScanner_Samus_Gamma_004_A_004",
    "LM_ADNScanner_Samus_Gamma_004_A_005",
    "LM_ADNScanner_Samus_Gamma_004_A_006",
    "LM_ADNScanner_Samus_Gamma_004_A_007",
    "LM_ADNScanner_Samus_Gamma_004_A_008",
    "LM_ADNScanner_Samus_Gamma_004_A_009",
    "LM_ADNScanner_Samus_Gamma_004_A_010",
    "LM_ADNScanner_Samus_Gamma_004_A_011",
    "LM_ADNScanner_Samus_Gamma_004_A_012",
    "LM_ADNScanner_Samus_Gamma_004_A_013"
  },
  SG_Gamma_004_B = {
    "LM_ADNScanner_Samus_Gamma_004_B_001",
    "LM_ADNScanner_Samus_Gamma_004_B_002",
    "LM_ADNScanner_Samus_Gamma_004_B_003",
    "LM_ADNScanner_Samus_Gamma_004_B_004",
    "LM_ADNScanner_Samus_Gamma_004_B_005",
    "LM_ADNScanner_Samus_Gamma_004_B_006",
    "LM_ADNScanner_Samus_Gamma_004_B_007",
    "LM_ADNScanner_Samus_Gamma_004_B_008",
    "LM_ADNScanner_Samus_Gamma_004_B_009",
    "LM_ADNScanner_Samus_Gamma_004_B_010",
    "LM_ADNScanner_Samus_Gamma_004_B_011",
    "LM_ADNScanner_Samus_Gamma_004_B_012"
  },
  SG_Gamma_004_C = {
    "LM_ADNScanner_Samus_Gamma_004_C_001",
    "LM_ADNScanner_Samus_Gamma_004_C_002",
    "LM_ADNScanner_Samus_Gamma_004_C_003",
    "LM_ADNScanner_Samus_Gamma_004_C_004",
    "LM_ADNScanner_Samus_Gamma_004_C_005",
    "LM_ADNScanner_Samus_Gamma_004_C_006",
    "LM_ADNScanner_Samus_Gamma_004_C_007",
    "LM_ADNScanner_Samus_Gamma_004_C_008",
    "LM_ADNScanner_Samus_Gamma_004_C_009",
    "LM_ADNScanner_Samus_Gamma_004_C_010"
  }
}
function s033_area3b.OnLE_Platform_Elevator_FromArea03A_01(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s030_area3", "ST_FromArea03B_01", _ARG_2_)
end
function s033_area3b.OnLE_Platform_Elevator_FromArea03A_02(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s030_area3", "ST_FromArea03B_02", _ARG_2_)
end
function s033_area3b.OnLE_Platform_Elevator_FromArea03C(_ARG_0_, _ARG_1_, _ARG_2_)
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InnerArea, "")
  Elevator.Use("c10_samus", "s036_area3c", "ST_FromArea03B", _ARG_2_)
end
function s033_area3b.PreLE_Platform_Elevator_FromArea03A_01()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s033_area3b.PreLE_Platform_Elevator_FromArea03A_02()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s033_area3b.PreLE_Platform_Elevator_FromArea03C()
  GUI.ElevatorStartUseActionStep1InnerArea()
end
function s033_area3b.InitFromBlackboard()
  if Scenario.ReadFromBlackboard("MinerBotDemolishCutsceneLaunched", false) then
    if Game.GetEntity("LE_ManicMiner") ~= nil then
      Game.GetEntity("LE_ManicMiner"):Disable()
    end
    if Game.GetEntity("LE_ManicMinerDemolish") ~= nil then
      Game.GetEntity("LE_ManicMinerDemolish"):Disable()
    end
  end
end
function s033_area3b.OnReloaded()
end
function s033_area3b.OnExit()
end
function s033_area3b.OnEnter_ActivationTeleport_03B_001()
  Game.OnTeleportApproached("LE_Teleporter_03B_001")
end
function s033_area3b.OnEnter_ActivationTeleport_03B_002()
  Game.OnTeleportApproached("LE_Teleporter_03B_002")
end
function s033_area3b.OnGenericCrawler_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("fGotoClockwiseOffset", -1)
    _ARG_1_.AI:AddBlackboardParam("fGotoCounterClockwiseOffset", -1)
  end
end
function s033_area3b.OnGullugg_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_001")
  end
end
function s033_area3b.OnGullugg_002_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_002")
  end
end
function s033_area3b.OnGullugg_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_003")
  end
end
function s033_area3b.OnGullugg_004_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_004")
  end
end
function s033_area3b.OnGullugg_005_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_005")
  end
end
function s033_area3b.OnGullugg_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_006")
  end
end
function s033_area3b.OnGullugg_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_007")
  end
end
function s033_area3b.OnGullugg_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_008")
  end
end
function s033_area3b.OnGullugg_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_009")
  end
end
function s033_area3b.OnGullugg_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_010")
  end
end
function s033_area3b.OnGullugg_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_011")
  end
end
function s033_area3b.OnGullugg_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_012")
  end
end
function s033_area3b.OnGullugg_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_013")
  end
end
function s033_area3b.OnGullugg_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_014")
  end
end
function s033_area3b.OnGullugg_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_015")
  end
end
function s033_area3b.OnGullugg_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "GulluggPath_016")
  end
end
function s033_area3b.OnGravittTunnel_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil then
    _ARG_1_.AI:AddBlackboardParam("sSpawnAnim", "buriedtorelax")
  end
end
function s033_area3b.OnDrivel_001_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_001")
  end
end
function s033_area3b.OnDrivel_003_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_003")
  end
end
function s033_area3b.OnDrivel_006_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_006")
  end
end
function s033_area3b.OnDrivel_007_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_007")
  end
end
function s033_area3b.OnDrivel_008_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_008")
  end
end
function s033_area3b.OnDrivel_009_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_009")
  end
end
function s033_area3b.OnDrivel_010_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_010")
  end
end
function s033_area3b.OnDrivel_011_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_011")
  end
end
function s033_area3b.OnDrivel_012_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_012")
  end
end
function s033_area3b.OnDrivel_013_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_013")
  end
end
function s033_area3b.OnDrivel_014_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_014")
  end
end
function s033_area3b.OnDrivel_015_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_015")
  end
end
function s033_area3b.OnDrivel_016_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_016")
  end
end
function s033_area3b.OnDrivel_017_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_017")
  end
end
function s033_area3b.OnDrivel_018_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_018")
  end
end
function s033_area3b.OnDrivel_019_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_019")
  end
end
function s033_area3b.OnDrivel_020_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_020")
  end
end
function s033_area3b.OnDrivel_021_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_021")
  end
end
function s033_area3b.OnDrivel_022_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_022")
  end
end
function s033_area3b.OnDrivel_023_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_023")
  end
end
function s033_area3b.OnDrivel_024_Generated(_ARG_0_, _ARG_1_)
  if _ARG_1_ ~= nil and _ARG_1_.MOVEMENT ~= nil then
    _ARG_1_.AI:AddPresetLogicPath(0, "DrivelPath_024")
  end
end
function s033_area3b.OnGrapplePullFinished(_ARG_0_, _ARG_1_)
  if _ARG_0_ ~= nil and _ARG_0_.sName == "LE_GrappleDest_002" and _ARG_1_ then
    s033_area3b.LaunchMinerBotDemolishCutscene()
  end
end
function s033_area3b.OnEnter_ChangeCamera_012()
  Game.SetCollisionCameraLocked("collision_camera_012_B", true)
end
function s033_area3b.OnExit_ChangeCamera_012()
  Game.SetCollisionCameraLocked("collision_camera_012_B", false)
end
function s033_area3b.OnEnter_ChangeCamera_034()
  Game.SetCollisionCameraLocked("collision_camera_034_B", true)
end
function s033_area3b.OnExit_ChangeCamera_034()
  Game.SetCollisionCameraLocked("collision_camera_034_B", false)
end
function s033_area3b.OnEnter_ChangeCamera_025()
  Game.SetCollisionCameraLocked("collision_camera_025_B", true)
end
function s033_area3b.OnExit_ChangeCamera_025()
  Game.SetCollisionCameraLocked("collision_camera_025_B", false)
end
