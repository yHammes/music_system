function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function now()
    local time = getRealTime();

    local year = 1900 + time.year;
    local month = string.format("%02d", time.month);
    local monthday = string.format("%02d", time.monthday);
    local hour = string.format("%02d", time.hour);
    local minute = string.format("%02d", time.minute);
    local second = string.format("%02d", time.second);

    return year .. "-" .. month .. "-" .. monthday .. " " .. hour .. ":" .. minute .. ":" .. second;
end


--by ymaaster