Metroid = Metroid or {}
function Metroid.Dummy()
end

function Metroid.RemoveMetroid(_ARG_0_)
    local spawnGroupName = CurrentScenario.currentMetroidSpawngroup
    if spawnGroupName ~= nil then
        -- disable multi arena gamma spawngroups
        if #spawnGroupName == 14 then
            local allDead = "Arena_" .. string.sub(spawnGroupName, 4, -3) .. "_AllDead"
            local gamma = string.sub(spawnGroupName, 10, 14)
            if spawnGroupName == "SG_Gamma_" .. gamma then
                Scenario.WriteToBlackboard("entity_" .. "TG_Gamma_" .. gamma .."_enabled", "b", false)
            end
            Scenario.WriteToBlackboard(allDead, "b", true)
        end

        local spawnGroup = Game.GetEntity(spawnGroupName)
        if spawnGroup ~= nil and spawnGroup.SPAWNGROUP ~= nil then
            spawnGroup.SPAWNGROUP:DisableSpawnGroup()
            Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_dead", "b", true)
            Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_deaths", "i", 1)
            Scenario.WriteToBlackboard("entity_" .. spawnGroupName .. "_enabled", "b", false)
        end

        local count = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT") + 1
        Game.SetItemAmount(Game.GetPlayerName(), "ITEM_METROID_COUNT", count)
        Game.IncrementMetroidTotalCount(0)

        local scenario = Scenario.CurrentScenarioID
        if scenario ~= nil and Metroid.Pickups ~= nil and
                Metroid.Pickups[scenario] ~= nil and
                Metroid.Pickups[scenario][spawnGroupName] ~= nil and
                Metroid.Pickups[scenario][spawnGroupName].OnPickedUp ~= nil then
            Metroid.Pickups[scenario][spawnGroupName].OnPickedUp(spawnGroupName)
        end
        Game.SetInGameMusicState("RELAX")
        if scenario == "s000_surface" then
            Game.DisableTrigger("TG_Intro_Alpha")
            Scenario.WriteToBlackboard("alpha_killed", "b", true)
        end
        Game.SaveGame("checkpoint", "AfterNewAbilityAcquired", "", true)
    else
        GUI.LaunchMessage("Oops 2", "Metroid.Dummy", "")
    end
    CurrentScenario.currentMetroidSpawngroup = nil
end

Metroid.Pickups = TEMPLATE("mapping")
