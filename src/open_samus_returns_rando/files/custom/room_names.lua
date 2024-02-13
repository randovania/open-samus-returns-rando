Game.DoFile("system/scripts/cc_to_room_name.lc")

RoomNameGui = RoomNameGui or {
    ui = nil,
    cameraDict = RANDO_CC_DICTIONARY,
}

function RoomNameGui.GetRoomName(camera)
    local dict = RoomNameGui.cameraDict
    local scenario = Scenario.CurrentScenarioID
    if dict == nil then
        return
    end

    if dict[scenario] == nil then
        return nil
    end

    return dict[scenario][camera]
end

function RoomNameGui.Init()
    if RoomNameGui.ui then
        GUI.DestroyDisplayObject(RoomNameGui.ui)
        RoomNameGui.ui = nil
    end

    local hud = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition")
    local ui = GUI.CreateDisplayObjectEx("RoomNameText", "CText", {
        X = "0.14400",
        Y = "-0.05900",
        SizeX = "0.12499",
        SizeY = "0.05833",
        ColorR = "0.68000",
        ColorG = "0.83000",
        ColorB = "0.93000",
        Text = "",
        Font = "digital_small",
        TextAlignment = "Center",
    })
    hud:AddChild(ui)

    RoomNameGui.ui = ui
end

function RoomNameGui.Update(new_cc)
    if type(new_cc) ~= "string" or RoomNameGui.ui == nil then
        return
    end

    local hud_text = RoomNameGui.ui
    local room_name = RoomNameGui.GetRoomName(new_cc)

    if room_name == nil then
        GUI.SetTextText(hud_text, tostring(new_cc))
    else
        GUI.SetTextText(hud_text, tostring(room_name))
    end
    hud_text:ForceRedraw()
end