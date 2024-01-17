HeatZone = HeatZone or {}
function HeatZone.main()
end
function HeatZone.OnPlayerDead()
  Game.GetPlayerInfo():ResetHeatZoneCount()
  Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
end
function HeatZone.OnEnter(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ == true then
    HeatZone.OnEnter()
  end
end
function HeatZone.PlaySound()
  Game.GetPlayer():PlayEntityLoop("actors/samus/damage_alarm.wav", 0.4, 100000, 110000, 1, false)
  Game.PlayEntitySound("levels/lava_pain_0" .. math.random(2) .. ".wav", Game.GetPlayer().sName, 0.45, 500, 5000, 0.9)
end 

function HeatZone.OnEnter()
  if Game.GetPlayerInfo().iHeatZoneCount == 0 and Game.GetEntity("Samus").MODELUPDATER.sModelAlias == "Default" then
    Game.AddSF(0.0, "HeatZone.PlaySound", "")
    guicallbacks.OnPlayerContinuousDamageStart()
    utils.LOG(utils.LOGTYPE_LOGIC, "heatzoneenter")
  end
  Game.GetPlayerInfo():IncrementHeatZoneCount()
end
function HeatZone.OnExit(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_2_ == true then
    HeatZone.OnExit()
  end
end
function HeatZone.OnExit()
  Game.GetPlayerInfo():DecrementHeatZoneCount()
  if Game.GetPlayerInfo().iHeatZoneCount == 0 then
    Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
    guicallbacks.OnPlayerContinuousDamageEnd()
    utils.LOG(utils.LOGTYPE_LOGIC, "heatzoneexit")
  elseif Game.GetPlayerInfo().iHeatZoneCount < 0 then
    Game.GetPlayerInfo():ResetHeatZoneCount()
  end
end