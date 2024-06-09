Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerPhaseDisplacement = RandomizerPhaseDisplacement or {}
function RandomizerPhaseDisplacement.main()
end

function RandomizerPhaseDisplacement.OnPickedUp(progression, actorOrName)
    RandomizerPowerup.OnPickedUp(progression, actorOrName)
    Player.SetAbilityUnlocked("PhaseDisplacement", true)
end
