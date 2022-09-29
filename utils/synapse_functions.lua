-- kind of messy
assert(global, "synapse_functions.lua cannot run without ICETRAY.GLOBAL")

global.functions = {}
local function synapse_functions()
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
    global.functions["islclosure"] = islclosure or ("is_lua_closure does not exist")
    global.functions["is_synapse_function"] = is_synapse_function or ("is_synapse_function does not exist")
    global.functions["getsynasset"] = getsynasset or getcustomasset or ("get_synapse_asset does not exist")
    global.functions["writefile"] = writefile or ("writefile does not exist")
    global.functions["appendfile"] = appendfile or ("appendfile does not exist")
    global.functions["makefolder"] = makefolder or ("makefolder does not exist")
    global.functions["isfile"] = isfile or ("isfile does not exist")
    global.functions["isfolder"] = isfolder or ("isfolder does not exist")
end

return synapse_functions()
