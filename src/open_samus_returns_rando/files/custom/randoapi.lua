Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)

RandoApi = RandoApi or {}
function RandoApi.main()
end

function RandoApi.UpdateSuits()
    hasVaria = RandomizerPowerup.GetItemAmount("ITEM_VARIA_SUIT") > 0
    hasGravity = RandomizerPowerup.GetItemAmount("ITEM_GRAVITY_SUIT") > 0

    -- Custom lua function to update damage reductions
    RandoApi.ChangeSuitValues(hasVaria, hasGravity)

    -- Model and damage_alarm updates
    if hasGravity then
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Gravity"
        if hasVaria then
            Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
        end
    elseif hasVaria then
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Varia"
        Game.GetPlayer():StopEntityLoopWithFade("actors/samus/damage_alarm.wav", 0.6)
    end
end
