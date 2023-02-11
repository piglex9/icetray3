return function(p1, p2)
    if p1 == "Police" then
        if p2 == "Criminal" then
            return true
        elseif p2 == "Prisoner" then
            return true
        end
    elseif p1 == "Criminal" or p1 == "Prisoner" then
        if p2 == "Police" then
            return true
        elseif p2 == "Criminal" then
            return false
        elseif p2 == "Prisoner" then
            return false
        end
    end
    return false
end
