local repl = game:GetService("ReplicatedStorage")
local startergui = game:GetService("StarterGui")

local is_synapse_function = checkclosure or is_synapse_function
local setupvalue = debug.setupvalue
local getconstants = debug.getconstants
local getupvalues = debug.getupvalues
local islclosure = islclosure

local fn
if not global then
    local init = getupvalues(require(repl.Game.Falling).Init)
    for i=1, #init do
        local v = init[i]
        if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
            local con = getconstants(v)
            if table.find(con, "NoFallDamage") then
                fn = v            
                break 
            end
        end
    end
else
    fn = global.registry.fallingInit
end

local function on_reset_callback()
    setupvalue(fn,1,true)
    fn(-999999999)
end

local event = Instance.new("BindableEvent")
event.Name = "samibagpulainunguri"
event.Event:connect(on_reset_callback)
startergui:SetCore("ResetButtonCallback", event)
