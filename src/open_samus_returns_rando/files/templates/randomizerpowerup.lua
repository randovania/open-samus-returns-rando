RandomizerPowerup = RandomizerPowerup or {}
function RandomizerPowerup.main()
end

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

function RandomizerPowerup.ObjectiveComplete()
    if Game.GetItemAmount(Game.GetPlayerName(), "ITEM_ADN") == 39 then
        local baby = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_BABY_HATCHLING")
        local dnaCounter = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.DNACounter")
        GUI.SetProperties(dnaCounter, {
            ColorR = "0.60392",
            ColorG = "0.61569",
            ColorB = "0.04314",
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

function RandomizerPowerup.IncreaseMissileCheckValue()
    -- Update the min missile reserve tank refill value (capped by config)
    if RandomizerPowerup.GetItemAmount("ITEM_MISSILE_CHECK") ~= nil and RandomizerPowerup.GetItemAmount("ITEM_WEAPON_MISSILE_LAUNCHER") > 0 then
        RandomizerPowerup.SetItemAmount("ITEM_MISSILE_CHECK", RandomizerPowerup.GetItemAmount("ITEM_WEAPON_MISSILE_MAX"))
    end
end

function RandomizerPowerup.EnableMissileReserveTank()
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_ACTIVE", "b", true)
    Blackboard.SetProp("GAME", "ITEM_RESERVE_TANK_MISSILE_FULL", "b", true)
    Game.AddSF(0.0, "Game.HUDIdleScreenGo", "")
    Game.AddSF(0.5, "Game.HUDIdleScreenLeave", "")
end
