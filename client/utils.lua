function formatMusicURL(url)
    local url = url:gsub("setradio", "")
    local url = url:gsub(" ", "")
    local url = url:gsub("'", "")
    
    return url;
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then
        return math[method](number * factor) / factor
    else
        return tonumber(("%." .. decimals .. "f"):format(number))
    end
end