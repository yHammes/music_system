addEvent("saveMusic", true)
addEventHandler("saveMusic", resourceRoot, function(name, url)
    if (source == resourceRoot and client) then
        local music = Music:create({
            acc = getAccountName(getPlayerAccount(client)),
            name = name,
            url = url
        });

        triggerClientEvent(client, "reloadMusicPanel", resourceRoot,
            Music:where('acc', getAccountName(getPlayerAccount(client))))
            
        dxMsg("Musica salva com sucesso!", client, "info", 6)
    end
end)

addEvent("deleteMusic", true)
addEventHandler("deleteMusic", resourceRoot, function(id)
    if (source == resourceRoot and client) then
        local music = Music:find(id);
        music:delete();
        dxMsg("Musica deletada!", client, "info", 6)

        triggerClientEvent(client, "reloadMusicPanel", resourceRoot,
            Music:where('acc', getAccountName(getPlayerAccount(client))))
    end
end)

local function playMusic(player, name, url)
    local veh = getPedOccupiedVehicle(player);
    local currentSound = Sound.find(veh);
    if (currentSound) then
        currentSound:stop();
    end

    local sound = Sound.new(veh, url);
    sound:play()

    dxMsg("Radio alterada com sucesso!", player, "info", 6)
end

addEvent("playMusic", true)
addEventHandler("playMusic", resourceRoot, function(id)
    if (source == resourceRoot and client) then
        local music = Music:find(id);

        playMusic(client, music.name, music.url)
    end
end)

addEvent("playMusicFromURL", true)
addEventHandler("playMusicFromURL", resourceRoot, function(name, url)
    if (source == resourceRoot and client) then
        playMusic(client, name, url)
    end
end)

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        local function toggleVolume(player, key)
            local veh = getPedOccupiedVehicle(player)
            if veh then
                local sound = Sound.find(veh);
                if sound then
                    if key == "mouse_wheel_up" then
                        sound:toggleVolume("up")
                    else
                        sound:toggleVolume("down")
                    end
                end
            end
        end
        bindKey(source, "mouse_wheel_up", "down", toggleVolume);
        bindKey(source, "mouse_wheel_down", "down", toggleVolume)
    end
end)

addCommandHandler("setradio", function(player)
    playSoundFrontEnd(player, 4)
    outputChatBox("Pressione F5 para colocar musicas", player, 255, 0, 0, true)
end)

-- by ymaaster
