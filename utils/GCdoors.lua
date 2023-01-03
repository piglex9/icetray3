local doors = {}
for i,v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "State") and rawget(v, "OpenFun") then
        for i2,v2 in next, v do
            if typeof(v2) == "Instance" then
                if v2.Model:FindFirstChild("BarbedWire") then
                    if tostring(v2.Model.BarbedWire.Position):find("-1141") or tostring(v2.Model.BarbedWire.Position):find("-1140") then
                        table.insert(doors, v)
                    end
                end
                for i3,v3 in next, workspace:GetChildren() do
                    if v3.Name == "Cell" and v2.Model:IsDescendantOf(v3) then
                        table.insert(doors, v)
                    end
                end
            end
        end
    end
    if type(v) == "function" and islclosure(v) then
        local con = getconstants(v)
        if table.find(con, "SequenceRequireState") then
            openFunction = v
        end
    end
end

--[[
for i,v in next, doors do
    openFunction(v)
end
--]]

return doors, openFunction
