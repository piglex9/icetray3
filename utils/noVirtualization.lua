--LPH_NO_VIRTUALIZE(function()

return function()
    local player = players.LocalPlayer
    local getrawmetatable = global.functions.getrawmetatable
    local newcclosure = global.functions.newcclosure
    local setreadonly = global.functions.setreadonly
    local client = global.registry.client
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local newidx = mt.__newindex
    local idx = mt.__index
    local function newidxx(self, name, val)
        if name == "FieldOfView" then
            val = global.ui_status.fov or 70
            return newidx(self, name, val)
        end
        if name == "WalkSpeed" then
            if global.IS_IN_NOCLIP then
                val = 0
                return newidx(self, name, val)
            end
            if not client.confirmation.confirmed.ws then
                return newidx(self, name, val)
            end
            if global.ui_status.master_switch_walkspeed then
                if global.ui_status.walkspeed == 16 then
                    return newidx(self, name, val)
                end
                if global.ui_status.ws_disable_if_handcuffed then
                    if player.Folder:FindFirstChild("Cuffed") then
                        return newidx(self, name, val)
                    end
                end
                val = global.ui_status.walkspeed
            end
        end
        return newidx(self, name, val)
    end
    mt.__newindex = newcclosure(newidxx)
    local function idxx(self, str)
        if global.USER_INPUT_TYPE_SWITCH then
            if str == "UserInputType" then
                if self.KeyCode == Enum.KeyCode.E then
                    self.KeyCode = Enum.KeyCode.Space
                end
            end
        end
        return idx(self, str)
    end
    mt.__index = newcclosure(idxx)
    setreadonly(mt, true)
end
--end)
