Game.ImportLibrary("actors/characters/player/scripts/player_original.lua")

function Player.UnlockScanningPulse()
  Game.LockAeionReserveTank()
  Player.SetAbilityUnlocked("ScanningPulse", true)
end