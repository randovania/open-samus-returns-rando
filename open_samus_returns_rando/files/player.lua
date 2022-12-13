function Player.main()
end
function Player.OnSpecialEnergyLost(_ARG_0_)
end
function Player.OnResetAbilitiesDisabled(_ARG_0_)
  Game.PlayEntitySound("actors/samus/energy_taken.wav", Game.GetPlayer().sName, 1, 500, 3000, 1)
end
function Player.OnBeginAbilitiesDisabled(_ARG_0_)
  Game.PlayEntityLoop("actors/autoad/autoad_deactiv_loop.wav", Game.GetPlayer().sName, 1, 500, 3000, 1, false)
end
function Player.OnEndAbilitiesDisabled(_ARG_0_)
  Game.StopEntitySound(Game.GetPlayer().sName, "actors/autoad/autoad_deactiv_loop.wav", 0)
  Game.PlayEntitySound("actors/autoad/autoad_deactiv_end.wav", Game.GetPlayer().sName, 1, 500, 3000, 1)
end
function Player.OnAbilityChargeCharged(_ARG_0_)
  Game.PlayEntitySound("actors/samus/ener_reachmax.wav", Game.GetPlayer().sName, 0.35, 5000, 50000, 1.5)
end
function Player.OnAbilityTypeChanged(_ARG_0_)
  Game.PlayEntitySound("actors/samus/ener_select_0" .. math.random(2) .. ".wav", Game.GetPlayer().sName, 0.3, 500, 5000, 1)
end
function Player.OnAbilityESBegin(_ARG_0_)
  DamagePlants.UpdateFeedback()
end
function Player.OnAbilityESEnd(_ARG_0_)
  DamagePlants.UpdateFeedback()
end
function Player.OnAbilityPDBegin(_ARG_0_)
  Game.StopEntitySound(Game.GetPlayer().sName, "actors/samus/ener_timeend.wav", 0)
  Game.PlayEntitySound("actors/samus/ener_timeinit.wav", Game.GetPlayer().sName, 1, 500, 5000, 1, "PHASEDISPLACEMENT")
end
function Player.OnAbilityPDEnd(_ARG_0_)
  Game.StopEntitySound(Game.GetPlayer().sName, "actors/samus/ener_timeinit.wav", 0)
  Game.PlayEntitySound("actors/samus/ener_timeend.wav", Game.GetPlayer().sName, 1, 500, 5000, 1, "PHASEDISPLACEMENT")
end
function Player.OnAbilityEWBegin(_ARG_0_)
  Game.PlayEntitySound("actors/samus/ener_wbinit.wav", Game.GetPlayer().sName, 1, 500, 5000, 1)
end
function Player.OnAbilityEWEnd(_ARG_0_)
  Game.PlayEntitySound("actors/samus/ener_wbend.wav", Game.GetPlayer().sName, 1, 500, 5000, 1)
end
function Player.OnAbilitySPBegin(_ARG_0_)
  Game.PlayEntitySound("actors/samus/ener_sonar.wav", Game.GetPlayer().sName, 1, 500, 5000, 1)
end
function Player.SetAbilityUnlocked(_ARG_0_, _ARG_1_)
  if Game.GetPlayer() ~= nil and Game.GetPlayer().ABILITY ~= nil then
    Game.GetPlayer().ABILITY:SetAbilityUnlocked(_ARG_0_, _ARG_1_)
    Game.GetPlayer().ABILITY:TrySetSelectedAbility(_ARG_0_, true, true)
  end
end
function Player.IsAbilityActive(_ARG_0_)
  if Game.GetPlayer() ~= nil and Game.GetPlayer().ABILITY ~= nil then
    return Game.GetPlayer().ABILITY:IsAbilityActive(_ARG_0_)
  end
end
function Player.IsESActive()
  return Player.IsAbilityActive("EnergyShield")
end
function Player.UnlockPhaseDisplacement()
  Player.SetAbilityUnlocked("PhaseDisplacement", true)
end
function Player.UnlockEnergyWave()
  Player.SetAbilityUnlocked("EnergyWave", true)
end
function Player.UnlockEnergyShield()
  Player.SetAbilityUnlocked("EnergyShield", true)
end
function Player.UnlockScanningPulse()
  -- Game.LockAeionReserveTank()
  Player.SetAbilityUnlocked("ScanningPulse", true)
  -- if Game.GetPlayer() ~= nil and Game.GetPlayer().INVENTORY and Game.GetPlayer().SPECIALENERGY then
  --   Player.fMaxEnergy = Game.GetPlayer().SPECIALENERGY.fMaxEnergy
  --   Game.GetPlayer().INVENTORY:SetItemAmount("ITEM_MAX_SPECIAL_ENERGY", 0, true)
  --   Game.GetPlayer().INVENTORY:SetItemAmount("ITEM_CURRENT_SPECIAL_ENERGY", 0, true)
  --   Game.GetPlayer().SPECIALENERGY.fMaxEnergy = 0
  --   Game.GetPlayer().SPECIALENERGY.fEnergy = 0
  -- end
end
