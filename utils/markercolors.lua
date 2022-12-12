local colors = {}

function colors.new(name, color)
    assert(name, "Name missing")
    assert(color, "Color missing")
    if colors[name] then
        error(("%s already exists"):format(name))   
    end 
    colors[name] = color
    return true
end

function colors.remove(name, color)
    assert(name, "Name missing")
    assert(color, "Color missing")
    if not colors[name] then
        error(("%s does not exist"):format(name))
    end
    colors[name] = nil
    return true
end

return colors
