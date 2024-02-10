Game.DoFile("system/scripts/cc_to_room_name.lc")

RoomNameGui = RoomNameGui or {
    cameraDict = RANDO_CC_DICTIONARY,
    fadeTime = Init.bRoomIdFadeTime,
    fadeOutSFID = nil,
}

function RoomNameGui.GetRoomName(camera)
    local dict = RoomNameGui.cameraDict
    local scenario = Game.CurrentScenarioID()
    if dict == nil then
        Game.LogWarn(0, "No camera dict present!")
        return
    end

    local scenario_dict = dict[scenario]
    if scenario_dict == nil then
        Game.LogWarn(0, scenario .. " has nil dict!")
        return nil
    end

    local rando_name = scenario_dict[camera]
    return rando_name
end

function RoomNameGui.Init()
    local lowerInfo = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition")

    lowerInfo:AddChild((GUI.CreateDisplayObjectEx("RoomNameText", "CText", {
        X = "0.14688",
        Y = "-0.06500",
        SizeX = "0.12499",
        SizeY = "0.05833",
        ScaleX = "1.00000",
        ScaleY = "1.00000",
        Angle = "0.00000",
        FlipX = false,
        FlipY = false,
        ColorR = "0.68000",
        ColorG = "0.83000",
        ColorB = "0.93000",
        ColorA = "1.00000",
        Enabled = true,
        Visible = true,
        SkinItemType = "",
        Text = "Room Name",
        Font = "digital_small",
        TextAlignment = "Center",
        Autosize = true,
        Outline = true,
        EmbeddedSpritesSuffix = "",
        BlinkColorR = "1.00000",
        BlinkColorG = "1.00000",
        BlinkColorB = "1.00000",
        BlinkAlpha = "1.00000",
        Blink = "-1.00000"
    })))

    local current_cc = Game.GetScenarioBlackboardSectionID()

    RoomNameGui.Update(current_cc)
end

function RoomNameGui.Update(new_cc)
    RoomNameGui.Fade("1.0")

    if type(new_cc) ~= "string" then
        GUI.LogWarn(0, "collision camera is not string")
        return
    end

    local hud_text = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition.RoomNameText")
    local room_name = RoomNameGui.GetRoomName(new_cc)
    if room_name == nil then
        Game.LogWarn(0, string.format("Couldn't find name for %s/%s", Game.GetScenarioBlackboardSectionID(), new_cc))
        GUI.SetTextText(hud_text, tostring(new_cc))
    else
        GUI.SetTextText(hud_text, tostring(room_name))
    end
    hud_text:ForceRedraw()

    if RoomNameGui.fadeTime ~= nil and RoomNameGui.fadeTime ~= -1 then
        if RoomNameGui.fadeOutSFID ~= nil then
            Game.DelSFByID(RoomNameGui.fadeOutSFID)
        end
        RoomNameGui.fadeOutSFID = Game.AddGUISF(RoomNameGui.fadeTime, "RoomNameGui.Fade", "s", "0.0")
    end
end