local radios = {}

addEvent("toggleRadio_Request", true)
addEventHandler("toggleRadio_Request", resourceRoot, function(radio)
    if (radio.state == "stopped") then
        destroyElement(radios[radio.element].sound)
        return destroyElement(radios[radio.element].corona)
    end

    local sound = playSound3D(radio.url, 0, 0, 0, true)
    local corona = createMarker(0, 0, 0, "corona", 0.05, 255, 0, 0, 200)
    setSoundMinDistance(sound, radio.volume)
    setSoundMaxDistance(sound, radio.volume * Config.radio.distance.multipler)
    attachElements(corona, radio.element)
    attachElements(sound, radio.element)
    radios[radio.element] = {
        sound = sound,
        corona = corona
    }
end)

addEvent("destroyRadio_Request", true)
addEventHandler("destroyRadio_Request", resourceRoot, function(element)
    destroyElement(radios[element].sound);
    destroyElement(radios[element].corona);
    radios[element] = nil;
end)

addEvent("toggleVolumeRadio_Request", true)
addEventHandler("toggleVolumeRadio_Request", resourceRoot, function(radio)
    setSoundVolume(radios[radio.element].sound, radio.volume)
    setSoundMaxDistance(radios[radio.element].sound, radio.volume * Config.radio.distance.multipler)
end)

addEventHandler("onClientSoundStream", resourceRoot, function(success, _, streamName)
    local veh = getPedOccupiedVehicle(localPlayer)
    if veh then
        if radios[veh] then
            if (not success) then
                return outputChatBox("#696969Rádio: #FF0000 URL INVALIDA!", 0, 0, 0, true)
            elseif (streamName) then
                outputChatBox("#696969Rádio: #22AA22 " .. streamName, 0, 0, 0, true)
            end
        end
    end
end)

addEventHandler("onClientSoundChangedMeta", resourceRoot, function(streamTitle)
    if (streamTitle) then
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh then
            if radios[veh] then
                outputChatBox("#696969Música: #AA2222 " .. streamTitle, 0, 0, 0, true)
            end
        end
    end
end)
