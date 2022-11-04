local module = {
    welcomeMessage = "Welcome to ice tray V3";
}

module.main = require(game:GetService("ReplicatedStorage").Game.ContextMessage.ContextMessageUI)

function module.open()
    return module.main.open()
end

function module.close()
    return module.main.close()
end

function module.status()
    return module.main.isOpen()
end

function module.setmsg(msg)
    msg = tostring(msg)
    return module.main.setMessage(msg)
end

function module.send(msg, w) -- w = delay
    if not w then
        w = 1
    end
    w = tonumber(w)
    if module.status() then
        module.close()
        wait(0.1)
    end
    module.open()
    module.setmsg(msg)
    delay(w, function()
        if module.status() then
            module.close()
        end
    end)
end

return module
