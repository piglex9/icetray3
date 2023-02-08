return function(posX, posY, posZ, minX, minY, minZ, maxX, maxY, maxZ)
    if posX < maxX and posX > minX then
        if posZ < maxZ and posZ > minZ then
            if posY < maxY and posY > minY then
                 return true 
            end
        end
    end
    return false
end
