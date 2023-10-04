RandomizerPowerup = {}
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
end

function RandomizerPowerup.OnPickedUp(resources)
    local granted = RandomizerPowerup.HandlePickupResources(resources)

    for _, resource in ipairs(granted) do
        RandomizerPowerup.IncreaseAmmo(resource)
    end

    Scenario.UpdateProgressiveItemModels()

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
                    if string.sub(resource.item_id, 0, 14) == "ITEM_RANDO_DNA" then
                        RandomizerPowerup.IncreaseItemAmount("ITEM_ADN", resource.quantity)
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

    if resource.item_id == "ITEM_WEAPON_SUPER_MISSILE_MAX" then
        current_id = "ITEM_WEAPON_SUPER_MISSILE_CURRENT"
    elseif resource.item_id == "ITEM_WEAPON_POWER_BOMB_MAX" then
        current_id = "ITEM_WEAPON_POWER_BOMB_CURRENT"
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

MAX_AEION= 2200
function RandomizerPowerup.IncreaseAeion()
    local aeion = Init.fAeionPerTank
    local new_max = RandomizerPowerup.GetItemAmount("ITEM_MAX_SPECIAL_ENERGY") + aeion
    new_max = math.min(new_max, MAX_AEION)
    RandomizerPowerup.SetItemAmount("ITEM_MAX_SPECIAL_ENERGY", new_max)
    RandomizerPowerup.SetItemAmount("ITEM_CURRENT_SPECIAL_ENERGY", new_max)

    local specialEnergy = Game.GetPlayer().SPECIALENERGY
    specialEnergy.fMaxEnergy = new_max
    specialEnergy.fEnergy = new_max
end

RandomizerPowerBomb = {}
setmetatable(RandomizerPowerBomb, {__index = RandomizerPowerup})
function RandomizerPowerBomb.OnPickedUp(progression)
    local locked_pbs = RandomizerPowerup.GetItemAmount("ITEM_RANDO_LOCKED_PBS")
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            if inner.item_id == "ITEM_WEAPON_POWER_BOMB_MAX" then
                inner.quantity = inner.quantity + locked_pbs
            end
        end
    end
    RandomizerPowerup.OnPickedUp(progression)
    RandomizerPowerup.SetItemAmount("ITEM_RANDO_LOCKED_PBS", 0)
end


RandomizerPowerBombTank = {}
setmetatable(RandomizerPowerBombTank, {__index = RandomizerPowerup})
function RandomizerPowerBombTank.OnPickedUp(progression)
    -- use locked pbs or power bomb max if > 0, which means we have main item
    local new_item_id = "ITEM_RANDO_LOCKED_PBS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_POWER_BOMB_MAX") > 0
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
    local locked_supers = RandomizerPowerup.GetItemAmount("ITEM_RANDO_LOCKED_SUPERS")
    for _, outer in ipairs(progression) do
        for _, inner in ipairs(outer) do
            if inner.item_id == "ITEM_WEAPON_SUPER_MISSILE_MAX" then
                inner.quantity = inner.quantity + locked_supers
            end
        end
    end
    RandomizerPowerup.OnPickedUp(progression)
    RandomizerPowerup.SetItemAmount("ITEM_RANDO_LOCKED_SUPERS", 0)
end

RandomizerSuperMissileTank = {}
setmetatable(RandomizerSuperMissileTank, {__index = RandomizerPowerup})
function RandomizerSuperMissileTank.OnPickedUp(progression)
    -- use locked supers or super missile max if > 0, which means we have main item
    local new_item_id = "ITEM_RANDO_LOCKED_SUPERS"
    local is_main_unlocked = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SUPER_MISSILE_MAX") > 0
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
    RandomizerPowerup.DisableLiquids()
    RandomizerPowerup.OnPickedUp(progression)
    if Game.GetEntity("Samus").MODELUPDATER.sModelAlias == "Default" then
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Varia"
    else
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Gravity"
    end
    Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
    RandomizerPowerup.EnableLiquids()
end

RandomizerEnergyTank = {}
setmetatable(RandomizerEnergyTank, {__index = RandomizerPowerup})
function RandomizerEnergyTank.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    RandomizerPowerup.IncreaseEnergy()
end

RandomizerAeionTank = {}
setmetatable(RandomizerAeionTank, {__index = RandomizerPowerup})
function RandomizerAeionTank.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    RandomizerPowerup.IncreaseAeion()
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
