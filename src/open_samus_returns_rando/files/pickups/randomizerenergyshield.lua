Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerEnergyShield = RandomizerEnergyShield or {}
function RandomizerEnergyShield.main()
end

function RandomizerEnergyShield.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Player.SetAbilityUnlocked("EnergyShield", true)
end