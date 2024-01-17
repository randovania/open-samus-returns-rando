Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerEnergyWave = RandomizerEnergyWave or {}
function RandomizerEnergyWave.main()
end
function RandomizerEnergyWave.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Player.SetAbilityUnlocked("EnergyWave", true)
end