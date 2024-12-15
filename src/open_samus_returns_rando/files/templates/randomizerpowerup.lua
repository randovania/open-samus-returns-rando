Game.ImportLibrary("system/scripts/guilib.lua", false)

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

    if item_id == "ITEM_CURRENT_SPECIAL_ENERGY" then
        local specialEnergy = Game.GetPlayer().SPECIALENERGY
        specialEnergy.fMaxEnergy = capacity
        specialEnergy.fEnergy = capacity
    end

    if Init.bTanksRefillAmmo then
        local tank = Game.GetPlayer().INVENTORY
        if item_id == "ITEM_WEAPON_MISSILE_CURRENT" then
            tank:SetItemAmount(item_id, capacity)
        elseif item_id == "ITEM_WEAPON_SUPER_MISSILE_CURRENT" then
            tank:SetItemAmount(item_id, capacity)
        elseif item_id == "ITEM_WEAPON_POWER_BOMB_CURRENT" then
            tank:SetItemAmount(item_id, capacity)
        end
    end
end

function RandomizerPowerup.OnPickedUp(resources, actorOrName)
    local granted = RandomizerPowerup.HandlePickupResources(resources, actorOrName)

    for _, resource in ipairs(granted) do
        RandomizerPowerup.IncreaseAmmo(resource)
    end

    Scenario.UpdateProgressiveItemModels()
    if actorOrName ~= nil then
        RandomizerPowerup.PostCollectionAdjustments(actorOrName)
    end
    RandomizerPowerup.IncrementInventoryIndex()
    RL.UpdateRDVClient(false)
    hud.UpdatePlayerInfo(true)
    return granted
end

function RandomizerPowerup.IncrementInventoryIndex()
    local playerSection = Game.GetPlayerBlackboardSectionName()
    local propName = "InventoryIndex"
    local currentIndex = Blackboard.GetProp(playerSection, propName) or 0
    currentIndex = currentIndex + 1
    Blackboard.SetProp(playerSection, propName, "f", currentIndex)
end

function RandomizerPowerup.PropertyForLocation(actorOrName)
    return "c_" .. actorOrName
end

function RandomizerPowerup.PostCollectionAdjustments(actorOrName)
    local name
    -- normal pickups
    if actorOrName.sName ~= nil then
        name = actorOrName.sName
    -- metroids
    else
        name = actorOrName
    end
    -- remote pickups from other worlds
    if name == nil then
        return
    end
    RandomizerPowerup.MarkLocationCollected(name)
    RandomizerPowerup.ActivateSpecialEnergy(name)
end

function RandomizerPowerup.MarkLocationCollected(name)
    local playerSection = Game.GetPlayerBlackboardSectionName()
    local currentScenario = Scenario.CurrentScenarioID
    local propScenario = currentScenario

    if currentScenario == "s110_surfaceb" and (name == "LE_Item_002" or name == "LE_Item_003") then
        propScenario = "s000_surface"
    end

    local propName = RandomizerPowerup.PropertyForLocation(string.format("%s_%s", propScenario, name))
    Blackboard.SetProp(playerSection, propName, "b", true)
end

function RandomizerPowerup.ActivateSpecialEnergy(name)
    local cloud = "TG_SpecialEnergyCloud"

    -- Powerups
    if string.sub(name, 0, 7) == "LE_Powe" then
        local powerup = string.find(name, "_", 4)
        local trigger = cloud .. string.sub(name, powerup)
        if Game.GetEntity(trigger) ~= nil then
            SpecialEnergyCloud.ActivateSpecialEnergy(trigger)
        end
    -- Aeion abilities
    elseif string.sub(name, 0, 17) == "LE_SpecialAbility" then
        SpecialEnergyCloud.ActivateSpecialEnergy(cloud)
    end
end

function RandomizerPowerup.HandlePickupResources(progression, actorOrName)
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
                    -- don't update with quantity of 0, which means it is a coop dna
                    if string.sub(resource.item_id, 0, 14) == "ITEM_RANDO_DNA" and resource.quantity > 0 then
                        local scenario = Init.tScenarioMapping[Scenario.CurrentScenarioID]
                        local currentDNA =  Blackboard.GetProp("GAME", scenario .."_acquired_dna") or 0
                        -- it should be nil only for offworld DNA and then we don't want increment the scenario DNA
                        if actorOrName ~= nil then
                            Blackboard.SetProp("GAME", scenario .. "_acquired_dna", "i", currentDNA + 1)
                        end
                        Scenario.UpdateDNACounter()
                        RandomizerPowerup.IncreaseItemAmount("ITEM_ADN", -1 * resource.quantity)
                        RandomizerPowerup.ObjectiveComplete()
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

function RandomizerPowerup.ObjectiveComplete()
    if RandomizerPowerup.GetItemAmount("ITEM_ADN") == 0 and not Blackboard.GetProp("GAME", "OBJECTIVE_COMPLETE") then
        Blackboard.SetProp("GAME", "OBJECTIVE_COMPLETE", "b", true)
        Game.HUDIdleScreenLeave()
        GUILib.BlinkTotalDNACounter()
        Game.AddGUISF(3, "GUILib.DisableBlinkTotalDNACounter", "")

        -- Assign boss names and areas to each boss
        local boss = Init.sFinalBoss
        local boss_name = boss
        local boss_area = ""
        if boss == "Arachnus" then
            boss_area = "Area 2 Dam Exterior"
        elseif boss == "Diggernaut" then
            boss_area = "Area 6"
        elseif boss == "Queen" then
            boss_name = "the Queen"
            boss_area = "Area 8"
        elseif boss == "Ridley" then
            boss_name = "Proteus Ridley"
            boss_area = "Surface West"
        end

        -- Handle the message depending the boss/other factors
        local baby = RandomizerPowerup.GetItemAmount("ITEM_BABY_HATCHLING")
        local message = "Enough Metroid DNA has been collected!\nThe path to " .. boss_name .. " has been opened in " .. boss_area .. "!"
        if baby > 0 then
            GUI.LaunchMessage(message, "RandomizerPowerup.Dummy", "")
            if Scenario.CurrentScenarioID == "s110_surfaceb" and boss == "Ridley" then
                Game.PlayMusicStream(0, "streams/music/k_crateria99.wav", -1, -1, -1, 2, 2, 1)
            end
        elseif baby == 0 then
            if boss == "Ridley" then
                GUI.LaunchMessage("Enough Metroid DNA has been collected!\n" .. Init.sBabyMetroidHint, "RandomizerPowerup.Dummy", "")
            else
                GUI.LaunchMessage(message .. "\n" .. Init.sBabyMetroidHint, "RandomizerPowerup.Dummy", "")
            end
        end
    end
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
    local reserve = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.ReserveTankM")
    GUI.SetProperties(reserve, { Enabled = true })
    Game.GetPlayerInfo():FillMissileReserveTank()
end
