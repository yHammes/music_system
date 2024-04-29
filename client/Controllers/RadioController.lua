local radios = {}

addEvent("toggleRadio_Request", true)
addEventHandler("toggleRadio_Request", resourceRoot, function(radio)
    if (radio.state == "stopped") then
        return destroyElement(radios[radio.element], false)
    end
    
    local x, y, z = getElementPosition(radio.element)
    local sound = playSound3D(radio.url, x, y, z, true)
    setSoundMinDistance(sound, radio.distance.min)
    setSoundMaxDistance(sound, radio.distance.max)
    attachElements(sound, radio.element)
    radios[radio.element] = sound
end)

addEvent("destroyRadio_Request", true)
addEventHandler("destroyRadio_Request", resourceRoot, function(element)
    destroyElement(radios[element]);
    radios[element] = nil;
end)

addEvent("toggleVolumeRadio_Request", true)
addEventHandler("toggleVolumeRadio_Request", resourceRoot, function(element, volume)
    setSoundVolume(radios[element], volume)
end)

addEventHandler("onClientSoundStream", resourceRoot, function(success, length)
    if streamName then
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh then
            if radios[veh] then
                outputChatBox("#696969Rádio: #22AA22 " .. streamName, 0, 0, 0, true)
            end
        end
    end
end)

addEventHandler("onClientSoundChangedMeta", resourceRoot, function(streamTitle)
    if streamTitle then
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh then
            if radios[veh] then
                outputChatBox("#696969Música: #AA2222 " .. streamTitle, 0, 0, 0, true)
            end
        end
    end
end)
