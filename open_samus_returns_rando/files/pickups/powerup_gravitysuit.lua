function PowerUpGravitySuit.main()
end
function PowerUpGravitySuit.OnPickedUp(_ARG_0_)
--   Game.PlayEntitySoundContinueOnDead("generic/obtencion.wav", _ARG_0_.sName, 1, 500, 4000, 1)
--   Game.TogglePause()
--   Game.AddGUISF(0.5, Game.TogglePause, "")
--   Game.AddGUISF(0.5, class.BindMethod(_ARG_0_, PowerUpGravitySuit.OnItem), "")
--   Game.AddGUISF(0.5, Game.LaunchCutscene, "s", "cutscenes/gravitysuit/takes/01/gravitysuit01.bmscu")
--   Game.SetGameModeStartButtonForbidden("INGAME", true)
--   Game.HUDIdleScreenGo()
  guicallbacks.OnPickableItemPickedUp("#GUI_ITEM_ACQUIRED_GRAVITY_SUIT", false)
  Game.GetPlayer().MODELUPDATER.sModelAlias = "Gravity"
end
function PowerUpGravitySuit.OnItemEnd(_ARG_0_)
  _ARG_0_.PICKABLE:OnItemEnd()
end