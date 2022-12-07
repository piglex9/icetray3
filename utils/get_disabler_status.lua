return function(tools, disabler)
    if tools.registry.isHooked(disabler) then
        return "🛑"
    end
    local disabler = tools.utils.synapse_functions.getupvalue(disabler,2)
    if disabler == false then
        return "❌"
    end
    return "✅"
end
