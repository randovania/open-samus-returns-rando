Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerEnergyWave = RandomizerEnergyWave or {}
function RandomizerEnergyWave.main()
end
function RandomizerEnergyWave.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    Player.SetAbilityUnlocked("EnergyWave", true)
end