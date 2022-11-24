local ambient = {}

for i,v in next, getgc(true) do -- no, getgc is not used in ice tray
    if type(v) == "table" and rawget(v, "em") and not rawget(v, "GetVehiclePacket") then
        for i2,v2 in next, v.em do
            if type(v2) == "function" and islclosure(v2) then
                local con = getconstants(v2)
                if table.find(con, "Day") and table.find(con, "Night") then
                    ambient.func = v2
                end
            end
        end
    end
end

function ambient.get()
    return tostring(getupvalue(ambient.func, 1))
end

function ambient.set(value)
    if value ~= "Day" and value ~= "Night" and value ~= "Storm" then
        assert(value == nil)
    end
    return ambient.func(value)
end

return ambient
