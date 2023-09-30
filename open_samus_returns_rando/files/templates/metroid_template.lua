Metroid = {}
function Metroid.Dummy()
end

function Metroid.RemoveMetroid(_ARG_0_)
    local spawnGroupName = CurrentScenario.currentMetroidSpawngroup
    if spawnGroupName ~= nil then
        -- GUI.LaunchMessage(spawnGroupName, "Metroid.Dummy", "")

        local spawnGroup =  Game.GetEntity(spawnGroupName)
        if spawnGroup ~= nil and spawnGroup.SPAWNGROUP ~= nil then
            spawnGroup.SPAWNGROUP:DisableSpawnGroup()
        else 
            GUI.LaunchMessage("Oops 1" .. spawnGroupName, "Metroid.Dummy", "")
            return
        end

        Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_dead", "b", true)
        Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_deaths", "i", 1)
        Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_enabled", "b", false)
        Scenario.WriteToBlackboard("entity_" .. "Alpha_001" .. "_dead", "b", true)
        Scenario.WriteToBlackboard("entity_" .. "Alpha_001" .. "_deaths", "i", 1)
        Scenario.WriteToBlackboard("entity_" .. "Alpha_001" .. "_enabled", "b", false)
        
        local count = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT") + 1
        Game.SetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT", count)
        Game.IncrementMetroidTotalCount(0)

        CurrentScenario.currentMetroidSpawngroup = nil

        Metroid.Pickups[Scenario.CurrentScenarioID][spawnGroupName].OnPickedUp()

        -- TODO: This is only for tests
        -- Game.SaveGame("checkpoint", "Bla", "ST_SG_Alpha_004_Out", true)
    else
        GUI.LaunchMessage("Oops 2", "Metroid.Dummy", "")
    end
end

Metroid.Pickups = TEMPLATE("mapping")