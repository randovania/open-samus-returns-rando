Doors = Doors or {}
function Doors.RemoveDoors(_ARG_0_)
    local actor_name = _ARG_0_.sName
    local ending = string.sub(actor_name, -2)
    if ending == "_o" then
        actor_name = string.sub(actor_name, 0, -3)
    end

    if Game.GetEntity(actor_name) ~= nil then
        Game.DeleteEntity(actor_name)
        Scenario.WriteToBlackboard("entity_" .. actor_name .. "_dead", "b", true)
    end
    if Game.GetEntity(actor_name .. "_o") ~= nil then
        Game.DeleteEntity(actor_name .. "_o")
        Scenario.WriteToBlackboard("entity_" .. actor_name .. "_o_dead", "b", true)
    end
end