Cosmetics = Cosmetics or {}

function Cosmetics.UpdateGUI()
    Cosmetics.ChangeEnergyTanksColor()
    Cosmetics.ChangeSpecialEnergyBarColor()
    Cosmetics.ChangeAmmoSelectionColor()
end

function Cosmetics.ChangeEnergyTanksColor()
    for i = 1, 10 do
        local energyTank = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.EnergyTanksContainerComposition.Tank" .. i)
        GUI.SetProperties(energyTank, {
            ColorR = TEMPLATE("energy_tank_r"),
            ColorG = TEMPLATE("energy_tank_g"),
            ColorB = TEMPLATE("energy_tank_b"),
        })
    end
end

function Cosmetics.ChangeSpecialEnergyBarColor()
    local specialEnergy = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.SpecialEnergyBarComponents")
    GUI.SetProperties(specialEnergy, {
        ColorR = TEMPLATE("aeion_bar_r"),
        ColorG = TEMPLATE("aeion_bar_g"),
        ColorB = TEMPLATE("aeion_bar_b"),
    })
end

function Cosmetics.ChangeAmmoSelectionColor()
    local hudElements = {"MissilesSelection", "SGI_Missile", "SuperMissilesSelection", "SGI_SuperMissile", "PowerBombsSelection", "SGI_PowerBomb"}
    for i = 1, 6 do
        local hud = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition." .. hudElements[i])
        GUI.SetProperties(hud, {
            ColorR = TEMPLATE("ammo_hud_r"),
            ColorG = TEMPLATE("ammo_hud_g"),
            ColorB = TEMPLATE("ammo_hud_b"),
        })
    end
end
