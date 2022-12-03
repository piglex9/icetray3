-- ICETRAY pre-V3
-- HACK.LUA 3
-- alex9#0001

--This is not the latest version
--Source from 8 July 2022

local jb = game.PlaceId == 606849621
if not jb then
    return false
end

local global = {}

local env = getrenv()
env.name = "ice tray v3"
env.discord = "https://discord.gg/5Eqt6QBfYY"

local identifyexecutor = identifyexecutor()
global.getExecutor = identifyexecutor
global.functions = {}
global.data = {}
global.gc = {}
global.loop = {}

local function service()
    env.workspace = game:GetService("Workspace")
    env.repl = game:GetService("ReplicatedStorage")
    env.players = game:GetService("Players")
    env.httpservice = game:GetService("HttpService")
    env.runservice = game:GetService("RunService")
    env.uis = game:GetService("UserInputService")
    env.teleportservice = game:GetService("TeleportService")
    env.tweenservice = game:GetService("TweenService")
    env.teams = game:GetService("Teams")
end

local function loadSynapseFunction()
    env.request = request or http_request or syn and syn.request
    if not request then
        error(global.getExecutor)
    end
    global.functions.getproto = debug.getproto or "debug.getproto does not exist"
    global.functions.getreg = debug.getregistry or getreg or "debug.getregistery does not exist"
    global.functions.getupvalues = debug.getupvalues or "debug.getupvalues does not exist"
    global.functions.getconstants = debug.getconstants or "debug.getconstants does not exist"
    global.functions.getconstant = debug.getconstant or "debug.getconstant does not exist"
    global.functions.setconstant = debug.setconstant or "debug.setconstant does not exist"
    global.functions.getupvalue = debug.getupvalue or "debug.getupvalue does not exist"
    global.functions.setupvalue = debug.setupvalue or "debug.setupvalue does not exist"
    global.functions.getprotos = debug.getprotos or "debug.getprotos does not exist"
    global.functions.getrawmetatable = getrawmetatable or "getrawmetatable does not exist"
    global.functions.setreadonly = setreadonly or make_writeable or "setreadonly/make_writeable does not exist"
    global.functions.newcclosure = newcclosure or "newcclosure does not exist"
    global.functions.setclipboard = setclipboard or "setclipboard does not exist"
    global.functions.islclosure = islclosure or "islclosure does not exist"
    global.functions.is_synapse_function = is_synapse_function or "is_synapse_function does not exist"
    for i,v in next, global.functions do
        if type(v) == "string" and string.find(v, "does not exist") then
            error(v)
        end
    end
end

local function loopService()
    local clock = os.clock()
    global.time_executed = clock
    function global.createloop(seconds, f)
        table.insert(global.loop, {
            t = 0;
            i = seconds;
            c = f;
        })
    end
    runservice.Heartbeat:connect(function()
        local c = os.clock()
        local diff = clock - c
        clock = c
        for i= 1, #global.loop do
            local v = global.loop[i]
            if v.i < c - v.t then
                v.t = c
                v.c(c, diff)
            end
        end
    end)
end

local functionload, err = pcall(function()
    service()
    loadSynapseFunction()
    loopService()
end)

if not functionload then
    error(err)
end

if not global.ui then
    local icetray = loadstring(game:HttpGet("https://raw.githubusercontent.com/piglex9/icetray3/main/ui.lua"))()
    local player = players.LocalPlayer
    local userId = player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, isReady = players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
    local window = icetray.CreateWindow("ice tray v3", content)
    global.ui = {}
    global.ui.window = {}
    global.ui.player = {}
    global.ui.vehicle = {}
    global.ui.misc = {}
    global.ui.combat = {}
    global.ui.visuals = {}
    global.ui.info = {}
    local plr = window:Tab("Player")
    local vehicle = window:Tab("Vehicle")
    local misc = window:Tab("Misc")
    local combat = window:Tab("Combat")
    local visuals = window:Tab("Visuals")
    local info = window:Tab("Info")
    global.ui.window.tab = window
    global.ui.player.tab = plr
    global.ui.visuals.tab = visuals
    global.ui.misc.tab = misc
    global.ui.vehicle.tab = vehicle
    global.ui.combat.tab = combat
    global.ui.info.tab = info
end

while true do
    if game:IsLoaded() and players.LocalPlayer.Character then
        break
    end
    task.wait(7)
end

global._loaded = false

local players = players
local repl = repl
local httpservice = httpservice
local runservice = runservice
local uis = uis
local teleportservice = teleportservice
local tweenservice = tweenservice
local teams = teams

local createloop = global.createloop

local getproto = global.functions.getproto
local getreg = global.functions.getreg
local getupvalues = global.functions.getupvalues
local getconstants = global.functions.getconstants
local getconstant = global.functions.getconstant
local setconstant = global.functions.setconstant
local getupvalue = global.functions.getupvalue
local setupvalue = global.functions.setupvalue
local getprotos = global.functions.getprotos
local getrawmetatable = global.functions.getrawmetatable
local setreadonly = global.functions.setreadonly
local newcclosure = global.functions.newcclosure
local setclipboard = global.functions.setclipboard
local islclosure = global.functions.islclosure
local is_synapse_function = global.functions.is_synapse_function

local window = global.ui.window.tab
local plr = global.ui.player.tab
local vehicle = global.ui.vehicle.tab
local misc = global.ui.misc.tab
local combat = global.ui.combat.tab
local visuals = global.ui.visuals.tab
local info = global.ui.info.tab

local function loadup()
    local function ui()
        local sections = {
            Player = plr:Section("Player");
            Marker = visuals:Section("Markers");
            Arrestaura = combat:Section("Arrest Aura");
            Openalldoors = misc:Section("Open all doors");
        }
        global.ui.sections = sections
        local function slider(section, name, min, max, callback)
            local section = sections[section]
            return section:Slider(name, min, max, callback)
        end
        global.ui.createSlider = slider
        local function toggle(section, name, callback)
            local section = sections[section]
            return section:Toggle(name, callback)
        end
        global.ui.createToggle = toggle
        local callback = {} -- really not the best way of doing it ¯\_(ツ)_/¯
        function callback.walkspeed(num)
            global.data.walkspeed = num
        end
        function callback.jumppower(num)
            global.data.jumppower = num
        end
        function callback.antiragdoll(bool)
            global.data.antiragdoll = bool
        end
        function callback.antiskydive(bool)
            global.data.antiskydive = bool
        end
        function callback.nowait(bool)
            global.data.nowait = bool
        end
        function callback.infiniteduck(bool)
            global.data.infiniteduck = bool
        end
        function callback.infinitepunch(bool)
            global.data.infinitepunch = bool
        end
        function callback.infinitejump(bool)
            global.data.infinitejump = bool
        end
        function callback.master_switch_marker(bool)
            global.data.master_switch_marker = bool
        end
        function callback.police_marker(bool)
            global.data.allow_police_marker = bool
        end
        function callback.criminal_marker(bool)
            global.data.allow_criminal_marker = bool
        end
        function callback.prisoner_marker(bool)
            global.data.allow_prisoner_marker = bool
        end
        function callback.master_switch_arrestaura(bool)
            global.data.master_switch_arrestaura = bool
        end
        function callback.range_arrestaura(num)
            global.data.range_arrestaura = num
        end
        function callback.delay_arrestaura(num)
            global.data.delay_arrestaura = num
        end
        function callback.automatic_equip_handcuffs(bool)
            global.data.automatic_equip_handcuffs = bool
        end
        function callback.master_switch_open_all_doors(bool)
            global.data.master_switch_open_all_doors = bool
        end
        local walkspeed = slider("Player", "WalkSpeed", 16, 150, callback.walkspeed)
        local jumppower = slider("Player", "JumpPower", 50, 300, callback.jumppower)
        local antiragdoll = toggle("Player", "Anti Ragdoll", callback.antiragdoll)
        local antiskydive = toggle("Player", "Anti Skydive", callback.antiskydive)
        local nowait = toggle("Player", "No Wait", callback.nowait)
        local infiniteduck = toggle("Player", "Infinite Duck", callback.infiniteduck)
        local infinitepunch = toggle("Player", "Infinite Punch", callback.infinitepunch)
        local infinitejump = toggle("Player", "Infinite Jump", callback.infinitejump)
        local master_switch_marker = toggle("Marker", "Master Switch", callback.master_switch_marker)
        local criminal_marker = toggle("Marker", "Allow Criminal Marker", callback.criminal_marker)
        local prisoner_marker = toggle("Marker", "Allow Prisoner Marker", callback.prisoner_marker)
        local police_marker = toggle("Marker", "Allow Police Marker", callback.police_marker)
        local master_switch_arrestaura = toggle("Arrestaura", "Master Switch", callback.master_switch_arrestaura)
        local range_arrestaura = slider("Arrestaura", "Range", 0, 40, callback.range_arrestaura)
        local automatic_equip_handcuffs = toggle("Arrestaura", "Automatic Equip Handcuffs", callback.automatic_equip_handcuffs)
        local open_all_doors = toggle("Openalldoors", "Master Switch", callback.open_all_doors)
    end
    ui()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local newindex = mt.__newindex
    mt.__newindex = newcclosure(function(g, w, val)
        if w == "WalkSpeed" then
            if global.data.walkspeed == 16 then
                return newindex(g, w, val)
            end
            val = global.data.walkspeed
        end
        return newindex(g, w, val)
    end)
    setreadonly(mt, true)
    local function registery()
        for i,v in next, getreg() do
            if type(v) == "function" then
                if islclosure(v) then
                    local con = getconstants(v)
                    if table.find(con, "t") and table.find(con, "i") and table.find(con, "c") then
                        for i2,v2 in next, getupvalues(v) do
                            if type(v2) == "table" then
                                for i3,v3 in next, v2 do
                                    if type(v3) == "table" then
                                        if v3.i == 1 then
                                            global.gc.pcall = v3.c
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                for i2,v2 in next, getupvalues(v) do
                    if type(v2) == "function" then
                        if islclosure(v2) then
                            local con = getconstants(v2)
                            if table.find(con, "ShouldArrest") then
                                global.gc.shouldArrest = getupvalue(getupvalue(v2,1),7)
                                -- does not work w/ latest update cause they obfuscated LocalScript
                                --global.gc.shouldPickpocket = getupvalue(getupvalue(v2,2),2)
                                --global.gc.shouldBreakout = getupvalue(getupvalue(v2,3),2)
                            end
                            if table.find(con, "ShouldEject") then
                                global.gc.shouldEject = getupvalue(v2,2)
                            end
                        end
                        for i3,v3 in next, getupvalues(v2) do
                            if type(v3) == "function" and islclosure(v3) then
                                local con = getconstants(v3)
                                if table.find(con, "SequenceRequireState") then
                                    global.gc.openDoor = v3
                                end
                            end
                        end
                    end
                    if type(v2) == "table" then
                        global.gc.doors = {}
                        if rawget(v2, "IsFlying") then
                            global.gc.paraglide = v2
                        end
                        for i3,v3 in next, v2 do
                            if type(v3) == "table" and rawget(v3, "OpenFun") and rawget(v3, "State") then
                                table.insert(global.gc.doors, v3)
                            end
                        end
                    end
                end
            end
        end
        local FallingInit = require(repl.Game.Falling).Init
        for i,v in next, getupvalues(FallingInit) do
            if type(v) == "function" and not is_synapse_function(v) then
                for i2,v2 in next, getupvalues(v) do
                    if type(v2) == "function" then
                        local con = getconstants(v2)
                        if table.find(con, "NoRagdoll") then
                            global.gc.ragdoll = v2
                        end
                    end
                end
            end
        end
        local function changers()
            local function skydive()
                -- this will disable falldamage, ragdoll and skydiving - will look into it sometime later...
                local IS_FLYING = global.gc.paraglide.IsFlying
                if not IS_FLYING then
                    return false
                end
                global.gc.paraglide.IsFlying = function(...)
                    if global.data.antiskydive then
                        return tostring(getfenv(2).script) == tostring(repl.Game.Falling)
                    end
                    return IS_FLYING(...)
                end
            end
            skydive()
            local function ragdoll()
                local ragdoll = global.gc.ragdoll
                if not ragdoll then
                    return
                end
                local antiragdoll = global.data.antiragdoll
                local bool = antiragdoll and true or not antiragdoll and false
                local u = getupvalue(ragdoll,9)
                setconstant(u,1,bool)
            end
            ragdoll()
            local function button()
                local button = require(repl.Game.DefaultActions).crawlButton
                for i,v in next, button do
                    if i == "onPressed" and type(v) == "function" then
                        for i2,v2 in next, getupvalues(v) do
                            if type(v2) == "table" then
                                for i3,v3 in next, getupvalues(v2.attemptToggleCrawling) do
                                    if type(v3) == "table" and #v3 == 3 then
                                        global.gc.lastDuckTick = v3
                                        table.remove(v3) -- ?
                                    end
                                end
                                global.gc.punch = v2
                            end
                        end
                    end
                end
            end
            button()
        end
        local function stopPcall()
            local c = global.gc.pcall
            if not c then
                error()
                return false
            end
            setupvalue(c, 2, true)
        end
        local function removeSettings()
            local player = players.LocalPlayer
            local playergui = player:FindFirstChild("PlayerGui")
            local settings = playergui:FindFirstChild("AppUI").DevPanel.Container.SETTINGS.SETTINGS
            local playerMarkers = settings:FindFirstChild("playerMarkers")
            if playerMarkers then
                playerMarkers.Visible = false
            end
        end
        local function getLocalVehicle()
            local vehicle
            local player = players.LocalPlayer
            for i,v in next, getreg() do
                if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
                    for i2,v2 in next, getupvalues(v) do
                        if type(v2) == "table" and rawget(v2, "em") and rawget(v2, "GetVehiclePacket") then
                            local g = v2.GetVehiclePacket(player)
                            if g == nil then
                                return false
                            end
                            vehicle = g
                        end
                    end
                end
            end
            return vehicle
        end
        global.gc.getLocalVehicle = getLocalVehicle
        local function getPlayerVehicle(player)
            if not player then
                return
            end
            for i,v in next, workspace.Vehicles:GetChildren() do
                local seat = v:FindFirstChild("Seat")
                local passenger = v:FindFirstChild("Passenger")
                local sname = seat and seat:FindFirstChild("PlayerName")
                if sname and sname.Value == player.Name then
                    return v
                end
                local pname = passenger and passenger:FindFirstChild("PlayerName")
                if pname and pname.Value == player.Name then
                    return v
                end
            end
        end
        global.gc.getPlayerVehicle = getPlayerVehicle
        local function getClosestPlayer(range)
            local player = players.LocalPlayer
            local target
            for i,v in next, players:GetPlayers() do
                if v ~= player then
                    if tostring(v.Team) ~= tostring(player.Team) then
                        local char = v.Character
                        if char then
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if root then
                                if (player.Character.HumanoidRootPart.Position - root.Position).magnitude < range then
                                    local master_switch_arrestaura = global.data.master_switch_arrestaura
                                    if master_switch_arrestaura and not char:FindFirstChild("Handcuffs") then
                                        target = v
                                        return target
                                    end
                                    target = v
                                end
                            end
                        end
                    end
                end
            end
            return target
        end
        global.gc.getClosestPlayer = getClosestPlayer
        local function spawnfireworks(num)
            for i,v in next, getreg() do
                if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
                    for i2,v2 in next, getupvalues(v) do
                        if type(v2) == "table" and type(rawget(v2, "Fireworks")) == "function" then
                            v2.Fireworks(num)
                        end
                    end
                end
            end
        end
        global.gc.spawnfireworks = spawnfireworks
        local markerSystem = require(repl.Game.PlayerMarkerSystem)
        local function constructMarker(player)
            return markerSystem._constructMarker(player)
        end
        global.gc.constructMarker = constructMarker
        local function setColor(player, color)
            return markerSystem._setColor(player, color)
        end
        global.gc.setColor = setColor
        local function destructMarker(player)
            return markerSystem._destructMarker(player)
        end
        global.gc.destructMarker = destructMarker
        local function doesMarkerExist(player)
            return markerSystem._doesMarkerExist(player)
        end
        global.gc.doesMarkerExist = doesMarkerExist
        local colors = {
            Prisoner = Color3.fromRGB(253, 148, 81);
            Police = Color3.fromRGB(84, 215, 253);
            Criminal = Color3.fromRGB(253, 100, 30);
        };
        global.gc.markerColors = colors
        local function equip(item)
            local player = players.LocalPlayer
            local sys = require(repl.Inventory.InventoryItemSystem)
            local isItemEquipped = require(repl.Game.ItemSystem.ItemSystem).GetLocalEquipped
            for i,v in next, sys.getInventoryItemsFor(player) do
                if v.obj.name == item and isItemEquipped() and isItemEquipped().inventoryItemValue.name == item then
                    v:AttemptSetEquipped(false)
                elseif v.obj.name == item then
                    v:AttemptSetEquipped(true)
                end
            end
        end
        global.gc.equip = equip
        local function unequipAll()
            require(repl.Inventory.InventoryItemSystem).unequipAll()
        end
        global.gc.unequipAll = unequipAll
        local function hasItemEquipped(item)
            local isItemEquipped = require(repl.Game.ItemSystem.ItemSystem).GetLocalEquipped
            return isItemEquipped() and isItemEquipped().inventoryItemValue.name == item or nil
        end
        global.gc.hasItemEquipped = hasItemEquipped
        local function changeplayerstate()
            spawnfireworks(10)
            local function requestJump()
                local player = players.LocalPlayer
                local hum = player.Character:FindFirstChild("Humanoid")
                if global.data and global.data.infinitejump and hum then
                    player.Character.Humanoid:ChangeState("Jumping")
                end
            end
            uis.JumpRequest:connect(requestJump)
        end
        stopPcall()
        changers()
        removeSettings()
        changeplayerstate()
    end
    registery()
end
loadup()


local function icetray()
    local function main()
        local player = players.LocalPlayer
        local char = player.Character
        if not char then
            return false
        end
        local function playersTracker()
            local data = global.playersTracker
            if data then
                return false
            end
            data = {}
            players.PlayerAdded:connect(function(player)
                local check = data[player]
                if not check then
                    data[player] = {
                        arrestsAttempt = 0;
                    }
                end
                check = data[player]
            end)
            players.PlayerRemoving:connect(function(player)
                local check = data[player]
                if check then
                    check[player] = nil
                end
            end)
            local player = players.LocalPlayer
            for i,v in next, players:GetPlayers() do
                if v ~= player then
                    local check = data[v]
                    if not check then
                        data[v] = {
                            arrestsAttempt = 0;
                        }
                        check = data[v]
                    end
                    check = data[v]
                end
            end
            global.playersTracker = data
        end
        playersTracker()
        local function infiniteduck()
            local infiniteduck = global.data.infiniteduck
            if not infiniteduck then
                return false
            end
            local lastDuckTick = global.gc.lastDuckTick
            if not lastDuckTick then
                return false
            end
            local t = tick() - 2
            table.remove(lastDuckTick)
            table.insert(lastDuckTick, 1, t)
        end
        infiniteduck()
        local function infinitepunch()
            local bool = global.data.infinitepunch
            local punch = global.gc.punch
            if not punch then
                return false
            end
            local t = bool and 0 or 0.5
            setconstant(punch.attemptPunch, 3, t)
        end
        infinitepunch()
        local function markerFix()
            local allowed = {}
            global.gc.markers_allowed = allowed
            local function addTeam(team)
                table.insert(allowed, tostring(team))
            end
            local function removeTeam(team)
                for num, name in next, allowed do
                    if name == team then
                        table.remove(allowed, num)
                    end
                end
            end
            local function isTeamAllowed(team)
                if table.find(allowed, tostring(team)) then
                    return true
                end
                return false
            end
            global.gc.isTeamAllowed = isTeamAllowed
            local allow_police_marker = global.data.allow_police_marker
            local allow_criminal_marker = global.data.allow_criminal_marker
            local allow_prisoner_marker = global.data.allow_prisoner_marker
            local function getAllowed()
                local findPrisoner = table.find(allowed, "Prisoner")
                local findPolice = table.find(allowed, "Police")
                local findCriminal = table.find(allowed, "Criminal")
                if allow_prisoner_marker and not findPrisoner then
                    addTeam("Prisoner")
                elseif not allow_prisoner_marker and findPrisoner then
                    removeTeam("Prisoner")
                end
                if allow_criminal_marker and not findCriminal then
                    addTeam("Criminal")
                elseif not allow_criminal_marker and findCriminal then
                    removeTeam("Criminal")
                end
                if allow_police_marker and not findPolice then
                    addTeam("Police")
                elseif not allow_police_marker and findPolice then
                    removeTeam("Police")
                end
            end
            getAllowed()
        end
        markerFix()
        local function createMarker()
            local master_switch = global.data.master_switch_marker
            local doesMarkerExist = global.gc.doesMarkerExist
            local constructMarker = global.gc.constructMarker
            local destructMarker = global.gc.destructMarker
            local setColor = global.gc.setColor
            local markerColors = global.gc.markerColors
            local isTeamAllowed = global.gc.isTeamAllowed
            if not master_switch then
                for i,v in next, players:GetPlayers() do
                    if doesMarkerExist(v) then
                        destructMarker(v)
                    end
                end
                return false
            end
            for i,v in next, players:GetPlayers() do
                if v ~= player then
                    local team, teamString = v.Team, tostring(v.Team)
                    local isTeamAllowed = isTeamAllowed(team)
                    local color
                    if isTeamAllowed then
                        if markerColors[teamString] then
                            color = markerColors[teamString]
                        end
                        if not doesMarkerExist(v) then
                            if not color then
                                return false
                            end
                            constructMarker(v)
                            setColor(v, color)
                        end
                    else
                        local doesMarkerExist = doesMarkerExist(v)
                        if master_switch and not doesMarkerExist then
                            if teamString == tostring(player.Team) then
                                color = markerColors[teamString]
                                if color then
                                    constructMarker(v)
                                    setColor(v, color)
                                    return true
                                end
                                return false
                            end
                        end
                        if doesMarkerExist then
                            if teamString ~= tostring(player.Team) then
                                destructMarker(v)
                            end
                        end
                    end
                end
            end
        end
        createMarker()
        local function nowait()
            local nowait = global.data.nowait
            local specs = require(repl.Module.UI).CircleAction.Specs
            if not nowait then
                local oldSpecs = global.gc.circleActionSpecs
                if not oldSpecs then
                    return false
                end
                for i,v in next, oldSpecs do
                    if type(v) == "table" then
                        for i2,v2 in next, v do
                            for i3,v3 in next, specs do
                                v3.Timed = v2.Timed
                                if v3.Dist and v2.Dist then
                                    v3.Dist = v2.Dist
                                end
                            end
                        end
                    end
                end
                return false
            end
            local localization = require(repl.Module.Localization)
            for i,v in next, specs do
                if v.Name == localization:FormatByKey("Action.Arrest") then
                    v.Timed = false
                    local function logic_nowait()
                        return v
                    end
                    global.gc.circle_arrest = logic_nowait
                end
                if v.Timed then
                    v.Timed = false
                end
            end
        end
        nowait()
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = player.Character.Humanoid.WalkSpeed
            hum.JumpPower = global.data.jumppower
        end
    end
    createloop(0, main)
    local function arrestaura()
        local master_switch_arrestaura = global.data.master_switch_arrestaura
        if not master_switch_arrestaura then
            return false
        end
        local player = players.LocalPlayer
        if player.Team ~= teams.Police then
            return false
        end
        local range = global.data.range_arrestaura
        local automatic_equip_handcuffs = global.data.automatic_equip_handcuffs
        local getClosestPlayer = global.gc.getClosestPlayer
        local equip = global.gc.equip
        local hasItemEquipped = global.gc.hasItemEquipped
        local target = getClosestPlayer(range)
        if target then
            if tostring(target.Team) == "Prisoner" then
                return false
            end
            local handcuffs = hasItemEquipped("Handcuffs")
            local shouldArrest = global.gc.shouldArrest
            local shouldEject = global.gc.shouldEject
            local getPlayerVehicle = global.gc.getPlayerVehicle
            local attempts = global.playersTracker[target]
            if not target.Character:FindFirstChild("Handcuffs") then
                if not handcuffs and not automatic_equip_handcuffs then
                    return false
                end
                if not handcuffs and automatic_equip_handcuffs then
                    equip("Handcuffs")
                end
                local vehicle = getPlayerVehicle(target)
                if vehicle then
                    shouldEject(target)
                end
                attempts.arrestsAttempt = attempts.arrestsAttempt + 1
                shouldArrest(target)
            end
            if target.Character:FindFirstChild("Handcuffs") then
                attempts.arrestsAttempt = 0
                return true
            end
        end
    end
    createloop(0.5, arrestaura)
    local function opendoors()
        local bool = global.data.master_switch_open_all_doors
        if not bool then
            return false
        end
        local doors = global.gc.doors
        local openf = global.gc.openDoor
        for i,v in next, doors do
            openf(v)
        end
    end
    createloop(2, opendoors)
end

return icetray()
