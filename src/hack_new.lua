-- ICETRAY V3
-- HACK.LUA
-- alex9#0001

-- Source from 20 September 2022
-- Version 3.0.0

local jb
while true do
	wait()
	if jb then
		break
	end
	jb = game.PlaceId == 606849621
end

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/piglex9/icetray3/main/src/ui.lua"))()

local env = getrenv()
env.discord_code = "5Eqt6QBfYY"

local identifyexecutor = identifyexecutor()
global.getExecutor = identifyexecutor
global.registry = {
    doors = {}
}
global.doors = {}

local function icetrayload()
	local function version()
		global.version = "3.0.0"
	end
    global.functions = {}
    local function synfunction()
        global.functions["getproto"] = debug.getproto or ("debug.getproto does not exist")
        global.functions["getreg"] = debug.getregistry or getreg or ("debug.getregistry does not exist")
        global.functions["getupvalues"] = debug.getupvalues or ("debug.getupvalues does not exist")
        global.functions["getconstants"] = debug.getconstants or ("debug.getconstants does not exist")
        global.functions["getconstant"] = debug.getconstant or ("debug.getconstant does not exist")
        global.functions["setconstant"] = debug.setconstant or ("debug.setconstant does not exist")
        global.functions["getupvalue"] = debug.getupvalue or ("debug.getupvalue does not exist")
        global.functions["setupvalue"] = debug.setupvalue or ("debug.setupvalue does not exist")
        global.functions["getprotos"] = debug.getprotos or ("debug.getprotos does not exist")
        global.functions["getrawmetatable"] = getrawmetatable or ("getrawmetatable does not exist")
        global.functions["setreadonly"] = setreadonly or make_writeable or ("setreadonly/make_writeable does not exist")
        global.functions["newcclosure"] = newcclosure or ("newcclosure does not exist")
        global.functions["setclipboard"] = setclipboard or ("setclipboard does not exist")
        global.functions["islclosure"] = islclosure or ("islclosure does not exist")
        global.functions["is_synapse_function"] = is_synapse_function or ("is_synapse_function does not exist")
    end
    local function serviceloop()
        local clock = os.clock()
        local loop = {}
        global.time_executed = clock
        function global.createloop(seconds, f)
            table.insert(loop, {
                t = 0;
                i = seconds;
                c = f;
            })
        end
        runservice.Heartbeat:connect(function()
            local c = os.clock()
            local diff = clock - c
            clock = c
            for i= 1, #loop do
                local v = loop[i]
                if v.i < c - v.t then
                    v.t = c
                    v.c(c, diff)
                end
            end
        end)
    end
	  version()
    synfunction()
    serviceloop()
end
icetrayload()

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
    local function send_console_developer(text)
        local Cmdr = require(repl.CmdrClient)
        return Cmdr.Events.AddLine(("ICETRAY3 : %s"):format(tostring(text)))
    end
    local log = send_console_developer
    local function ui()
        global.ui_status = {}
        local sections = {
            Player = plr:Section("Player");
            Marker = visuals:Section("Markers");
            Gunmods = combat:Section("Gun Mods");
            GunmodsMisc = combat:Section("Misc");
            Arrestaura = combat:Section("Arrest Aura");
            Misc = misc:Section("Misc");
            Opendoors = misc:Section("Open doors");
            Info = info:Section("Info");
            CarModify = vehicle:Section("Car Modifications");
            VehicleMisc = vehicle:Section("Misc");
            PlayerMisc = plr:Section("Misc");
        }
        local function slider(section, name, min, max, callback)
            local section = sections[section]
            return section:Slider(name, min, max, callback)
        end
        local function toggle(section, name, callback)
            local section = sections[section]
            return section:Toggle(name, callback)
        end
        local function label(section, text)
            local section = sections[section]
            return section:Label(text)
        end
        local function button(section, name, callback)
            local section = sections[section]
            return section:Button(name, callback)
        end
        local callback = {} -- worst way of doing this.. ¯\_(ツ)_/¯
        local function sections()
            local function player()
                function callback.walkspeed(num)
                    global.ui_status.walkspeed = num
                end
                function callback.jumppower(num)
                    global.ui_status.jumppower = num
                end
                function callback.antiragdoll(bool)
                    global.ui_status.antiragdoll = bool
                end
                function callback.antiskydive(bool)
                    global.ui_status.antiskydive = bool
                end
                function callback.nowait(bool)
                    global.ui_status.nowait = bool
                end
                function callback.infinitepunch(bool)
                    global.ui_status.infinitepunch = bool
                end
                function callback.alwaysjump(bool)
                    global.ui_status.alwaysjump = bool
                end
                function callback.allow_equip_on_duck(bool)
                    global.ui_status.allow_equip_on_duck = bool
                end
                local ws = slider("Player", "WalkSpeed", 16, 150, callback.walkspeed)
                local jp = slider("Player", "JumpPower", 50, 300, callback.jumppower)
                local antiragdoll = toggle("Player", "Anti Ragdoll", callback.antiragdoll)
                local antiskydive = toggle("Player", "Anti Skydive", callback.antiskydive)
                local alwaysjump = toggle("Player", "Always Jump", callback.alwaysjump)
                local nowait = toggle("PlayerMisc", "No Wait", callback.nowait)
                local infpunch = toggle("PlayerMisc", "Infinite Punch", callback.infinitepunch)
                local allow_equip_on_duck = toggle("PlayerMisc", "Allow Equip on Duck", callback.allow_equip_on_duck)
            end
            local function vehicle()
                function callback.master_switch_carmodify(bool)
                    global.ui_status.master_switch_carmodify = bool
                end
                function callback.car_speed(num)
                    global.ui_status.car_speed = num
                end
                function callback.car_brakes(num)
                    global.ui_status.car_brakes = num
                end
                function callback.car_turnspeed(num)
                    global.ui_status.car_turnspeed = num
                end
                function callback.car_height(num)
                    global.ui_status.car_height = num
                end
                function callback.allow_equipping(bool)
                    global.ui_status.allow_equipping = bool
                end 
                local master_switch_carmodify = toggle("CarModify", "Master Switch", callback.master_switch_carmodify)
                local car_speed = slider("CarModify", "Speed", 1, 10, callback.car_speed)
                local car_brakes = slider("CarModify", "Brakes", 1, 10, callback.car_brakes)
                local car_turnspeed = slider("CarModify", "Turn Speed", 1, 10, callback.car_turnspeed)
                local car_height = slider("CarModify", "Height", 1, 10, callback.car_height)
                local allow_equipping = toggle("VehicleMisc", "Allow Equipping", callback.allow_equipping)
            end
            local function misc()
                function callback.always_keycard(bool)
                    global.ui_status.always_keycard = bool
                end
                function callback.break_npcs(bool)
                    global.ui_status.break_npcs = bool
                end
                function callback.master_switch_open_doors(bool)
                    global.ui_status.master_switch_open_doors = bool
                end
                local always_keycard = toggle("Misc", "Always Keycard", callback.always_keycard)
                local break_npcs = toggle("Misc", "Break NPCs", callback.break_npcs)
                local open_doors = toggle("Opendoors", "Master Switch", callback.master_switch_open_doors)
            end
            local function combat()
                function callback.master_switch_gunmods(bool)
                    global.ui_status.master_switch_gunmods = bool
                end
                function callback.master_switch_arrestaura(bool)
                    global.ui_status.master_switch_arrestaura = bool
                end
                function callback.range_arrestaura(num)
                    global.ui_status.range_arrestaura = num
                end
                function callback.automatic_equip_handcuffs(bool)
                    global.ui_status.automatic_equip_handcuffs = bool
                end
                function callback.disable_turrets(bool)
                    global.ui_status.disable_turrets = bool
                end
                local master_switch_gunmods = toggle("Gunmods", "Master Switch", callback.master_switch_gunmods)
                local master_switch_arrestaura = toggle("Arrestaura", "Master Switch", callback.master_switch_arrestaura)
                local arrestaura_range = slider("Arrestaura", "Range", 0, 40, callback.range_arrestaura)
                local auto_equip_arrestaura = toggle("Arrestaura", "Automatic Equip Handcuffs", callback.automatic_equip_handcuffs)
                local disableturrets = toggle("GunmodsMisc", "Disable Turrets", callback.disable_turrets)
            end
            local function visuals()
                function callback.master_switch_marker(bool)
                    global.ui_status.master_switch_marker = bool
                end
                function callback.police_marker(bool)
                    global.ui_status.allow_police_marker = bool
                end
                function callback.criminal_marker(bool)
                    global.ui_status.allow_criminal_marker = bool
                end
                function callback.prisoner_marker(bool)
                    global.ui_status.allow_prisoner_marker = bool
                end
                local master_switch_marker = toggle("Marker", "Master Switch", callback.master_switch_marker)
                local allow_criminal_marker = toggle("Marker", "Allow Criminal Marker", callback.criminal_marker)
                local allow_prisoner_marker = toggle("Marker", "Allow Prisoner Marker", callback.prisoner_marker)
                local allow_police_marker = toggle("Marker", "Allow Police Marker", callback.police_marker)
            end
            local function info()
                function callback.discord()
                    setclipboard("https://discord.gg/"..discord_code)
                end
                local infolabel = label("Info", "Credits:\nalex9#0001 (870050524857258055)")
                local infoversion = label("Info", ("Version: v%s"):format(global.version))
                local infobutton = button("Info", "Copy Discord Link to clipboard", callback.discord)
            end
            player()
            vehicle()
            misc()
            combat()
            visuals()
            info()
        end
        sections()
        local function run()
            global.run = false
            if global.ui_status.walkspeed == nil and global.ui_status.jumppower == nil then
                global.run = true
            end
            if global.run then
                local player = players.LocalPlayer
                return player:Kick("icetray was not runned correctly?")
            end
        end
        createloop(0.5, run)
    end
    ui()
    local function wsindex()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local newindex = mt.__newindex
        mt.__newindex = newcclosure(function(g, w, val)
            if w == "WalkSpeed" then
                if global.ui_status.walkspeed == 16 then
                    return newindex(g, w, val)
                end
                val = global.ui_status.walkspeed
            end
            return newindex(g, w, val)
        end)
        setreadonly(mt, true)
    end
    wsindex()
    local function registry()
        local markerColors = {
            Prisoner = Color3.fromRGB(253, 148, 81);
            Police = Color3.fromRGB(84, 215, 253);
            Criminal = Color3.fromRGB(253, 100, 30);
        };
        local markerSystem = require(repl.Game.PlayerMarkerSystem)
        local function constructMarker(player)
            return markerSystem._constructMarker(player)
        end
        local function setColor(player, color)
            return markerSystem._setColor(player, color)
        end
        local function destructMarker(player)
            return markerSystem._destructMarker(player)
        end
        local function doesMarkerExist(player)
            return markerSystem._doesMarkerExist(player)
        end
        local function getLocalVehicle()
            local player = players.LocalPlayer
            for i,v in next, getreg() do
                if type(v) == "function" then
                    for i2,v2 in next, getupvalues(v) do
                        if type(v2) == "table" and rawget(v2, "GetVehiclePacket") then
                            return v2.GetVehiclePacket(player)
                        end
                    end
                end
            end
        end
        local function getPlayerVehicle(player)
            assert(player)
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
        for i,v in next, getreg() do
            if type(v) == "function" then
                if islclosure(v) then
                    local con = getconstants(v)
                    if table.find(con, "t") and table.find(con, "i") and table.find(con, "c") then
                        for i2,v2 in next, getupvalues(v) do
                            if type(v2) == "table" then
                                for i3,v3 in next, v2 do
                                    if type(v3) == "table" then
                                        if v3.i == 1 and type(v3.c) == "function" then
                                            global.registry.pcall = v3.c
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not is_synapse_function(v) then
                        for i2,v2 in next, getupvalues(v) do
                            if type(v2) == "table" and type(rawget(v2, "Fireworks")) == "function" then
                                global.registry.fireworks = v2.Fireworks
                            end
                        end
                    end
                end
                for i2,v2 in next, getupvalues(v) do
                    if type(v2) == "function" then
                        if islclosure(v2) then
                            local con = getconstants(v2)
                            if table.find(con, "ShouldArrest") then
                                global.registry.shouldArrest = getupvalue(v2,1)
                                global.registry.shouldPickpocket = getupvalue(v2,3)
                            end
                            if table.find(con, "ShouldEject") then
                                global.registry.shouldEject = getupvalue(v2,2)
                            end
                        end
                    end
                    if type(v2) == "table" then
                        if rawget(v2, "IsFlying") then
                            global.registry.paraglide = v2
                        end
                        for i3,v3 in next, v2 do
                            if type(v3) == "table" and rawget(v3, "Tag") and rawget(v3, "Part") then
                                table.insert(global.registry.doors, v3.Fun)
                            end
                            if type(v3) == "table" and rawget(v3, "OpenFun") and rawget(v3, "State") then
                                table.insert(global.doors, v3)
                            end
                        end
                    end
                end
            end
        end
        local function stopPcall()
            local c = global.registry.pcall
            if not c then
                error("restart game and execute again. in-game error bug.")
                return false
            end
            setupvalue(c, 2, true)
        end
        stopPcall()
        local function hasItemEquipped(item)
            local isItemEquipped = require(repl.Game.ItemSystem.ItemSystem).GetLocalEquipped()
            return isItemEquipped and isItemEquipped.inventoryItemValue.name == item or false
        end
        local function unequipAll()
            return require(repl.Inventory.InventoryItemSystem).unequipAll()
        end
        local function equip(item)
            local player = players.LocalPlayer
            local sys = require(repl.Inventory.InventoryItemSystem)
            for i,v in next, sys.getInventoryItemsFor(player) do
                if v.obj.name == item and hasItemEquipped(item) then
                    unequipAll()
                end
                if v.obj.name == item then
                    v:AttemptSetEquipped(true)
                end
            end
        end
        local function changeplayerstate()
            local function requestJump()
                local player = players.LocalPlayer
                local hum = player.Character:FindFirstChild("Humanoid")
                if global.ui_status and global.ui_status.alwaysjump and hum then
                    player.Character.Humanoid:ChangeState("Jumping")
                end
            end
            uis.JumpRequest:connect(requestJump)
        end
        changeplayerstate()
        local function humanoidCorrection()
            local player = players.LocalPlayer
            local function loop()
                local char = player.Character
                if not char then
                    return false
                end
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum.WalkSpeed = global.ui_status.walkspeed
                    hum.JumpPower = global.ui_status.jumppower
                end
            end
            createloop(0, loop)
        end
        humanoidCorrection()
        local function playerUtilsCorrection()
            local function KeycardCorrection()
                local player = players.LocalPlayer
                local function hook()
                    local bool = global.ui_status.always_keycard
                    if tostring(player.Team) == "Police" then
                        return true
                    end
                    return bool
                end
                require(repl.Game.PlayerUtils).hasKey = hook
            end
            KeycardCorrection()
        end
        playerUtilsCorrection()
        global.registry.markerColors = markerColors
        global.registry.getLocalVehicle = getLocalVehicle
        global.registry.getPlayerVehicle = getPlayerVehicle
        global.registry.constructMarker = constructMarker
        global.registry.setColor = setColor
        global.registry.destructMarker = destructMarker
        global.registry.doesMarkerExist = doesMarkerExist
        global.registry.hasItemEquipped = hasItemEquipped
        global.registry.unequipAll = unequipAll
        global.registry.equip = equip
    end
    registry()
    local function features()
        local function punch()
            local function loop()
                local bool = global.ui_status.infinitepunch
                local buttons = global.registry.buttons
                if not buttons then
                    return false
                end
                local c = bool and 0 or 0.5
                setconstant(buttons.attemptPunch, 3, c)
            end
            createloop(0, loop)
        end
        punch()
        local function circleactions()
            local data = {}
            local function on_loadup()
                global.registry.circleActionSpecs = require(repl.Module.UI).CircleAction.Specs
                local localization = require(repl.Module.Localization)
                for i,v in next, global.registry.circleActionSpecs do
                    if v.Name == localization:FormatByKey("Action.Arrest") then
                        table.insert(data, v)    
                    end
                    if v.Timed == true and v.Duration and v.Duration > 0 then
                        table.insert(data, v)
                    end
                end
            end
            on_loadup()
            local function nowait()
                local bool = global.ui_status.nowait
                if bool then
                    for i,v in next, require(repl.Module.UI).CircleAction.Specs do
                        if v.Duration and v.Duration > 0 then
                            v.Duration = 0
                        end
                    end
                else
                    for i,v in next, require(repl.Module.UI).CircleAction.Specs do
                        if v.Name == data.Name and data.Duration and v.Duration == 0 then
                            v.Duration = data.Duration
                        end
                    end
                end
            end
            local function loop()
                nowait()
            end
            createloop(1, loop)
        end
        circleactions()
        local function skydive()
            local getSkydiveTrack = require(repl.Game.CharacterAnim).getSkydiveTrack
            local function hook()
                if global.ui_status.antiskydive then
                    return wait(9e9)
                end 
                return getSkydiveTrack()
            end
            require(repl.Game.CharacterAnim).getSkydiveTrack = hook
            local function loop()
                if global.ui_status.antiskydive then
                    setupvalue(getupvalue(require(repl.Game.Falling).Init, 18), 14, false) -- #9
                    return true
                end
                return false
            end
            createloop(0, loop)
        end
        skydive()
        local function ragdoll()
            local ragdoll = require(repl.Module.AlexRagdoll).Ragdoll
            local function hook(...)
                if global.ui_status.antiragdoll then
                    return wait(9e9)
                end
                return ragdoll(...)
            end
            require(repl.Module.AlexRagdoll).Ragdoll = hook
        end
        ragdoll()
        local function vehicleCorrection()
            local function carModify()
                local function on_loadup()
                    local player = players.LocalPlayer
                    player.Character.ChildAdded:connect(function(object)
                        local bool = global.ui_status.master_switch_carmodify
                        if not bool then
                            return false
                        end
                        local car = global.registry.getLocalVehicle()
                        local tbl = {
                            speed = global.ui_status.car_speed;
                            brakes = global.ui_status.car_brakes;
                            turnspeed = global.ui_status.car_turnspeed;
                            height = global.ui_status.car_height;
                        }
                        if object.Name == "InVehicle" then
                            car.GarageEngineSpeed = tbl.speed
                            car.GarageBrakes = tbl.brakes
                            car.TurnSpeed = tbl.turnspeed
                            car.Height = tbl.height
                        end
                    end)
                end
                on_loadup()
                local car
                local function loop()
                    local bool = global.ui_status.master_switch_carmodify
                    if not bool then
                        return false
                    end
                    local player = players.LocalPlayer
                    if not global.registry.getPlayerVehicle(player) then
                        car = nil
                        return car
                    end
                    if car == nil then
                        car = global.registry.getLocalVehicle()
                    end
                    local car_speed = global.ui_status.car_speed
                    local car_brakes = global.ui_status.car_brakes
                    local car_turnspeed = global.ui_status.car_turnspeed
                    local car_height = global.ui_status.car_height
                    if car then
                        if car_speed ~= car.GarageEngineSpeed then
                            car.GarageEngineSpeed = car_speed
                        end
                        if car.GarageBrakes ~= car_brakes then
                            car.GarageBrakes = car_brakes
                        end
                        if car.TurnSpeed ~= car_turnspeed then
                            car.TurnSpeed = car_turnspeed
                        end
                        if car.Height ~= car_height then
                            car.Height = car_height
                        end
                        return true
                    end
                    return false
                end
                createloop(0.5, loop)
            end
            carModify()
            local function allow_equipping()
                local function on_loadup()
                    for i,v in next, require(repl.Inventory.InventoryItemSystem)._equipConditions do
                        local con = getconstants(v)
                        if table.find(con, "GetLocalVehiclePacket") then
                            global.registry._equipconditions = v
                        end
                        if table.find(con, "IsCrawling") then
                            global.registry.iscrawling = v
                        end
                    end
                end
                on_loadup()
                local hook = {
                    InVehicle = {
                        GetLocalVehiclePacket = function()
                            local bool = global.ui_status.allow_equipping
                            if bool then
                                return false
                            end
                            return global.registry.getLocalVehicle() ~= nil
                        end;
                    };
                }
                setupvalue(global.registry._equipconditions,1,hook.InVehicle)
                local function loop()
                    local bool = global.ui_status.allow_equip_on_duck
                    if bool then
                        getupvalue(global.registry.iscrawling,1).IsCrawling = false
                    end
                end
                createloop(0, loop)
            end
            allow_equipping()
        end
        vehicleCorrection()
        local function npc_correction()
            local function on_loadup()
                global.registry.canSeeTarget = require(repl.GuardNPC.GuardNPCShared).canSeeTarget
            end
            on_loadup()
            local function hook(x, y)
                local bool = global.ui_status.break_npcs
                local canSeeTarget = global.registry.canSeeTarget
                if bool then
                    return wait(9e9)
                end
                return canSeeTarget(x, y)
            end
            require(repl.GuardNPC.GuardNPCShared).canSeeTarget = hook
        end
        npc_correction()
        local function button()
            local button = require(repl.Game.DefaultActions).crawlButton
            for i,v in next, button do
                if i == "onPressed" and type(v) == "function" then
                    for i2,v2 in next, getupvalues(v) do
                        if type(v2) == "table" then
                            global.registry.buttons = v2
                        end
                    end
                end
            end
        end
        button()
        local function gunmods()
            local guns = {}
            local function loop()
                local bool = global.ui_status.master_switch_gunmods
                for i,v in next, repl.Game.ItemConfig:GetChildren() do
                    local cfg = require(v)
                    if not bool then
                        if cfg.FireAuto then
                            cfg.FireAuto = guns.FireAuto
                            table.insert(guns, cfg)
                        end
                    else
                        cfg.FireAuto = not guns.FireAuto
                    end
                end
            end
            createloop(0, loop)
        end
        gunmods()
        local function turrets()
            local function on_loadup()
                global.registry.turretfire = require(repl.Game.MilitaryTurret.MilitaryTurret)._fire
            end
            on_loadup()
            local function hook(x, y)
                local bool = global.ui_status.disable_turrets
                local turretfire = global.registry.turretfire
                if bool then
                    return wait(9e9)
                end
                return turretfire(x, y)
            end
            require(repl.Game.MilitaryTurret.MilitaryTurret)._fire = hook
        end
        turrets()
        local function arrestaura()
            local function on_loadup()
                local function getClosestPlayer(range)
                    local player = players.LocalPlayer
                    local function target()
                        for i,v in next, players:GetPlayers() do
                            if v ~= player then
                                if tostring(v.Team) ~= tostring(player.Team) then
                                    local char = v.Character
                                    if char then
                                        local hum = char:FindFirstChild("Humanoid")
                                        local root = char:FindFirstChild("HumanoidRootPart")
                                        if hum and root and hum.Health > 0 then
                                            if (player.Character.HumanoidRootPart.Position - root.Position).magnitude < range then
                                                if not char:FindFirstChild("Handcuffs") then
                                                    target = v
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        return target
                    end
                    return target()
                end
                global.registry.getClosestPlayer = getClosestPlayer
            end
            on_loadup()
            local getClosestPlayer = global.registry.getClosestPlayer
            local equip = global.registry.equip
            local hasItemEquipped = global.registry.hasItemEquipped
            local function isPrisoner(target)
                return tostring(target.Team) == "Prisoner"
            end
            local function ejectPlayer(vehicle)
                local shouldEject = global.registry.ShouldEject
                shouldEject(vehicle)
                return true
            end
            local function arrestPlayer(target)
                local shouldArrest = global.registry.shouldArrest
                shouldArrest(target)
                return true
            end
            local function checkIfHandcuffs(target)
                local char = target.Character
                if char:FindFirstChild("Handcuffs") then
                    return true
                end
                return false
            end
            local function getVehicle(target)
                local getPlayerVehicle = global.registry.getPlayerVehicle
                local vehicle = getPlayerVehicle(target)
                return vehicle
            end
            local function hasHandcuffs()
                if not hasItemEquipped("Handcuffs") then
                    return true
                end
                return false
            end
            local function getHandcuffs()
                equip("Handcuffs")
            end
            local function loop()
                local player = players.LocalPlayer
                if player.Team ~= teams.Police then
                    return false
                end
                local master_switch_arrestaura = global.ui_status.master_switch_arrestaura
                if not master_switch_arrestaura then
                    return false
                end
                local range = global.ui_status.range_arrestaura
                local automatic_equip_handcuffs = global.ui_status.automatic_equip_handcuffs
                local target = getClosestPlayer(range)
                if target then
                    if isPrisoner(target) then
                        return false
                    end
                    if not checkIfHandcuffs(target) then
                        if not hasHandcuffs() and not automatic_equip_handcuffs then
                            return false
                        end
                        if not hasHandcuffs() and automatic_equip_handcuffs then
                            getHandcuffs()
                        end
                        local targetVehicle = getVehicle(target)
                        if targetVehicle then
                            ejectPlayer(targetVehicle)
                        end
                        arrestPlayer(target)
                    end
                    if checkIfHandcuffs(target) then
                        return true
                    end
                end
                createloop(0, loop)
            end
        end
        arrestaura()
        local function doors()
            local function loop()
                local bool = global.ui_status.master_switch_open_doors
                local doors = global.doors
                local open = global.registry.doors
                if not bool then
                    return false
                end
                for i,v in next, doors do
                    open[i](v.Part)
                end
            end
            createloop(3, loop)
        end
        doors()
        local function marker()
            local function markerfix()
                local allowed = {}
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
                local function loop()
                    local allow_police_marker = global.ui_status.allow_police_marker
                    local allow_criminal_marker = global.ui_status.allow_criminal_marker
                    local allow_prisoner_marker = global.ui_status.allow_prisoner_marker
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
                createloop(0, loop)
                global.registry.markers_allowed = allowed
                global.registry.isTeamAllowed = isTeamAllowed
            end
            markerfix()
            local function markercreate()
                local doesMarkerExist = global.registry.doesMarkerExist
                if not doesMarkerExist then
                    return false
                end
                local constructMarker = global.registry.constructMarker
                local destructMarker = global.registry.destructMarker
                local setColor = global.registry.setColor
                local markerColors = global.registry.markerColors
                local isTeamAllowed = global.registry.isTeamAllowed
                local function loop()
                    local player = players.LocalPlayer
                    local master_switch = global.ui_status.master_switch_marker
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
                createloop(0, loop)
            end
            markercreate()
        end
        marker()
        local function on_loadup()
            local function removeSettings()
                local player = players.LocalPlayer
                local playergui = player:FindFirstChild("PlayerGui")
                local settings = playergui:FindFirstChild("AppUI").DevPanel.Container.SETTINGS.SETTINGS
                local playerMarkers = settings:FindFirstChild("playerMarkers")
                if playerMarkers then
                    playerMarkers.Visible = false
                end
            end
            removeSettings()
        end
        on_loadup()
    end
    features()
	log("loaded best hak jailbreak (◣_◢)")
end
loadup()
