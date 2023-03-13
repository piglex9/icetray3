
        local function getInvitablePlayer()
            local isVulnerable = global.registry.isVulnerable
            local tbl = {}
            for i,v in next, client.players do
                if v ~= player then
                    if not isVulnerable(player.Team, v.Team) then
                        table.insert(tbl, v)
                    end
                end
            end
            return tbl
        end
