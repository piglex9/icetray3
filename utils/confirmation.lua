local repl = game:GetService("ReplicatedStorage")
local confirmation = require(repl.Module.Confirmation)
local module = {}

function module.new(text)
    local new = confirmation.new(text)
    return new
end

function module.OnYes(confirmation, onYes)
    confirmation.OnYes:Connect(onYes)
end

function module.OnNo(confirmation, onNo)
    confirmation.OnNo:Connect(onNo) 
end

return module
