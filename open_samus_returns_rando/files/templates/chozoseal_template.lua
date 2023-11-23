Game.ImportLibraryWithName("actors/props/usable/scripts/usable.lua", "Usable")
ChozoSeal = ChozoSeal or {}
setmetatable(ChozoSeal, {__index = Usable})

ChozoSeal.CurrentHintStrings = nil
ChozoSeal.CurrentHintIndex = nil

function ChozoSeal.ShowNextHint()
    if #ChozoSeal.CurrentHintStrings >= ChozoSeal.CurrentHintIndex then
        local hint = ChozoSeal.CurrentHintStrings[ChozoSeal.CurrentHintIndex]
        GUI.LaunchMessage(hint, "ChozoSeal.ShowNextHint", "")
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
        ChozoSeal.ShowNextHint()
    else
        GUI.LaunchMessage("No hint here :(", "ChozoSeal.OnDialogDeclined", "")
    end
end

ChozoSeal.Hints = TEMPLATE("mapping")
