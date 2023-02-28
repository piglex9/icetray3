return function(player)
    if player:FindFirstChild("Folder") and player.Folder:FindFirstChild("Cuffed") then
        return true
    end
    return false
end
