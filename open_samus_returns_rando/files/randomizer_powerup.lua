Game.LogWarn(0, "Loading randomizer_powerup.lua...")

RandomizerPowerup = {}
function RandomizerPowerup.main()
end

function RandomizerPowerup.OnPickedUp()
=======
RandomizerPowerup.tProgressiveModels = {}

RandomizerPowerup.Self = nil

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
end

function RandomizerPowerup.PropertyForLocation(locationIdentifier)
    return "Location_Collected_" .. locationIdentifier
end

function RandomizerPowerup.MarkLocationCollected(locationIdentifier)
    local playerSection = Game.GetPlayerBlackboardSectionName()
    local propName = RandomizerPowerup.PropertyForLocation(locationIdentifier)
    Game.LogWarn(0, propName)
    Blackboard.SetProp(playerSection, propName, "b", true)
end

function RandomizerPowerup.IncrementInventoryIndex()
    local playerSection = Game.GetPlayerBlackboardSectionName()
    local propName = "InventoryIndex"
    local currentIndex = Blackboard.GetProp(playerSection, propName) or 0
    currentIndex = currentIndex + 1
    Blackboard.SetProp(playerSection, propName, "f", currentIndex)
end

function RandomizerPowerup.OnPickedUp(actor, resources)
    RandomizerPowerup.Self = actor
    local name = "Boss"
    if actor ~= nil then
        name = actor.sName
        RandomizerPowerup.MarkLocationCollected(string.format("%s_%s", Scenario.CurrentScenarioID, name))
    end

    Game.LogWarn(0, "Collected pickup: " .. name)
    local granted = RandomizerPowerup.HandlePickupResources(resources)

    for _, resource in ipairs(granted) do
        RandomizerPowerup.IncreaseEnergy(resource)
        RandomizerPowerup.IncreaseAmmo(resource)

        RandomizerPowerup.CheckArtifacts(resource)
    end

    RandomizerPowerup.ApplyTunableChanges()
    Scenario.UpdateProgressiveItemModels()
    RandomizerPowerup.IncrementInventoryIndex()
    RL.UpdateRDVClient(false)
    return granted
end

function RandomizerPowerup.HandlePickupResources(progression)
    progression = progression or {}

    local alwaysGrant = false

    if #progression == 0 then
        return {}
    elseif #progression == 1 then
        alwaysGrant = true
    end

    Game.LogWarn(0, "Resources:")
    for _, resource_list in ipairs(progression) do
        local data = "  - "
        for _, resource in ipairs(resource_list) do
            data = data .. resource.item_id .. " (" .. resource.quantity .. ") / "
        end
        Game.LogWarn(0, data)
    end

    -- For each progression stage, if the player does not have the FIRST item in that stage, the whole stage is granted
    for _, resource_list in ipairs(progression) do
        -- Check if we need to grant anything from this progression stage

        if #resource_list > 0 then
            local current = RandomizerPowerup.GetItemAmount(resource_list[1].item_id)
            local shouldGrant = alwaysGrant or current < resource_list[1].quantity

            if shouldGrant then
                for _, resource in ipairs(resource_list) do
                    Game.LogWarn(0, "Granting " .. resource.quantity .. " " .. resource.item_id)
                    RandomizerPowerup.IncreaseItemAmount(resource.item_id, resource.quantity)
                end

                return resource_list
            end
        end

        -- Otherwise, loop to next progression stage (or fall out of loop)
    end

    return {} -- nothing granted after final stage of progression is reached
end

function RandomizerPowerup.ChangeSuit()
    -- ordered by priority
    local suits = {
        {item = "ITEM_GRAVITY_SUIT", model = "Gravity"},
        {item = "ITEM_VARIA_SUIT", model = "Varia"},
    }
    local model_updater = Game.GetPlayer().MODELUPDATER
    for _, suit in ipairs(suits) do
        if suit.model == model_updater.sModelAlias then break end
        if RandomizerPowerup.HasItem(suit.item) then
            Game.AddPSF(0.1, RandomizerPowerup.Delayed_ChangeSuit, "s", suit.model)
            break
        end
    end
end

MAX_ENERGY = 1499
function RandomizerPowerup.IncreaseEnergy(resource)
    -- No resource, quit
    if not resource then return end

    local item_id = resource.item_id

    -- Not etank, quit
    if item_id ~= "ITEM_ENERGY_TANKS" then return end

    local energy = Init.fEnergyPerTank

    Game.LogWarn(0, "Increasing player energy.")

    local new_max = RandomizerPowerup.GetItemAmount("ITEM_MAX_LIFE") + energy
    new_max = math.min(new_max, MAX_ENERGY)

    local new_current = new_max

    RandomizerPowerup.SetItemAmount("ITEM_MAX_LIFE", new_max)
    RandomizerPowerup.SetItemAmount("ITEM_CURRENT_LIFE", new_current)

    local life = Game.GetPlayer().LIFE
    life.fMaxLife = new_max
    life.fCurrentLife = new_current
end

MAX_AEION = 2000
function RandomizerPowerup.IncreaseAeion(resource)
    if not resource then return end
    
    local item_id = resource.item_id

    -- Not aeion tank, quit
    if item_id ~= "ITEM_SENERGY_TANKS" then return end

    local aeion = Init.fAeionPerTank

    Game.LogWarn(0, "Increasing player aeion.")

    local new_max = RandomizerPowerup.GetItemAmount("ITEM_MAX_SPECIAL_ENERGY") + aeion
    new_max = math.min(new_max, MAX_AEION)

    local new_current = new_max

    RandomizerPowerup.SetItemAmount("ITEM_MAX_SPECIAL_ENERGY", new_max)
    RandomizerPowerup.SetItemAmount("ITEM_CURRENT_SPECIAL_ENERGY", new_current)

    local energy = Game.GetPlayer().SPECIALENERGY
    energy.fMaxEnergy = new_max
    energy.fEnergy = new_current
end

function RandomizerPowerup.IncreaseAmmo(resource)
    if not resource then return end

    local current_id = nil

    if resource.item_id == "ITEM_WEAPON_POWER_BOMB_MAX" then
        current_id = "ITEM_WEAPON_POWER_BOMB_CURRENT"
    elseif resource.item_id == "ITEM_WEAPON_SUPER_MISSILE_MAX" then
        current_id = "ITEM_WEAPON_SUPER_MISSILE_CURRENT"
    elseif resource.item_id == "ITEM_WEAPON_MISSILE_MAX" then
        current_id = "ITEM_WEAPON_MISSILE_CURRENT"
    end

    if current_id == nil then return end

    RandomizerPowerup.IncreaseItemAmount(current_id, resource.quantity, resource.item_id)
end

local tItemTunableHandlers = {
    ["ITEM_SPECIAL_ENERGY_SCANNING_PULSE"] = function(quantity)
        -- Amount of Aeion used by Scan Pulse
        Scenario.SetTunableValue("CTunableAbilityScanningPulse", "fConsumptionOnActivation", quantity = 0 )
}

function RandomizerPowerup.ApplyTunableChanges()
    Game.AddSF(0, "RandomizerPowerup._ApplyTunableChanges", "")
end

function RandomizerPowerup._ApplyTunableChanges()
    for item, handler in pairs(tItemTunableHandlers) do
        local totalQuantity = RandomizerPowerup.GetItemAmount(item)

        Game.LogWarn(0, "Calling tunable handler for " .. item .. " = " .. totalQuantity)

        handler(totalQuantity)
    end
end

-- Main Supers
RandomizerSuperMissile = {}
setmetatable(RandomizerSuperMissile, {__index = RandomizerPowerup})
function RandomizerSuperMissile.OnPickedUp(actor, progression)
    progression = progression or {{{ item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX", quantity = 0 }}}
    RandomizerPowerup.OnPickedUp(actor, progression)
end

-- Main PBs
RandomizerPowerBomb = {}
setmetatable(RandomizerPowerBomb, {__index = RandomizerPowerup})
function RandomizerPowerBomb.OnPickedUp(actor, progression)
    progression = progression or {{{ item_id = "ITEM_WEAPON_POWER_BOMB_MAX", quantity = 0 }}}
    RandomizerPowerup.OnPickedUp(actor, progression)
end