Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerScanningPulse = RandomizerScanningPulse or {}
function RandomizerScanningPulse.main()
end

function RandomizerScanningPulse.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    Player.SetAbilityUnlocked("ScanningPulse", true)
end

