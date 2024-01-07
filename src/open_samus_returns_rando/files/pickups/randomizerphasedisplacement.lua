Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerPhaseDisplacement = RandomizerPhaseDisplacement or {}
function RandomizerPhaseDisplacement.main()
end

function RandomizerPhaseDisplacement.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Player.SetAbilityUnlocked("PhaseDisplacement", true)
end
