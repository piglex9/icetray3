local resolveAttempts = {}

return function(tools)
    function tools.init()
        return resolveAttempts
    end
    function tools.resetResolveAttempts()
        resolveAttempts:Reset()
    end
    function resolveAttempts.Get(t)
        if tick() - t > 30 then
            return false
        end
        return resolveAttempts[t]
    end
end
