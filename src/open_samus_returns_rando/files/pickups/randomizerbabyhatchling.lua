Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)
RandomizerBabyHatchling = RandomizerBabyHatchling or {}
function RandomizerBabyHatchling.main()
end

function RandomizerBabyHatchling.OnPickedUp(progression)
    RandomizerPowerup.OnPickedUp(progression)
    Game.GetDefaultPlayer("Samus").BABYHATCHLINGCREATION:SpawnBaby()
    Game.GetEntity("Baby Hatchling").vPos = Game.GetDefaultPlayer("Samus").vPos
end