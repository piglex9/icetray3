return function(memoria, _, secunde, callback)
    table.insert(memoria, {
        t = _;
        i = secunde;
        c = callback;
    })
end
