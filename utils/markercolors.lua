local colors = { -- DEFAULT COLORS FOR PLAYERMARKERS
    Prisoner = Color3.fromRGB(253, 148, 81);
    Police = Color3.fromRGB(84, 215, 253);
    Criminal = Color3.fromRGB(253, 100, 30);
}

function colors.new(name, color)
    assert(name, "Name missing")
    assert(color, "Color missing")
    if colors[name] then
        error(("%s already exists"):format(name))   
    end 
    colors[name] = color
end

function colors.remove(name, color)
    assert(name, "Name missing")
    assert(color, "Color missing")
    if not colors[name] then
        error(("%s does not exist"):format(name))
    end
    colors[name] = nil
end

return colors
