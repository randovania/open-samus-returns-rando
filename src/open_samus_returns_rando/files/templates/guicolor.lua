GUIColor = GUIColor or {}

function GUIColor.ChangeEnergyTanksHUDColor()
    local energyCounter = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.EnergyCounter")
    GUI.SetProperties(energyCounter, {
        ColorR = TEMPLATE("energy_counter_r"),
        ColorG = TEMPLATE("energy_counter_g"),
        ColorB = TEMPLATE("energy_counter_b"),
    })
    local tank1 = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.EnergyTanksContainerComposition.Tank1")
    GUI.SetProperties(tank1, {
        ColorR = "0.08000",
        ColorG = "0.80000",
        ColorB = "0.93000",
    })
end
