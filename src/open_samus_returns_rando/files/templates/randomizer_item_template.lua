Game.ImportLibrary(TEMPLATE("parent_lua"), false)
T__name__T = T__name__T or {}
function T__name__T.main()
end
function T__name__T.OnPickedUp()
    local resources = TEMPLATE("resources")
    -- (priority, sound file, unknown, unknown, times to replay sound, fade-out time, fade-in time, unknown)
    Game.PlayMusicStream(1, TEMPLATE("sound"), -1, -1, 0, 0, 0, 0)
    GUI.LaunchMessage(TEMPLATE("caption"), "RandomizerPowerup.Dummy", "")
    TEMPLATE("parent").OnPickedUp(resources)
    hud.UpdatePlayerInfo(true)
end
