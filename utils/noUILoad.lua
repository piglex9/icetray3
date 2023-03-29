return function()
    global.noUILoad = true
    if global.ui and global.ui.window.tab then
        global.ui.window.tab:Destroy()
    end
    global.run = false
end
