RandomizerPowerup = {}
function RandomizerPowerup.main()
end

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

function RandomizerPowerup.OnPickedUp(actor, resources)
    RandomizerPowerup.Self = actor
    local granted = RandomizerPowerup.HandlePickupResources(resources)

    RandomizerPowerup.ChangeSuit()

    for _, resource in ipairs(granted) do
        RandomizerPowerup.IncreaseAmmo(resource)
    end

    return granted
end

function RandomizerPowerup.DisableLiquids()
    if Game.GetPlayer().MODELUPDATER.sModelAlias == "Varia" then
        if Scenario.CurrentScenarioID == "s010_area1" then
            Game.GetEntity("Lava_Trigger_001").TRIGGER:DisableTrigger()
        elseif Scenario.CurrentScenarioID == "s067_area6c" then
            Game.GetEntity("TG_SP_Water_002").TRIGGER:DisableTrigger()
        end
    end
end

function RandomizerPowerup.EnableLiquids()
    if Scenario.CurrentScenarioID == "s010_area1" then
        Game.GetEntity("Lava_Trigger_001").TRIGGER:EnableTrigger()
    elseif Scenario.CurrentScenarioID == "s067_area6c" then
        Game.GetEntity("TG_SP_Water_002").TRIGGER:EnableTrigger()
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
                    RandomizerPowerup.DisableLiquids()
                    RandomizerPowerup.IncreaseItemAmount(resource.item_id, resource.quantity)
                    RandomizerPowerup.EnableLiquids()
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
    local model_updater = Game.GetEntity("Samus").MODELUPDATER
    for _, suit in ipairs(suits) do
        if suit.model == model_updater.sModelAlias then break end
        if Game.GetItemAmount(Game.GetPlayerName(), suit.item) > 0 then
            Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
            model_updater.sModelAlias = suit.model
            break
        end
    end
end

function RandomizerPowerup.IncreaseAmmo(resource)
    if not resource then return end

    local current_id = nil

    if resource.item_id == "ITEM_WEAPON_SUPER_MISSILE_MAX" then
    current_id = "ITEM_WEAPON_SUPER_MISSILE_CURRENT"
    elseif resource.item_id == "ITEM_WEAPON_POWER_BOMB_MAX" then
        current_id = "ITEM_WEAPON_POWER_BOMB_CURRENT"
    end

    if current_id == nil then return end

    RandomizerPowerup.IncreaseItemAmount(current_id, resource.quantity, resource.item_id)
end

-- Main PBs (always) + PB expansions (if required mains are disabled)
RandomizerPowerBomb = {}
setmetatable(RandomizerPowerBomb, {__index = RandomizerPowerup})
function RandomizerPowerBomb.OnPickedUp(actor, progression)
    progression = {{item_id = "ITEM_WEAPON_POWER_BOMB_MAX", quantity = 0}}
    local granted = RandomizerPowerup.OnPickedUp(actor, progression)
    if granted == "ITEM_WEAPON_POWER_BOMB_MAX" then
        Game.GetPlayer().INVENTORY:SetItemAmount("ITEM_WEAPON_POWER_BOMB", 1, true)
    end
end

-- Main Supers
-- RandomizerSuperMissile = {}
-- setmetatable(RandomizerSuperMissile, {__index = RandomizerPowerup})
-- function RandomizerSuperMissile.OnPickedUp(actor, progression)
--     RandomizerPowerup.OnPickedUp(actor, progression)
--     local locked_supers = Blackboard.GetProp("PLAYER_INVENTORY", "LOCKED_SUPERS")
--     if locked_supers > 0 then
--         -- grant all supers
--         Game.SetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_SUPER_MISSILE_MAX", locked_supers)
--     end
--     local max = Game.GetItemAmount(Game.GetPlayerName(), "ITEM_WEAPON_SUPER_MISSILE_MAX")
--     Game.GetPlayer().INVENTORY:SetItemAmount("ITEM_WEAPON_SUPER_MISSILE_MAX", max, true)
-- end

RandomizerSuperMissile = {}
setmetatable(RandomizerSuperMissile, {__index = RandomizerPowerup})
function RandomizerSuperMissile.OnPickedUp(actor, progression)
    progression = progression or {{{ item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX", quantity = 0 }}}
    RandomizerPowerup.OnPickedUp(actor, progression)
end

RandomizerSuperMissileTank = {}
setmetatable(RandomizerSuperMissileTank, {__index = RandomizerPowerup})
function RandomizerSuperMissileTank.OnPickedUp(actor, progression)
    RandomizerPowerup.OnPickedUp(actor, progression)
    local locked_supers = Blackboard.GetProp("PLAYER_INVENTORY", "ITEM_RANDO_LOCKED_SUPERS")
    Blackboard.SetProp("PLAYER_INVENTORY", "ITEM_RANDO_LOCKED_SUPERS", "f", locked_supers + amount)
end

RandomizerVariaSuit = {}
setmetatable(RandomizerVariaSuit, {__index = RandomizerPowerup})
function RandomizerVariaSuit.OnPickedUp(actor, progression)
    RandomizerPowerup.OnPickedUp(actor, progression)
    -- Prevents changing the suit to varia if gravity
    if Game.GetPlayer().MODELUPDATER.sModelAlias == "Default" then
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Varia"
    end
    Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
end

RandomizerGravitySuit = {}
setmetatable(RandomizerGravitySuit, {__index = RandomizerPowerup})
function RandomizerGravitySuit.OnPickedUp(actor, progression)
    RandomizerPowerup.DisableLiquids()
    RandomizerPowerup.OnPickedUp(actor, progression)
    Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Gravity"
    RandomizerPowerup.EnableLiquids()
end
