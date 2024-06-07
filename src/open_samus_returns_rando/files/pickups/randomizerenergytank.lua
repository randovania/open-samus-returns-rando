Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerEnergyTank = RandomizerEnergyTank or {}
function RandomizerEnergyTank.main()
end

function RandomizerEnergyTank.IncreaseEnergy()
    local max_energy= 1099
    local energy = Init.fEnergyPerTank
    local max_life = "ITEM_MAX_LIFE"
    local current_life = "ITEM_CURRENT_LIFE"
    local new_max = RandomizerPowerup.GetItemAmount(max_life) + energy
    new_max = math.min(new_max, max_energy)
    RandomizerPowerup.SetItemAmount(max_life, new_max)
    RandomizerPowerup.SetItemAmount(current_life, new_max)
    local life = Game.GetPlayer().LIFE
    life.fMaxLife = new_max
    life.fCurrentLife = new_max
end

function RandomizerEnergyTank.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    RandomizerEnergyTank.IncreaseEnergy()
end
