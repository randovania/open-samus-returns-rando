Game.ImportLibrary("actors/props/samusship/scripts/samusship_original.lc")
function SamusShip.ShowDialogChoice(_ARG_0_, _ARG_1_)
  Usable._oUsableObject = _ARG_0_
  GUI.LaunchMessage(_ARG_1_, "Usable.OnDialogAccepted", "SamusShip.OnDialogDeclined")
end
function SamusShip.Dummy()
end
function SamusShip.WarpToStart()
  Scenario.LoadNewScenario(Init.sStartingScenario, Init.sStartingActor)
end
function SamusShip.OnDialogDeclined()
  Usable._oUsableObject.USABLE:OnDialogDeclined()
  GUI.LaunchMessage("Warp to Start?", "SamusShip.WarpToStart", "SamusShip.Dummy")
end