function formatMusicURL(url)
    local url = url:gsub("setradio", "")
    local url = url:gsub(" ", "")
    local url = url:gsub("'", "")
    
    return url;
end