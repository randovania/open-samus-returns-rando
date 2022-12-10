

Game.ImportLibrary("system/scripts/original_scenario.lua")

Scenario = Scenario or {}
setmetatable(Scenario, {__index = _G})
setfenv(1, Scenario)

function HideLoadingScreen()
	Game.SetLoadingScreen(false)
	loadingscreen.HideLoadingScreen()
	Game.HUDIdleScreenLeave()
end