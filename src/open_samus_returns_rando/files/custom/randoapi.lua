Game.ImportLibrary("actors/items/randomizerpowerup/scripts/randomizerpowerup.lc", false)

RandoApi = RandoApi or {
    ChangeSuitValues = function(hasVaria, hasGravity) end,
    ChangeBeams = function(hasWave, hasSpazer, hasPlasma, dmgSpazer, dmgPlasma, dmgPlasmaWave, dmgPlasmaSpazer) end
}

function RandoApi.main()
end

function RandoApi.CheckSuits()
    local hasVaria = RandomizerPowerup.GetItemAmount("ITEM_VARIA_SUIT") > 0
    local hasGravity = RandomizerPowerup.GetItemAmount("ITEM_GRAVITY_SUIT") > 0

    -- Update damage reductions based on the suits
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
    else
        Game.GetEntity("Samus").MODELUPDATER.sModelAlias = "Default"
    end
end

function RandoApi.CheckBeams()
    local hasWave = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_WAVE_BEAM") > 0
    local hasSpazer = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_SPAZER_BEAM") > 0
    local hasPlasma = RandomizerPowerup.GetItemAmount("ITEM_WEAPON_PLASMA_BEAM") > 0

    -- Damage values are Solo Spazer, Solo Plasma, Plasma + Wave, and Plasma + Spazer, respectively
    RandoApi.ChangeBeams(hasWave, hasSpazer, hasPlasma, 40, 85, 95, 80)
end