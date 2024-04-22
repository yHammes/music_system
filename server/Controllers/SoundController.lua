local function startAllSounds(player) 
    local sounds = Sound.getAll();
    for _, sound in pairs(sounds) do
        if sound.state == "playing" then
            triggerClientEvent(player, "playSound_Request", resourceRoot, sound.element, sound.url);
        end
    end
end

local function setRadioBind(player)
    bindKey(player, 'R', "down", function(player)
        local veh = getPedOccupiedVehicle(player)
        if veh then
            local sound = Sound.find(veh)
            if not sound then
                sound = Sound.new(veh, "https://live.hunter.fm/pop_normal")
            end
            if sound.state == "paused" then
                sound:play();
                return dxMsg("Radio ligada!", player, "info", 1);
            end
            sound:pause();
            dxMsg("Radio desligada!", player, "info", 2);
        end
    end);
end

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        startAllSounds(source) 
        setRadioBind(source)
    end
end)

addEventHandler("onVehicleExplode", root, function ()
    local sound = Sound.find(source)
    if sound then
        sound:stop();
    end
end)

addEventHandler("onElementDestroy", root, function ()
    local sound = Sound.find(source)
    if sound then
        sound:stop();
    end
end)