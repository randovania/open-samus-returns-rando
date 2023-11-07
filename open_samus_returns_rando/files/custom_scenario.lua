Game.ImportLibrary("system/scripts/scenario_original.lua")
Game.DoFile("system/scripts/guilib.lua")

Scenario = Scenario or {}
setmetatable(Scenario, {__index = _G})
setfenv(1, Scenario)

function HideLoadingScreen()
 Game.SetLoadingScreen(false)
 loadingscreen.HideLoadingScreen()
 Game.HUDIdleScreenLeave()
 if table.getn(CurrentScenario.tHazarous) > 0 then
  for key, value in pairs(CurrentScenario.tHazarous) do
   EnableHazarous(key, false)
  end
 end
end

function EnableHazarous(_ARG_0_, _ARG_1_)
 if CurrentScenario.EnableHazarous ~= nil then
  CurrentScenario.EnableHazarous(_ARG_0_, _ARG_1_)
 end
 if CurrentScenario.OnHazarousPoolDrain ~= nil then
  CurrentScenario.OnHazarousPoolDrain("")
 end
 if CurrentScenario.tHazarous[_ARG_0_] ~= nil then
  for _FORV_6_, _FORV_7_ in pairs(CurrentScenario.tHazarous[_ARG_0_].Triggers) do
   if CanaManageHazarousEntity(_ARG_0_, "Triggers", _FORV_7_, _ARG_1_) and Game.GetEntity(_FORV_7_) ~= nil then
    if _ARG_1_ then
     Game.GetEntity(_FORV_7_):Disable()
    else
     Game.GetEntity(_FORV_7_):Enable()
    end
   end
   end
   for _FORV_6_, _FORV_7_ in pairs(CurrentScenario.tHazarous[_ARG_0_].SpawnGroups) do
    if CanaManageHazarousEntity(_ARG_0_, "SpawnGroups", _FORV_7_, _ARG_1_) and Game.GetEntity(_FORV_7_) ~= nil then
     if _ARG_1_ then
      Game.GetEntity(_FORV_7_).SPAWNGROUP:DisableSpawnGroup()
     else
      Game.GetEntity(_FORV_7_).SPAWNGROUP:EnableSpawnGroup()
     end
   end
  end
  for _FORV_6_, _FORV_7_ in pairs(CurrentScenario.tHazarous[_ARG_0_].Usables) do
   if CanaManageHazarousEntity(_ARG_0_, "Usables", _FORV_7_, _ARG_1_) and Game.GetEntity(_FORV_7_) ~= nil then
    Game.GetEntity(_FORV_7_).USABLE:Activate(not _ARG_1_)
   end
  end
 end
end

function Scenario._UpdateProgressiveItemModels()
  for name, actordef in pairs(Game.GetEntities()) do
    local progressive_models = RandomizerPowerup.tProgressiveModels[actordef]
    if progressive_models ~= nil then
      for index, model in ipairs(progressive_models) do
        if not RandomizerPowerup.HasItem(model.item) or #progressive_models == index then
          local pickup = Game.GetEntity(name)
          pickup.MODELUPDATER.sModelAlias = model.alias
          break
        end
      end
    end
  end
end

function Scenario.UpdateProgressiveItemModels()
  Game.AddSF(0.2, "Scenario._UpdateProgressiveItemModels", "")
end

function Scenario.OnSubAreaChange(old_subarea, old_actorgroup, new_subarea, new_actorgroup, disable_fade)
  Scenario.UpdateProgressiveItemModels()
end

function Scenario.SetMetroidSpawngroupOnCurrentScenario(created_actor, group_name, is_multi)
  if created_actor ~= nil and created_actor.sName ~= nil then
    CurrentScenario.currentMetroidSpawngroup = group_name
    CurrentScenario.isMultiGamma = is_multi or false
  end
end

function Scenario.InitGUI()
  GUILib.AddDNACounter()
  Scenario.UpdateDNACounter()
end

Scenario.AreaMapping = {
  s000_surface = "s00",
  s010_area1 = "s01",
  s020_area2 = "s02",
  s025_area2b = "s02",
  s028_area2c = "s02",
  s030_area3 = "s03",
  s033_area3b = "s03",
  s036_area3c = "s03",
  s040_area4 = "s04",
  s050_area5 = "s04",
  s060_area6 = "s06",
  s065_area6b = "s06",
  s067_area6c = "s06",
  s070_area7 = "s07",
  s090_area9 = "s09",
  s100_area10 = "s10",
  s110_surfaceb = "s00",
}

function Scenario.UpdateDNACounter()
  local scenario = Scenario.AreaMapping[Scenario.CurrentScenarioID]
  local maxDNA = Init.tDNAPerArea[scenario] or 0
  local currentDNA =  Blackboard.GetProp("GAME", scenario .."_acquired_dna") or 0
  
  GUILib.UpdateDNACounter(currentDNA, maxDNA)
end
