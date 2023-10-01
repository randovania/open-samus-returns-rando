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
        
        local count = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT") + 1
        Game.SetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT", count)
        Game.IncrementMetroidTotalCount(0)

        CurrentScenario.currentMetroidSpawngroup = nil

        local scenario = Scenario.CurrentScenarioID
        if scenario ~= nil and Metroid.Pickups ~= nil and
            Metroid.Pickups[scenario] ~= nil and 
            Metroid.Pickups[scenario][spawnGroupName] ~= nil and
            Metroid.Pickups[scenario][spawnGroupName].OnPickedUp ~= nil then
                Metroid.Pickups[scenario][spawnGroupName].OnPickedUp()
        end
    else
        GUI.LaunchMessage("Oops 2", "Metroid.Dummy", "")
    end
end

Metroid.Pickups = TEMPLATE("mapping")