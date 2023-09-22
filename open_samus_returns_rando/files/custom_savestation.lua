Game.ImportLibrary("actors/props/savestation/scripts/savestation_original.lc")
function SaveStation.ShowDialogChoice(_ARG_0_, _ARG_1_)
  Usable._oUsableObject = _ARG_0_
  GUI.LaunchMessage(_ARG_1_, "Usable.OnDialogAccepted", "SaveStation.OnDialogDeclined")
end
function SaveStation.Dummy()
end
function SaveStation.WarpToStart()
  Game.LoadScenario("c10_samus", Init.sStartingScenario, Init.sStartingActor, "samus", 1)
end
function SaveStation.OnDialogDeclined()
  Usable._oUsableObject.USABLE:OnDialogDeclined()
  GUI.LaunchMessage("Warp to Start?", "SaveStation.WarpToStart", " SaveStation.Dummy()")
end