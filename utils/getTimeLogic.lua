return function(time, send_developer_console)
    if time >= 5 then
        return "Morgen"
    elseif time >= 13 then
        return "Mittag"
    elseif time >= 16 then
        return "Abend"
    elseif time < 5 then
        return "Nacht"
    end
    send_developer_console("Couldn't get time")
    return false
end
