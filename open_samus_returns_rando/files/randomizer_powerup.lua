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
function RandomizerPowerup._AddLockedPBS(main_item)
    local locked_pbs = RandomizerPowerup.GetItemAmount("ITEM_RANDO_LOCKED_PBS")
    local current_max = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_POWER_BOMB_MAX")
    local current_current = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_POWER_BOMB_CURRENT")
    local new_current = 0
    if main_item then
        new_current = current_max + locked_pbs
    else
        new_current = current_current + locked_pbs
    end
    RandomizerPowerup.SetItemAmount("ITEM_WEAPON_POWER_BOMB_MAX", current_max + locked_pbs)
    RandomizerPowerup.SetItemAmount("ITEM_WEAPON_POWER_BOMB_CURRENT", new_current)
    RandomizerPowerup.SetItemAmount("ITEM_RANDO_LOCKED_PBS", 0)
    hud.UpdatePlayerInfo(true)
end

RandomizerPowerBomb = {}
setmetatable(RandomizerPowerBomb, {__index = RandomizerPowerup})
function RandomizerPowerBomb.OnPickedUp(actor, progression)
    -- non actor case: grant locked pbs
    if progression ~= nil then
        local locked_pbs = RandomizerPowerup.GetItemAmount("ITEM_RANDO_LOCKED_PBS")
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                if inner.item_id == "ITEM_WEAPON_POWER_BOMB_MAX" then
                    inner.quantity = inner.quantity + locked_pbs
                end
            end
        end
        RandomizerPowerup.OnPickedUp(actor, progression)
        RandomizerPowerup.SetItemAmount("ITEM_RANDO_LOCKED_PBS", 0)
    -- actor case: increase ammo by locked pbs after game handled the pickup
    else
        RandomizerPowerup.OnPickedUp(actor, progression)
        Game.AddSF(0.0, "RandomizerPowerup._AddLockedPBS", "b", true)
    end

end


RandomizerPowerBombTank = {}
setmetatable(RandomizerPowerBombTank, {__index = RandomizerPowerup})
function RandomizerPowerBombTank.OnPickedUp(actor, progression)
    -- use locked supers or super missile max if > 0, which means we have main item
    local new_item_id = "ITEM_RANDO_LOCKED_PBS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_POWER_BOMB_MAX") > 0
    if is_main_unlocked then
        new_item_id = "ITEM_WEAPON_POWER_BOMB_MAX"
    end

    -- non actor case => change to correct item
    if progression ~= nil then
        -- grant locked supers or new tank
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                inner.item_id = new_item_id
            end
        end
        RandomizerPowerup.OnPickedUp(actor, progression)
    else
        if is_main_unlocked then
            RandomizerPowerup.OnPickedUp(actor, progression)
            Game.AddSF(0.0, "RandomizerPowerup._AddLockedPBS", "")
        end
    end
end

-- Supers Main + Tanks
function RandomizerPowerup._AddLockedSupers(main_item)
    local locked_supers = RandomizerPowerup.GetItemAmount("ITEM_RANDO_LOCKED_SUPERS")
    local current_max = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SUPER_MISSILE_MAX")
    local current_current = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SUPER_MISSILE_CURRENT")
    local new_current = 0
    if main_item then
        new_current = current_max + locked_supers
    else
        new_current = current_current + locked_supers
    end
    RandomizerPowerup.SetItemAmount("ITEM_WEAPON_SUPER_MISSILE_MAX", current_max + locked_supers)
    RandomizerPowerup.SetItemAmount("ITEM_WEAPON_SUPER_MISSILE_CURRENT", new_current)
    RandomizerPowerup.SetItemAmount("ITEM_RANDO_LOCKED_SUPERS", 0)
    hud.UpdatePlayerInfo(true)
end

RandomizerSuperMissile = {}
setmetatable(RandomizerSuperMissile, {__index = RandomizerPowerup})
function RandomizerSuperMissile.OnPickedUp(actor, progression) 
    -- non actor case: grant locked supers
    if progression ~= nil then
        local locked_supers = RandomizerPowerup.GetItemAmount("ITEM_RANDO_LOCKED_SUPERS")
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                if inner.item_id == "ITEM_WEAPON_SUPER_MISSILE_MAX" then
                    inner.quantity = inner.quantity + locked_supers
                end
            end
        end
        RandomizerPowerup.OnPickedUp(actor, progression)
        RandomizerPowerup.SetItemAmount("ITEM_RANDO_LOCKED_SUPERS", 0)
    -- actor case: increase ammo by locked supers after game handled the pickup
    else
        RandomizerPowerup.OnPickedUp(actor, progression)
        Game.AddSF(0.0, "RandomizerPowerup._AddLockedSupers", "b", true)
    end

end

RandomizerSuperMissileTank = {}
setmetatable(RandomizerSuperMissileTank, {__index = RandomizerPowerup})
function RandomizerSuperMissileTank.OnPickedUp(actor, progression)
    -- use locked supers or super missile max if > 0, which means we have main item
    local new_item_id = "ITEM_RANDO_LOCKED_SUPERS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SUPER_MISSILE_MAX") > 0
    if is_main_unlocked then
        new_item_id = "ITEM_WEAPON_SUPER_MISSILE_MAX"
    end

    -- non actor case => change to correct item
    if progression ~= nil then
        -- grant locked supers or new tank
        for _, outer in ipairs(progression) do
            for _, inner in ipairs(outer) do
                inner.item_id = new_item_id
            end
        end
        RandomizerPowerup.OnPickedUp(actor, progression)
    else
        if is_main_unlocked then
            RandomizerPowerup.OnPickedUp(actor, progression)
            Game.AddSF(0.0, "RandomizerPowerup._AddLockedSupers", "")
        end
    end
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

RandomizerBabyHatchling = {}
setmetatable(RandomizerBabyHatchling, {__index = RandomizerPowerup})
function RandomizerBabyHatchling.OnPickedUp(actor, progression)
    RandomizerPowerup.OnPickedUp(actor, progression)
    Game.GetDefaultPlayer("Samus").BABYHATCHLINGCREATION:SpawnBaby()
end
