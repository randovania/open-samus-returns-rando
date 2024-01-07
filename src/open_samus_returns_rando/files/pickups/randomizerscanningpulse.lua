Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerScanningPulse = RandomizerScanningPulse or {}
function RandomizerScanningPulse.main()
end

function RandomizerScanningPulse.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Player.SetAbilityUnlocked("ScanningPulse", true)
end

