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
        -- disable single arena metroid
        else
            Metroid.DisableSpawnGroup(spawnGroupName)
        end

        local count = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT") + 1
        Game.SetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT", count)
        Game.IncrementMetroidTotalCount(0)

        CurrentScenario.currentMetroidSpawngroup = nil
        CurrentScenario.isMultiGamma = nil

        local scenario = Scenario.CurrentScenarioID
        if scenario ~= nil and Metroid.Pickups ~= nil and
                Metroid.Pickups[scenario] ~= nil and
                Metroid.Pickups[scenario][spawnGroupName] ~= nil and
                Metroid.Pickups[scenario][spawnGroupName].OnPickedUp ~= nil then
            Metroid.Pickups[scenario][spawnGroupName].OnPickedUp()
        end
        Game.SetInGameMusicState("RELAX")
    else
        GUI.LaunchMessage("Oops 2", "Metroid.Dummy", "")
    end
end

Metroid.Pickups = TEMPLATE("mapping")
