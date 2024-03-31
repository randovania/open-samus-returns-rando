DisconnectGui = DisconnectGui or {
    ui = nil,
    container = nil,
}

function DisconnectGui.Init()
    if DisconnectGui.ui then
        GUI.DestroyDisplayObject(DisconnectGui.ui)
        DisconnectGui.ui = nil
    end

    local hud = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition")
    local ui = GUI.CreateDisplayObjectEx("DisconnectText", "CText", {
        X = "0.20",
        Y = "-0.55900",
        SizeX = "0.12499",
        SizeY = "0.05833",
        ColorR = "1.00000",
        ColorG = "0.000",
        ColorB = "0.000",
        Text = "Disconnected!",
        Font = "digital_hefty",
        TextAlignment = "Center",
    })
    hud:AddChild(ui)

    DisconnectGui.ui = ui
end

function DisconnectGui.Update(visible)
    GUI.SetProperties(DisconnectGui.ui, {
        Visible = visible
    })
    DisconnectGui.ui:ForceRedraw()
end