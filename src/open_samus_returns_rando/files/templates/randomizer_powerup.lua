if RandomizerPowerup == nil then

    RandomizerPowerup = RandomizerPowerup or {}
    function RandomizerPowerup.main()
    end

    RandomizerPowerup.tProgressiveModels = {}

    RandomizerPowerup.Self = nil

    function RandomizerPowerup.Dummy()
    end


    function RandomizerPowerup.SetItemAmount(item_id, quantity)
        if type(quantity) == "string" then
            quantity = RandomizerPowerup.GetItemAmount(quantity)
        end
        Game.SetItemAmount(Game.GetPlayerName(), item_id, quantity)
    end

    function RandomizerPowerup.GetItemAmount(item_id)
        return Game.GetItemAmount(Game.GetPlayerName(), item_id)
    end

    function RandomizerPowerup.HasItem(item_id)
        return RandomizerPowerup.GetItemAmount(item_id) > 0
    end

    function RandomizerPowerup.IncreaseItemAmount(item_id, quantity, capacity)
        local target = RandomizerPowerup.GetItemAmount(item_id) + quantity
        if capacity ~= nil then
            if type(capacity) == "string" then
                capacity = RandomizerPowerup.GetItemAmount(capacity)
            end
            target = math.min(target, capacity)
        end
        target = math.max(target, 0)
        RandomizerPowerup.SetItemAmount(item_id, target)

        local itemAmount = Game.GetPlayer().INVENTORY
        if item_id == "ITEM_CURRENT_SPECIAL_ENERGY" then
            local specialEnergy = Game.GetPlayer().SPECIALENERGY
            specialEnergy.fMaxEnergy = capacity
            specialEnergy.fEnergy = capacity
        elseif item_id == "ITEM_WEAPON_MISSILE_CURRENT" then
            itemAmount:SetItemAmount(item_id, capacity)
        elseif item_id == "ITEM_WEAPON_SUPER_MISSILE_CURRENT" then
            itemAmount:SetItemAmount(item_id, capacity)
        elseif item_id == "ITEM_WEAPON_POWER_BOMB_CURRENT" then
            itemAmount:SetItemAmount(item_id, capacity)
        end
    end

    function RandomizerPowerup.OnPickedUp(resources)
        local granted = RandomizerPowerup.HandlePickupResources(resources)

        for _, resource in ipairs(granted) do
            RandomizerPowerup.IncreaseAmmo(resource)
        end

        Scenario.UpdateProgressiveItemModels()

        return granted
    end

    function RandomizerPowerup.ResetLiquidState()
        -- When collecting an item in a liquid, the liquid must be disabled if the item is Gravity,
        -- otherwise Samus' movement is permanently Gravityless, even after exiting the liquid.
        -- Liquids without items must also be disabled if Gravity is recieved during a multiworld
        if Game.GetPlayer().MODELUPDATER.sModelAlias ~= "Gravity" then
            local scenario = Scenario.CurrentScenarioID
            -- both loops cover repeated/similar actor names that are shared across scenarios
            if scenario ~= "s000_surface" and scenario ~= "s010_area1" and scenario ~= "s110_surfaceb" then
                local waterPrefixes = {"TG_Water_", "TG_SP_Water_"}
                local waterNumbers = {"001", "002", "003", "004", "005", "006", "007", "008", "009", "010", "011", "012",
                    "013", "014", "015", "016", "017", "018", "019"}
                for i = 1, 2 do
                    for j = 1, 19 do
                        local water = Game.GetEntity(waterPrefixes[i] .. waterNumbers[j])
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
                        local lavaNumbers = {"001", "002", "003", "004", "005"}
                        lava = Game.GetEntity("TG_Lava_" .. lavaNumbers[j])
                        if lava ~= nil and lava.TRIGGER:IsPlayerInside() == true then
                            lava.TRIGGER:DisableTrigger()
                            lava.TRIGGER:EnableTrigger()
                        end
                    end
                end
            end
            -- individual scenarios are listed if they have unique actor names
            local liquids = {}
            local arrayLength = 0
            if scenario == "s000_surface" then
                liquids = {"TG_Water", "TG_Water001"}
                arrayLength = 2
            elseif scenario == "s010_area1" then
                liquids = {"HazardousPuddle_001", "Lava_Trigger_001", "TG_Water_001", "Water_Trigger_002",
                "Water_Trigger_008", "Water_Trigger_009", "Water_Trigger_010", "Water_Trigger_011"}
                arrayLength = 8
            elseif scenario == "s036_area3c" then
                liquids = {"TG_Water002", "TG_Water003", "TG_LS_Water004"}
                arrayLength = 3
            elseif scenario == "s040_area4" then
                liquids = {"TG_HazardousPuddle_001", "TG_HazardousPuddle_002", "TG_HazardousPuddle_003",
                    "TG_HazardousPuddle_004", "TG_HazardousPuddle_005"}
                arrayLength = 5
            elseif scenario == "s065_area6b" then
                liquids = {"TG_LS_Water_001"}
                arrayLength = 1
            elseif scenario == "s070_area7" then
                liquids = {"TG_Damage_Hazardous_001", "TG_Damage_Hazardous_002"}
                arrayLength = 1
            end
            for i = 1, arrayLength do
                local liquid = Game.GetEntity(liquids[i])
                if liquid.TRIGGER:IsPlayerInside() == true then
                    Game.GetEntity(liquid[i]).TRIGGER:DisableTrigger()
                    Game.GetEntity(liquid[i]).TRIGGER:EnableTrigger()
                end
            end
        end
    end

    function RandomizerPowerup.ObjectiveComplete()
        if Game.GetItemAmount(Game.GetPlayerName(), "ITEM_ADN") == 39 then
            local baby = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_BABY_HATCHLING")
            local dnaCounter = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNACounter")
            GUI.SetProperties(dnaCounter, {
                ColorR = "0.90908",
                ColorG = "0.88627",
                ColorB = "0.66274",
            })
            if baby > 0 then
                GUI.LaunchMessage("All Metroid DNA has been collected!\nThe path to Proteus Ridley has been opened in Surface - West!",
                    "RandomizerPowerup.Dummy", "")
            elseif baby == 0 then
                GUI.LaunchMessage("All Metroid DNA has been collected!\nContinue searching for the Baby Metroid!",
                    "RandomizerPowerup.Dummy", "")
            end
        end
    end

    function RandomizerPowerup.HandlePickupResources(progression)
        progression = progression or {}

        local alwaysGrant = false

        if #progression == 0 then
            return {}
        elseif #progression == 1 then
            alwaysGrant = true
        end

        for _, resource_list in ipairs(progression) do
            local data = "  - "
            for _, resource in ipairs(resource_list) do
                data = data .. resource.item_id .. " (" .. resource.quantity .. ") / "
            end
        end

        -- For each progression stage, if the player does not have the FIRST item in that stage, the whole stage is granted
        for _, resource_list in ipairs(progression) do
            -- Check if we need to grant anything from this progression stage

            if #resource_list > 0 then
                local current = RandomizerPowerup.GetItemAmount(resource_list[1].item_id)
                local shouldGrant = alwaysGrant or current < resource_list[1].quantity

                if shouldGrant then
                    for _, resource in ipairs(resource_list) do
                        RandomizerPowerup.IncreaseItemAmount(resource.item_id, resource.quantity)
                        if string.sub(resource.item_id, 0, 14) == "ITEM_RANDO_DNA" then
                            local scenario = Init.tScenarioMapping[Scenario.CurrentScenarioID]
                            local currentDNA =  Blackboard.GetProp("GAME", scenario .."_acquired_dna") or 0
                            Blackboard.SetProp("GAME", scenario .. "_acquired_dna", "i", currentDNA + 1)
                            Scenario.UpdateDNACounter()
                            RandomizerPowerup.IncreaseItemAmount("ITEM_ADN", resource.quantity)
                            Game.AddSF(0, "RandomizerPowerup.ObjectiveComplete", "")
                        end
                    end

                    return resource_list
                end
            end

            -- Otherwise, loop to next progression stage (or fall out of loop)
        end

        return {} -- nothing granted after final stage of progression is reached
    end


    function RandomizerPowerup.IncreaseAmmo(resource)
        if not resource then return end

        local current_id = nil

        if resource.item_id == "ITEM_WEAPON_MISSILE_MAX" then
            current_id = "ITEM_WEAPON_MISSILE_CURRENT"
        elseif resource.item_id == "ITEM_WEAPON_SUPER_MISSILE_MAX" then
            current_id = "ITEM_WEAPON_SUPER_MISSILE_CURRENT"
        elseif resource.item_id == "ITEM_WEAPON_POWER_BOMB_MAX" then
            current_id = "ITEM_WEAPON_POWER_BOMB_CURRENT"
        elseif resource.item_id == "ITEM_MAX_SPECIAL_ENERGY" then
            current_id = "ITEM_CURRENT_SPECIAL_ENERGY"
        end

        if current_id == nil then return end

        RandomizerPowerup.IncreaseItemAmount(current_id, resource.quantity, resource.item_id)
    end

    MAX_ENERGY= 1099
    function RandomizerPowerup.IncreaseEnergy()
        local energy = Init.fEnergyPerTank
        local new_max = RandomizerPowerup.GetItemAmount("ITEM_MAX_LIFE") + energy
        new_max = math.min(new_max, MAX_ENERGY)
        RandomizerPowerup.SetItemAmount("ITEM_MAX_LIFE", new_max)
        RandomizerPowerup.SetItemAmount("ITEM_CURRENT_LIFE", new_max)

        local life = Game.GetPlayer().LIFE
        life.fMaxLife = new_max
        life.fCurrentLife = new_max
    end

    RandomizerPowerBomb = {}
    setmetatable(RandomizerPowerBomb, {__index = RandomizerPowerup})
    function RandomizerPowerBomb.OnPickedUp(progression)
        local locked_pbs = RandomizerPowerup.GetItemAmount("ITEM_POWER_BOMB_TANKS")
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                if inner.item_id == "ITEM_POWER_BOMB_TANKS" then
                    inner.item_id = "ITEM_WEAPON_POWER_BOMB_MAX"
                    inner.quantity = inner.quantity + locked_pbs
                end
            end
        end
        RandomizerPowerup.OnPickedUp(progression)
        RandomizerPowerup.SetItemAmount("ITEM_POWER_BOMB_TANKS", 0)
    end


    RandomizerPowerBombTank = {}
    setmetatable(RandomizerPowerBombTank, {__index = RandomizerPowerup})
    function RandomizerPowerBombTank.OnPickedUp(progression)
        -- if we have main item use power bomb max else use locked power bombs
        local new_item_id = "ITEM_POWER_BOMB_TANKS"
        local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_POWER_BOMB") > 0
        if is_main_unlocked then
            new_item_id = "ITEM_WEAPON_POWER_BOMB_MAX"
        end

        -- grant locked pbs or new tank
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                inner.item_id = new_item_id
            end
        end
        RandomizerPowerup.OnPickedUp(progression)
    end

    RandomizerSuperMissile = {}
    setmetatable(RandomizerSuperMissile, {__index = RandomizerPowerup})
    function RandomizerSuperMissile.OnPickedUp(progression) 
        local locked_supers = RandomizerPowerup.GetItemAmount("ITEM_SUPER_MISSILE_TANKS")
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                if inner.item_id == "ITEM_SUPER_MISSILE_TANKS" then
                    inner.item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX"
                    inner.quantity = inner.quantity + locked_supers
                end
            end
        end
        RandomizerPowerup.OnPickedUp(progression)
        RandomizerPowerup.SetItemAmount("ITEM_SUPER_MISSILE_TANKS", 0)
    end

    RandomizerSuperMissileTank = {}
    setmetatable(RandomizerSuperMissileTank, {__index = RandomizerPowerup})
    function RandomizerSuperMissileTank.OnPickedUp(progression)
        -- if we have main item use super missile max else use locked supers
        local new_item_id = "ITEM_SUPER_MISSILE_TANKS"
        local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SUPER_MISSILE") > 0
        if is_main_unlocked then
            new_item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX"
        end
        -- grant locked supers or new tank
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                inner.item_id = new_item_id
            end
        end
        RandomizerPowerup.OnPickedUp(progression)
    end

    RandomizerSuit = {}
    setmetatable(RandomizerSuit, {__index = RandomizerPowerup})
    function RandomizerSuit.OnPickedUp(progression)
        RandomizerPowerup.ResetLiquidState()
        RandomizerPowerup.OnPickedUp(progression)
        if Game.GetItemAmount(Game.GetPlayerName(), "ITEM_GRAVITY_SUIT") > 0 then
            Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Gravity"
        else
            Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Varia"
        end
        Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
    end

    RandomizerEnergyTank = {}
    setmetatable(RandomizerEnergyTank, {__index = RandomizerPowerup})
    function RandomizerEnergyTank.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        RandomizerPowerup.IncreaseEnergy()
    end

    RandomizerBabyHatchling = {}
    setmetatable(RandomizerBabyHatchling, {__index = RandomizerPowerup})
    function RandomizerBabyHatchling.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Game.GetDefaultPlayer("Samus").BABYHATCHLINGCREATION:SpawnBaby()
        Game.GetEntity("Baby Hatchling").vPos = Game.GetDefaultPlayer("Samus").vPos
    end

    RandomizerScanningPulse = {}
    setmetatable(RandomizerScanningPulse, {__index = RandomizerPowerup})
    function RandomizerScanningPulse.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Player.SetAbilityUnlocked("ScanningPulse", true)
    end

    RandomizerEnergyShield = {}
    setmetatable(RandomizerEnergyShield, {__index = RandomizerPowerup})
    function RandomizerEnergyShield.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Player.SetAbilityUnlocked("EnergyShield", true)
    end

    RandomizerEnergyWave = {}
    setmetatable(RandomizerEnergyWave, {__index = RandomizerPowerup})
    function RandomizerEnergyWave.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Player.SetAbilityUnlocked("EnergyWave", true)
    end

    RandomizerPhaseDisplacement = {}
    setmetatable(RandomizerPhaseDisplacement, {__index = RandomizerPowerup})
    function RandomizerPhaseDisplacement.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Player.SetAbilityUnlocked("PhaseDisplacement", true)
    end

    RandomizerReserveTankE = {}
    setmetatable(RandomizerReserveTankE, {__index = RandomizerPowerup})
    function RandomizerReserveTankE.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_ACTIVE", "b", true)
        Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_LIFE_FULL", "b", true)
        Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
        Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
    end

    RandomizerReserveTankM = {}
    setmetatable(RandomizerReserveTankM, {__index = RandomizerPowerup})
    function RandomizerReserveTankM.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_ACTIVE", "b", true)
        Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_FULL", "b", true)
        Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
        Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
    end

    RandomizerReserveTankA = {}
    setmetatable(RandomizerReserveTankA, {__index = RandomizerPowerup})
    function RandomizerReserveTankA.OnPickedUp(progression)
        RandomizerPowerup.OnPickedUp(progression)
        Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_ACTIVE", "b", true)
        Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_SPECIAL_ENERGY_FULL", "b", true)
        Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
        Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
    end

    TEMPLATE("custom_code")
end