Cosmetics = Cosmetics or {}

function Cosmetics.UpdateGUI()
    Cosmetics.ChangeEnergyCounterColor()
    Cosmetics.ChangeEnergyTanksColor()
    Cosmetics.ChangeSpecialEnergyBarColor()
end

function Cosmetics.ChangeEnergyCounterColor()
    local energyCounter = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.UpperComposition.StatusComposition.EnergyCounter")
    GUI.SetProperties(energyCounter, {
        ColorR = TEMPLATE("energy_counter_r"),
        ColorG = TEMPLATE("energy_counter_g"),
        ColorB = TEMPLATE("energy_counter_b"),
    })
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
        ColorR = TEMPLATE("special_energy_bar_r"),
        ColorG = TEMPLATE("special_energy_bar_g"),
        ColorB = TEMPLATE("special_energy_bar_b"),
    })
end
