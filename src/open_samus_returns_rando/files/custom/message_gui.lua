MessageGUI = MessageGUI or {
    disconnectUi = nil,
    multiworldUi = nil,
    container = nil,
}

function MessageGUI.Init()
    if MessageGUI.disconnectUi then
        GUI.DestroyDisplayObject(MessageGUI.disconnectUi)
        MessageGUI.disconnectUi = nil
    end

    if MessageGUI.multiworldUi then
        GUI.DestroyDisplayObject(MessageGUI.multiworldUi)
        MessageGUI.multiworldUi = nil
    end

    local hud = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition")
    local disconnectUi = GUI.CreateDisplayObjectEx("DisconnectText", "CText", {
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
        Visible = false
    })
    hud:AddChild(disconnectUi)

    local multiworldUi = GUI.CreateDisplayObjectEx("MultiworldText", "CText", {
        X = "0.20",
        Y = "-0.55900",
        SizeX = "0.12499",
        SizeY = "0.05833",
        ColorR = "1.00000",
        ColorG = "0.000",
        ColorB = "0.000",
        Text = "",
        Font = "digital_hefty",
        TextAlignment = "Center",
        Visible = false
    })
    hud:AddChild(multiworldUi)

    MessageGUI.disconnectUi = disconnectUi
    MessageGUI.multiworldUi = multiworldUi
end

function MessageGUI.UpdateConnected(visible)
    GUI.SetProperties(MessageGUI.disconnectUi, {
        Visible = visible
    })
    MessageGUI.disconnectUi:ForceRedraw()
end

function MessageGUI.UpdateMultiworld(visible, text)
    GUI.SetProperties(MessageGUI.multiworldUi, {
        Visible = visible,
        Text = text
    })
    MessageGUI.multiworldUi:ForceRedraw()
end