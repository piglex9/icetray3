return function(tools)
    local api = {
            getreg = debug.getregistry or getreg;
            getupvalues = debug.getupvalues;
            getconstants = debug.getconstants;
            setconstant = debug.setconstant;
            getupvalue = debug.getupvalue;
            setupvalue = debug.setupvalue;
            getrawmetatable = getrawmetatable;
            setreadonly = setreadonly or make_writeable;
            newcclosure = newcclosure;
            setclipboard = setclipboard;
            islclosure = islclosure;
            is_synapse_function = is_synapse_function or checkclosure;
            firetouchinterest = firetouchinterest;
            fireclickdetector = fireclickdetector;
            getconnections = getconnections;
            getsynasset = getsynasset or getcustomasset;
            writefile = writefile;
            readfile = readfile;
            appendfile = appendfile;
            makefolder = makefolder;
            isfile = isfile;
            isfolder = isfolder;
    };
    local nu_exista = "nu exista"
    for i,v in next, api do
        if type(v) ~= "function" then --@schimba daca e altceva, dar n ar trebui
            v = ("%s %s"):format(i, nu_exista)
            error(v)
        end
        tools.functions[i] = v
    end
end
