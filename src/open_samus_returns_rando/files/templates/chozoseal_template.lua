Game.ImportLibraryWithName("actors/props/usable/scripts/usable.lua", "Usable")
ChozoSeal = ChozoSeal or {}
setmetatable(ChozoSeal, {__index = Usable})

ChozoSeal.CurrentHintStrings = nil
ChozoSeal.CurrentHintIndex = nil

function ChozoSeal.ShowNextHint(scenario, sealName)
    if #ChozoSeal.CurrentHintStrings >= ChozoSeal.CurrentHintIndex then
        local hint = ChozoSeal.CurrentHintStrings[ChozoSeal.CurrentHintIndex]
        GUI.LaunchMessage(hint, "ChozoSeal.ShowNextHint", "")
        Blackboard.SetProp(scenario, sealName .. "_hint_read", "b", true)
        -- local hud = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.LowerComposition.LowerInfoComposition")
        -- GUI.SetTextText(hud, tostring(hint))
        -- hud:ForceRedraw()

        local hud = GUI.GetDisplayObject("IngameMenuRoot.IngameMenuComposition.PercentComposition")
        if hud ~= nil then
        local prop = Blackboard.GetProp("s000_surface", "LE_ChozoUnlockAreaDNA_hint_read")
        if prop then
            hud:AddChild((GUI.CreateDisplayObjectEx("test", "CText", {
            X = "0.24688",
            Y = "0.0",
            SizeX = "0.12499",
            SizeY = "0.05833",
            ColorR = "0.68000",
            ColorG = "0.83000",
            ColorB = "0.93000",
            ColorA = "1.00000",
            Enabled = true,
            Visible = true,
            Text = tostring(hint),
            Font = "digital_hefty",
            TextAlignment = "Left",
            Autosize = true,
            Outline = true
        })))
        end
end



        ChozoSeal.CurrentHintIndex = ChozoSeal.CurrentHintIndex + 1
    else
        ChozoSeal.CurrentHintStrings = nil
        ChozoSeal.CurrentHintIndex = nil
        ChozoSeal.OnDialogDeclined()
    end
end

function ChozoSeal.ShowDialogChoice(_ARG_0_, _ARG_1_)
    Usable._oUsableObject = _ARG_0_
    if _ARG_0_ == nil or _ARG_0_.sName == nil then
        GUI.LaunchMessage("Oopsie", "ChozoSeal.OnDialogDeclined", "")
    end

    local sealName = _ARG_0_.sName
    local scenario = Scenario.CurrentScenarioID
    if scenario ~= nil and ChozoSeal.Hints ~= nil and
            ChozoSeal.Hints[scenario] ~= nil and
            ChozoSeal.Hints[scenario][sealName] ~= nil then
        ChozoSeal.CurrentHintStrings = ChozoSeal.Hints[scenario][sealName]
        ChozoSeal.CurrentHintIndex = 1
        ChozoSeal.ShowNextHint(scenario, sealName)
    else
        GUI.LaunchMessage("No hint here :(", "ChozoSeal.OnDialogDeclined", "")
    end
end

ChozoSeal.Hints = TEMPLATE("mapping")
