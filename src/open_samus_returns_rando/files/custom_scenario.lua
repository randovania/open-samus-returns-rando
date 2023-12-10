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
  local scenario = Init.tScenarioMapping[Scenario.CurrentScenarioID]
  local maxDNA = Init.tDNAPerArea[scenario] or 0
  local currentDNA =  Blackboard.GetProp("GAME", scenario .."_acquired_dna") or 0
  
  GUILib.UpdateDNACounter(currentDNA, maxDNA)
end

local original_init = Scenario.InitScenario
function Scenario.InitScenario(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  original_init(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  local player_section = Game.GetPlayerBlackboardSectionName()
  local current_level = Blackboard.GetProp(player_section, "LevelID") or ""
  if current_level == "c10_samus" then
    local rando_initialized = Blackboard.GetProp(player_section, "RANDO_GAME_INITIALIZED") or false
    if not rando_initialized then
      Blackboard.SetProp(player_section, "RANDO_GAME_INITIALIZED", "b", true)
      Scenario.ShowText()
    end
  end
end


function Scenario.ShowText()
  local textboxes_seen = Init.tBoxesSeen 
  local player_section = Game.GetPlayerBlackboardSectionName()
  local already_seen = Blackboard.GetProp(player_section, "RANDO_START_TEXT") or false
  if already_seen then return end
  if Init.iNumRandoTextBoxes == textboxes_seen then
    Blackboard.SetProp(player_section, "RANDO_START_TEXT", "b", true)
  elseif Init.iNumRandoTextBoxes - textboxes_seen > 0 then
    Init.tBoxesSeen = textboxes_seen + 1
    GUI.LaunchMessage("#RANDO_STARTING_TEXT_" .. Init.tBoxesSeen, "Scenario.ShowText", "")
  end
end

function Scenario.LoadNewScenario(target_scenario, target_spawnpoint)
  bWaitingForScenarioChange = true
  Game.FadeOut(0.0)
  Game.FadeOutStream(0.0 * 0.8)
  Game.AddPSF(0.1, "Game.LoadScenario", "ssssi", "c10_samus", target_scenario, target_spawnpoint, "", 1)
  Game.GetPlayer().vPos = V3D(-22800, 4450, 0)
end