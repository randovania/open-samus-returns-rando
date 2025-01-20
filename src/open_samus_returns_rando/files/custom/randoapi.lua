Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)

RandoApi = RandoApi or {}
function RandoApi.main()
end

function RandoApi.ChangeSuitValues(hasVaria, hasGravity)
    hasVaria = RandomizerPowerup.GetItemAmount("ITEM_VARIA_SUIT") > 0
    hasGravity = RandomizerPowerup.GetItemAmount("ITEM_GRAVITY_SUIT") > 0
    RandoApi.ChangeSuitValues(hasVaria, hasGravity)
end
