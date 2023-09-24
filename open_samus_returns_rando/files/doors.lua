Doors = {}

function Doors.Dummy()
end
function Doors.RemoveDoors(_ARG_0_)
    local actor_name = _ARG_0_.sName
    -- TOOD: Remove the debug message
    GUI.LaunchMessage(actor_name, "Doors.Dummy", "")
    local ending = string.sub(actor_name, -2)
    if ending == "_o" then
        actor_name = string.sub(actor_name, 0, -3)
    end
    Game.DeleteEntity(actor_name)
    Game.DeleteEntity(actor_name .. "_o")
    Scenario.WriteToBlackboard("entity_" .. actor_name .. "_dead", "b", true)
    Scenario.WriteToBlackboard("entity_" .. actor_name .. "_o_dead", "b", true)
end