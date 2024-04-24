addEvent("saveMusic", true)
addEventHandler("saveMusic", resourceRoot, function(name, url)
    if (source == resourceRoot and client) then
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
addEventHandler("playMusicFromURL", resourceRoot, function(name, url)
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

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        local function toggleVolume(player, key)
            local veh = getPedOccupiedVehicle(player)
            if veh then
                local radio = Radio.find(veh);
                if radio then
                    if key == "mouse_wheel_up" then
                        radio:toggleVolume("up")
                    else
                        radio:toggleVolume("down")
                    end
                end
            end
        end
        bindKey(source, "mouse_wheel_up", "down", toggleVolume);
        bindKey(source, "mouse_wheel_down", "down", toggleVolume)
    end
end)

-- by ymaaster