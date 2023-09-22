T__name__T = {}
setmetatable(T__name__T, {__index = TEMPLATE("parent")})
function T__name__T.main()
end
function T__name__T.OnPickedUp()
    local resources = TEMPLATE("resources")
    Game.PlayMusicStream(0, TEMPLATE("sound"),  -1, -1, 0, 0, 0, 0)
    GUI.LaunchMessage(TEMPLATE("caption"), "RandomizerPowerup.Dummy", "")
    TEMPLATE("parent").OnPickedUp(resources)
    hud.UpdatePlayerInfo(true)
end