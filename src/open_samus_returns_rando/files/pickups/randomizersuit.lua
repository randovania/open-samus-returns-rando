Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerSuit = RandomizerSuit or {}
function RandomizerSuit.main()
end

function RandomizerSuit.ResetLiquidState()
    -- When collecting an item in a liquid, the liquid must be disabled if the item is Gravity,
    -- otherwise Samus' movement is permanently Gravityless, even after exiting the liquid.
    -- Liquids without items must also be disabled if Gravity is recieved during a multiworld
    if Game.GetPlayer().MODELUPDATER.sModelAlias ~= "Gravity" then
        local scenario = Scenario.CurrentScenarioID
        -- both loops cover repeated/similar actor names that are shared across scenarios
        if scenario ~= "s000_surface" and scenario ~= "s010_area1" and scenario ~= "s110_surfaceb" then
            local waterPrefixes = {"TG_Water_", "TG_SP_Water_"}
            for i = 1, 2 do
                for j = 1, 19 do
                    local water = Game.GetEntity(waterPrefixes[i] .. string.format("%03d", j))
                    if water ~= nil and water.TRIGGER:IsPlayerInside() == true then
                        water.TRIGGER:DisableTrigger()
                        water.TRIGGER:EnableTrigger()
                    end
                end
            end
        end
        for i = 1, 5 do
            local lavaScenarios = {"s020_area2", "s033_area3b", "s036_area3c", "s040_area4", "s050_area5"}
            if scenario == lavaScenarios[i] then
                for j = 1, 5 do
                    lava = Game.GetEntity("TG_Lava_" .. string.format("%03d", j))
                    if lava ~= nil and lava.TRIGGER:IsPlayerInside() == true then
                        lava.TRIGGER:DisableTrigger()
                        lava.TRIGGER:EnableTrigger()
                    end
                end
            end
        end
        -- individual scenarios are listed if they have unique actor names
        local liquids = {}
        if scenario == "s000_surface" then
            liquids = {"TG_Water", "TG_Water001"}
        elseif scenario == "s010_area1" then
            liquids = {"HazardousPuddle_001", "Lava_Trigger_001", "TG_Water_001", "Water_Trigger_002",
            "Water_Trigger_008", "Water_Trigger_009", "Water_Trigger_010", "Water_Trigger_011"}
        elseif scenario == "s036_area3c" then
            liquids = {"TG_Water002", "TG_Water003", "TG_LS_Water004"}
        elseif scenario == "s040_area4" then
            liquids = {"TG_HazardousPuddle_001", "TG_HazardousPuddle_002", "TG_HazardousPuddle_003",
                "TG_HazardousPuddle_004", "TG_HazardousPuddle_005"}
        elseif scenario == "s065_area6b" then
            liquids = {"TG_LS_Water_001"}
        elseif scenario == "s070_area7" then
            liquids = {"TG_Damage_Hazardous_001", "TG_Damage_Hazardous_002"}
        end
        for i = 1, #liquids do
            local liquid = Game.GetEntity(liquids[i])
            if liquid.TRIGGER:IsPlayerInside() == true then
                Game.GetEntity(liquid[i]).TRIGGER:DisableTrigger()
                Game.GetEntity(liquid[i]).TRIGGER:EnableTrigger()
            end
        end
    end
end

function RandomizerSuit.OnPickedUp(progression, actorOrName)
    RandomizerSuit.ResetLiquidState()
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    if Game.GetItemAmount(Game.GetPlayerName(), "ITEM_GRAVITY_SUIT") > 0 then
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Gravity"
    else
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Varia"
    end
    Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
end