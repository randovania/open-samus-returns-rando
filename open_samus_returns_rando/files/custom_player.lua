Game.ImportLibrary("actors/characters/player/scripts/player_original.lua")

function Player.UnlockPhaseDisplacement()
  Game.LockAeionReserveTank()
  Player.SetAbilityUnlocked("PhaseDisplacement", true)
end
function Player.UnlockEnergyWave()
  Game.LockAeionReserveTank()
  Player.SetAbilityUnlocked("EnergyWave", true)
end
function Player.UnlockEnergyShield()
  Game.LockAeionReserveTank()
  Player.SetAbilityUnlocked("EnergyShield", true)
end
function Player.UnlockScanningPulse()
  Game.LockAeionReserveTank()
  Player.SetAbilityUnlocked("ScanningPulse", true)
end
