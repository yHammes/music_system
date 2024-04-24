local function startAllRadios(player) 
    local radios = Radio.getAll();
    for _, radio in pairs(radios) do
        if radio.state == "playing" then
            triggerClientEvent(player, "playRadio_Request", resourceRoot, radio.element, radio.url);
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
            if radio.state == "paused" then
                radio:play();
                return dxMsg("Radio ligada!", player, "info", 1);
            end
            radio:pause();
            dxMsg("Radio desligada!", player, "info", 2);
        end
    end);
end

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        startAllRadios(source) 
        setRadioBind(source)
    end
end)

addEventHandler("onVehicleExplode", root, function ()
    local radio = Radio.find(source)
    if radio then
        radio:destroy();
    end
end)

addEventHandler("onElementDestroy", root, function ()
    local radio = Radio.find(source)
    if radio then
        radio:destroy();
    end
end)

    addCommandHandler(Config.radio.command, function(player, _, url)
        if (url) then
            local veh = getPedOccupiedVehicle(player);
            local currentRadio = Radio.find(veh);
            if (currentRadio) then
                currentRadio:destroy();
            end
        
            local radio = Radio.new(veh, url);
            radio:play()
            dxMsg("Radio alterada com sucesso!", player, "info", 6)
        end
    end)

--by ymaaster