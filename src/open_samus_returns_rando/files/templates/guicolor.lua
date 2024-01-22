GUIColor = GUIColor or {}

function GUIColor.ChangeEnergyTanksHUDColor()
    local energyCounter = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.EnergyCounter")
    GUI.SetProperties(energyCounter, {
        ColorR = TEMPLATE("energy_counter_r"),
        ColorG = TEMPLATE("energy_counter_g"),
        ColorB = TEMPLATE("energy_counter_b"),
    })
    for tank = 1, 10 do
        local energyTank = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.EnergyTanksContainerComposition.Tank" .. tank)
        GUI.SetProperties(energyTank, {
            ColorR = TEMPLATE("energy_tank_r"),
            ColorG = TEMPLATE("energy_tank_g"),
            ColorB = TEMPLATE("energy_tank_b"),
        })
    end
end
