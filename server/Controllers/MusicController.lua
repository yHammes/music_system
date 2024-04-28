local function toggleMusicPanel(player)
    local account = getPlayerAccount(player)

    if account then
        local musics = Music:where('acc', getAccountName(account))
        return triggerClientEvent(player, "toggleMusicPanel", resourceRoot, musics)
    end
    
    dxMsg("Você deve logar para abrir este painel!", player, "error", 4)
end
addCommandHandler(Config.Panel.command, toggleMusicPanel)

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        bindKey(source, Config.Panel.bind, "down", toggleMusicPanel);
    end
end)

addEvent("saveMusic", true)
addEventHandler("saveMusic", resourceRoot, function(name, url)
    if (source == resourceRoot and client) then
        local limitCharacters = Config.Panel.nameLimitCharacters;

        if (utf8.len(name) > limitCharacters) then
            return dxMsg("Você atingiu o limite de caracteres! (" .. limitCharacters .. ")", client, "error", 4)
        end

        local music = Music:create({
            acc = getAccountName(getPlayerAccount(client)),
            name = name,
            url = url
        });

        triggerClientEvent(client, "reloadMusicPanel", resourceRoot, Music:where('acc', getAccountName(getPlayerAccount(client))))
            
        dxMsg("Musica salva com sucesso!", client, "info", 6)
    end
end)

addEvent("deleteMusic", true)
addEventHandler("deleteMusic", resourceRoot, function(id)
    if (source == resourceRoot and client) then
        local music = Music:find(id);
        music:delete();
        dxMsg("Musica deletada!", client, "info", 6)

        triggerClientEvent(client, "reloadMusicPanel", resourceRoot, Music:where('acc', getAccountName(getPlayerAccount(client))))
    end
end)

addEvent("playMusic", true)
addEventHandler("playMusic", resourceRoot, function(id)
    if (source == resourceRoot and client) then
        local music = Music:find(id);
        music:play(client)
        dxMsg("Radio alterada com sucesso!", client, "info", 6)
    end
end)

addEvent("playMusicFromURL", true)
addEventHandler("playMusicFromURL", resourceRoot, function(url)
    if (source == resourceRoot and client) then
        local veh = getPedOccupiedVehicle(client);
        local currentRadio = Radio.find(veh);
        if (currentRadio) then
            currentRadio:destroy();
        end
    
        local radio = Radio.new(veh, url);
        radio:play()
        dxMsg("Radio alterada com sucesso!", client, "info", 6)
    end
end)