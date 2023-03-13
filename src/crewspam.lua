    --...
    local function crews()
        local function crewCorrection()
            local function isLocalInCrew()
                if player.PlayerGui.AppUI.Buttons.Sidebar.Crew:FindFirstChild("Crew").Visible then
                    return true
                end
                return false
            end
            local function buyHome()
                for i,v in next, client.modules.ui.CircleAction.Specs do
                    if v.Name == "Buy" then
                        for i2,v2 in next, getupvalues(v.Callback) do
                            if type(v2) == "table" and rawget(v2, "_homePurchaseRemote") then
                                if v2._priceValue.Value <= 7500 then
                                    v2._homePurchaseRemote:FireServer()
                                    break
                                end
                            end
                        end
                    end
                end
            end
            local function makeCrewName()
                local crew = client.modules.crewUISystem
                crew._attemptSetCrewName("dis.gg/ICETRAY")
            end
            local function isInCrew(player)
                local crew = client.modules.crewUtils
                return crew.getAssignedCrew(player) ~= nil
            end
            local function isInSpammerCrew(plr)
                local crew = client.modules.crewUtils
                if crew.getAssignedCrew(plr) ~= nil then
                    local getCrewMembers = crew.getCrewMembers(crew.getAssignedCrew(plr))
                    for i,v in next, getCrewMembers do
                        if tostring(v.Name) == tostring(player.Name) then
                            return true
                        end
                    end
                end
            end
            local function inviteCrewMember(player)
                local crew = client.modules.crewUISystem
                local name = ("%s"):format(player.Name):sub(1, 5)
                if not isInSpammerCrew(player) then
                    return crew._attemptAddMember(name)
                end
                return false
            end
            local function removeCrewMember(player)
                local crew = client.modules.crewSystem
                if isInSpammerCrew(player) then
                    return crew.removeCrewMember(player)
                end
                return false
            end
            local function loop()
                local bool = global.ui_status.spam_crew_invites
                if bool then
                    if not isLocalInCrew() then
                        buyHome()
                        task.wait(0.1)
                        makeCrewName()
                        return true
                    end
                    if isLocalInCrew() then
                        local getInvitablePlayer = global.registry.getInvitablePlayer()
                        for i,v in next, getInvitablePlayer do
                            if v then
                                if not isInCrew(v) or not isInSpammerCrew(v) then
                                    inviteCrewMember(v)
                                end
                                if isInCrew(v) or isInSpammerCrew(v) then
                                    removeCrewMember(v)
                                end
                                task.wait()
                            end
                        end
                        makeCrewName()
                    end
                end
            end
            createloop(2.1, loop)
        end
        -- return crewCorrection()
    end
    callback:new("toggle", "spam_crew_invites", crews)
