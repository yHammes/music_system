local function startAllRadios(player)
    local radios = Radio.getAll();
    for _, radio in pairs(radios) do
        if radio.state == "playing" then
            triggerClientEvent(player, "toggleRadio_Request", resourceRoot, radio);
        end
    end
end

local function setRadioBind(player)
    bindKey(player, Config.radio.toggleRadio, "down", function(player)
        local veh = getPedOccupiedVehicle(player)
        if veh then
            local radio = Radio.find(veh)
            if not radio then
                radio = Radio.new(veh, Config.radio.initialRadio)
            end
            radio:toggle();
            if radio.state == "stopped" then
                return dxMsg("Radio desligada!", player, "info", 2);
            end
            dxMsg("Radio ligada!", player, "info", 1);
        end
    end);
end

local function setVolumeBinds(player)
    local function toggleVolume(player, key)
        local veh = getPedOccupiedVehicle(player)
        if veh then
            local radio = Radio.find(veh);
            if radio then
                if key == "mouse_wheel_up" then
                    radio:toggleVolume(player, "up")
                else
                    radio:toggleVolume(player, "down")
                end
            end
        end
    end
    bindKey(source, "mouse_wheel_up", "down", toggleVolume);
    bindKey(source, "mouse_wheel_down", "down", toggleVolume)
end

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        startAllRadios(source)
        setRadioBind(source)
        setVolumeBinds(source)
    end
end)

addEventHandler("onVehicleExplode", root, function()
    local radio = Radio.find(source)
    if radio then
        radio:destroy();
    end
end)

addEventHandler("onElementDestroy", root, function()
    local radio = Radio.find(source)
    if radio then
        radio:destroy();
    end
end)

addCommandHandler(Config.radio.command, function(player, _, url)
    if (url) then
        local veh = getPedOccupiedVehicle(player);
        if (veh) then
            local currentRadio = Radio.find(veh);
            if (currentRadio) then
                currentRadio:destroy();
            end
    
            local radio = Radio.new(veh, url);
            radio:toggle()
            log(getPlayerName(player) .. " Com o comando /"..Config.radio.command.." esta tocando: " .. url)
            dxMsg("Radio alterada com sucesso!", player, "info", 6)
        end
    end
end)