Metroid = {}
function Metroid.Dummy()
end

function Metroid.DisableSpawnGroup(spawnGroupName)
    local spawnGroup = Game.GetEntity(spawnGroupName)
    if spawnGroup ~= nil and spawnGroup.SPAWNGROUP ~= nil then
        spawnGroup.SPAWNGROUP:DisableSpawnGroup()
        Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_dead", "b", true)
        Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_deaths", "i", 1)
        Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_enabled", "b", false)
    end
end

function Metroid.DelayedDelete(spawnGroupName)
    Game.DeleteEntity(spawnGroupName)
    if spawnGroupName == "SG_Gamma_001_A" then
        CurrentScenario.OnEnter_Gamma_001_Dead()
    elseif spawnGroupName == "SG_Gamma_002_A" then
        CurrentScenario.OnEnter_Gamma_002_Dead()
    elseif spawnGroupName == "SG_Gamma_004_B" then
        CurrentScenario.OnEnter_Gamma_004_Dead()
    elseif spawnGroupName == "SG_Gamma_005_C" then
        CurrentScenario.OnEnter_Gamma_005_Dead()
    elseif spawnGroupName == "SG_Gamma_007_A" then
        CurrentScenario.OnEnter_Gamma_007_Dead()
    end
    -- TODO: Is the name allowed to be random?
    Game.SaveGame("checkpoint", "AfterNewAbilityAcquired", "", true)
end

function Metroid.RemoveMetroid(_ARG_0_)
    local spawnGroupName = CurrentScenario.currentMetroidSpawngroup
    if spawnGroupName ~= nil then
        -- disable all spawn groups in case of multi arena gamma
        if CurrentScenario.isMultiGamma then
            local endingLetters = {"A", "B", "C"}
            for index, letter in pairs(endingLetters) do
                local otherSpawnGroupName = string.sub(spawnGroupName, 0, -2) .. letter
                Metroid.DisableSpawnGroup(otherSpawnGroupName)
            end
            local allDead = "Arena_" .. string.sub(spawnGroupName, 4, -3) .. "_AllDead"
            Scenario.WriteToBlackboard(allDead, "b", true)
            Game.AddSF(4.0, "Metroid.DelayedDelete", "s", spawnGroupName)
        -- disable single arena metroid
        else
            Metroid.DisableSpawnGroup(spawnGroupName)
        end

        local count = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT") + 1
        Game.SetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT", count)
        Game.IncrementMetroidTotalCount(0)

        local scenario = Scenario.CurrentScenarioID
        if scenario ~= nil and Metroid.Pickups ~= nil and
                Metroid.Pickups[scenario] ~= nil and
                Metroid.Pickups[scenario][spawnGroupName] ~= nil and
                Metroid.Pickups[scenario][spawnGroupName].OnPickedUp ~= nil then
            Metroid.Pickups[scenario][spawnGroupName].OnPickedUp()
        end
        Game.SetInGameMusicState("RELAX")
        if not CurrentScenario.isMultiGamma then
        -- TODO: Is the name allowed to be random?
            Game.SaveGame("checkpoint", "AfterNewAbilityAcquired", "", true)
        end
    else
        GUI.LaunchMessage("Oops 2", "Metroid.Dummy", "")
    end
    CurrentScenario.currentMetroidSpawngroup = nil
    CurrentScenario.isMultiGamma = nil
end

Metroid.Pickups = TEMPLATE("mapping")
