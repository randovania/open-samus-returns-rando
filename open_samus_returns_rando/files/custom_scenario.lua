Game.ImportLibrary("system/scripts/scenario_original.lua")

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