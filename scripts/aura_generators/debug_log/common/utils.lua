aura_env.ArrayContainsElement = function(aura_env, array, element)
    for _, arrrayElement in ipairs(array) do
        if arrrayElement == element then
            return true
        end
    end
    return false
end

aura_env.FormatTimestamp = function(aura_env, time)
    local hour = date('%H', time)
    local minute = date('%M', time)
    local second = date('%S', time)
    return tostring(hour) .. ":" .. tostring(minute) .. ":" .. tostring(second)
end

aura_env.DumpTablePairs = function(aura_env, table)
    for k, v in pairs(table) do
        print(k,v)
    end
end
