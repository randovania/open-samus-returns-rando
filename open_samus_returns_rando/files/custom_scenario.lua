Game.ImportLibrary("system/scripts/scenario_original.lua")
Game.ImportLibrary("system/scripts/guilib.lua", false)

Scenario = Scenario or {}
setmetatable(Scenario, {__index = _G})

local original_enable =  Scenario.EnableHazarous
function Scenario.EnableHazarous(_ARG_0_, _ARG_1_)
 if CurrentScenario.OnHazarousPoolDrain ~= nil then
  CurrentScenario.OnHazarousPoolDrain("")
 end
 original_enable(_ARG_0_, _ARG_1_)
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

function Scenario.UpdateDNACounter()
  local scenario = Init.tAreaMapping[Scenario.CurrentScenarioID]
  local maxDNA = Init.tDNAPerArea[scenario] or 0
  local currentDNA =  Blackboard.GetProp("GAME", scenario .."_acquired_dna") or 0
  
  GUILib.UpdateDNACounter(currentDNA, maxDNA)
end
