return function(tools, time)
    if time >= 5 then
        return "Morgen"
    elseif time >= 13 then
        return "Mittag"
    elseif time >= 16 then
        return "Abend"
    elseif time < 5 then
        return "Nacht"
    end
    tools.log("❌ No Time Detected")
    return false
end
