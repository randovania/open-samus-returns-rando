Game.ImportLibrary("actors/characters/player/scripts/player_original.lua")

function Player.UnlockScanningPulse()
  Player.SetAbilityUnlocked("ScanningPulse", true)
end
