Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerEnergyShield = RandomizerEnergyShield or {}
function RandomizerEnergyShield.main()
end

function RandomizerEnergyShield.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    Player.SetAbilityUnlocked("EnergyShield", true)
end