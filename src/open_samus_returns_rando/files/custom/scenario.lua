Game.ImportLibrary("system/scripts/scenario_original.lua")
Game.ImportLibrary("system/scripts/guilib.lua", false)
Game.ImportLibrary("system/scripts/queue.lua", false)
Game.ImportLibrary("system/scripts/cosmetics.lua", false)

Game.DoFile("system/scripts/room_names.lua")
Game.DoFile("system/scripts/elevators.lua")

Scenario = Scenario or {}
setmetatable(Scenario, {__index = _G})

Scenario.tProgressiveModels = {}

Scenario.INVALID_UUID = "00000000-0000-1111-0000-000000000000"

local original_enable =  Scenario.EnableHazarous
function Scenario.EnableHazarous(_ARG_0_, _ARG_1_)
 if CurrentScenario.OnHazarousPoolDrain ~= nil then
  CurrentScenario.OnHazarousPoolDrain("")
 end
 original_enable(_ARG_0_, _ARG_1_)
end

function Scenario._UpdateProgressiveItemModels()
  for name, actordef in pairs(Game.GetEntities()) do
    local progressive_models = Scenario.tProgressiveModels[actordef]
    if progressive_models ~= nil then
      for index, model in ipairs(progressive_models) do
        local has_item = Game.GetItemAmount(Game.GetPlayerName(), model.item) > 0
        if not has_item or #progressive_models == index then
          local pickup = Game.GetEntity(name)
          pickup.MODELUPDATER.sModelAlias = model.alias
          -- Rotate Wave Beam and High Jump Boots to face right
          if model.alias == "powerup_wavebeam" or model.alias == "powerup_highjumpboots" then
            pickup.vAng = V3D(0, 1.5, 0)
          end
          break
        end
      end
    end
  end
end

function Scenario.UpdateProgressiveItemModels()
  Game.AddSF(0.1, "Scenario._UpdateProgressiveItemModels", "")
end

function Scenario.OnSubAreaChange(old_subarea, old_actorgroup, new_subarea, new_actorgroup, disable_fade)
  Scenario.UpdateProgressiveItemModels()
  Scenario.UpdateRoomName(new_subarea)
end

function Scenario.SetMetroidSpawngroupOnCurrentScenario(created_actor, group_name)
  if created_actor ~= nil and created_actor.sName ~= nil then
    CurrentScenario.currentMetroidSpawngroup = group_name
  end
end

function Scenario.InitGUI()
  Cosmetics.UpdateGUI()
  GUILib.InitCustomUI()
  GUILib.UpdateTotalDNAColor()
  Scenario.UpdateDNACounter()

  if Init.bEnableRoomIds then
    RoomNameGui.Init()
  end

    -- INVALID_UUID = no multiworld => no need to schedule the check
  if Init.sLayoutUUID ~= Scenario.INVALID_UUID then
    if Scenario.checkConnectionSFID ~= nil then
      Game.DelSFByID(Scenario.checkConnectionSFID)
    end
    Scenario.checkConnectionSFID = Game.AddGUISF(2, "Scenario.CheckConnectionState", "")
  end

  -- delete all SF functions
  if Scenario.hideSFID ~= nil then
      Game.DelSFByID(Scenario.hideSFID)
      -- hide old popup
      Scenario.HideAsyncPopup()
  end

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
    local current_save_identifier = Blackboard.GetProp(player_section, "THIS_RANDO_IDENTIFIER") or ""
    if current_save_identifier ~= Init.sThisRandoIdentifier then
      return Scenario.ShowFatalErrorMessage({
          "This save slot was created using a different Randomizer mod.",
          "You must start a New Game from a blank save slot. Returning to title screen.",
      })
    end

    local rando_initialized = Blackboard.GetProp(player_section, "RANDO_GAME_INITIALIZED") or false
    if not rando_initialized then
      Blackboard.SetProp(player_section, "RANDO_GAME_INITIALIZED", "b", true)
      Game.HUDIdleScreenLeave()
      Scenario.ShowText()
    end
  
    Scenario.UpdateProgressiveItemModels()
    if Scenario.showNextSFID ~= nil then
      Game.DelSFByID(Scenario.showNextSFID)
      Scenario.showNextSFID = nil
    end
    if Scenario.hideSFID ~= nil then
      Game.DelSFByID(Scenario.hideSFID)
      Scenario.hideSFID = nil
      -- hide old popup
      Scenario.HideAsyncPopup()
    end

    RL.UpdateRDVClient(true)

    -- Only required for ils test code
    -- if Scenario.CurrentScenarioID == "s000_surface" then
    -- local next_number = (NextScenario % 17) + 1
    --   NextScenario = next_number
    --   local next_scenario = ALL_SCENARIOS[next_number]
    --   Game.AddSF(0.5, "Game.LoadScenario", "ssssi", "c10_samus", next_scenario, Init.sStartingActor, "samus", 1)
    -- else
    --   Game.AddSF(1.0, "Game.KillPlayer", "")
    -- end
  else
    RL.GetGameStateAndSend()
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
  Game.FadeOutStream(0.0)
  Game.AddPSF(0.1, "Game.LoadScenario", "ssssi", "c10_samus", target_scenario, target_spawnpoint, "", 1)
  Game.ForceConvertToSamus()
end

function Scenario.CheckConnectionState()
  GUILib.UpdateConnected(not RL.Connected())
  Scenario.checkConnectionSFID = Game.AddGUISF(2, "Scenario.CheckConnectionState", "")
end

local fatal_messages_seen = 0
local fatal_messages
function Scenario._ShowNextFatalErrorMessage()
  fatal_messages_seen = fatal_messages_seen + 1
  if fatal_messages_seen > #fatal_messages then
      Scenario.FadeOutAndGoToMainMenu(0.3)
      return
  end
  GUI.LaunchMessage(fatal_messages[fatal_messages_seen], "Scenario._ShowNextFatalErrorMessage", "")
end
function Scenario.ShowFatalErrorMessage(messageBoxes)
  Game.HUDIdleScreenLeave()
  fatal_messages_seen = 0
  fatal_messages = messageBoxes
  Game.AddSF(0.8, Scenario._ShowNextFatalErrorMessage, "")
end

function Scenario.UpdateRoomName(new_subarea)
  Game.AddSF(0.0, "RoomNameGui.Update", "s", new_subarea)
end

function Scenario.RandoOnElevatorUse(from_actor, _ARG_1_, _ARG_2_)
  local destination = ElevatorDestinations[Scenario.CurrentScenarioID][from_actor.sName]
  Game.AddGUISF(0.5, GUI.ElevatorStartUseActionStep2InterArea, "")
  Elevator.Use("c10_samus", destination.scenario, destination.actor, _ARG_2_)
end

Scenario.QueuedPopups = Scenario.QueuedPopups or Queue()

function Scenario.ShowIfNotActive()
  
  if Scenario.hideSFID == nil and Scenario.showNextSFID == nil then
    Scenario.ShowNextAsyncPopup()
  end
end

function Scenario.QueueAsyncPopup(text, time)
  Scenario.QueuedPopups:push({Text = text, Time = time or 5.0})
  Scenario.ShowIfNotActive()
end

function Scenario.ShowNextAsyncPopup()
  if Scenario.QueuedPopups:empty() then
      Scenario.showNextSFID = nil
      return
  end
  local popup = Scenario.QueuedPopups:peek()
  Scenario.ShowAsyncPopup(popup.Text, popup.Time)
end

function Scenario.ShowAsyncPopup(text, time)
  GUILib.ShowMessage(text)
  Scenario.hideSFID = Game.AddGUISF(time, "Scenario.HideAsyncPopup", "")
  Scenario.showNextSFID = nil
end

function Scenario.HideAsyncPopup()
  if not Scenario.QueuedPopups:empty() then
      Scenario.QueuedPopups:pop()
  end
  GUILib.HideMessage()
  Scenario.showNextSFID = Game.AddGUISF(0.5, "Scenario.ShowNextAsyncPopup", "")
  Scenario.hideSFID = nil
end

function Scenario.ShowMessage(text)
  GUILib.ShowMessage(text)
  Game.AddSF(5.0, "GUILib.HideMessage", "")
end
