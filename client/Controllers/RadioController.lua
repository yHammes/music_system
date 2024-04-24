local radios = {}

addEvent("playRadio_Request", true)
addEventHandler("playRadio_Request", resourceRoot, function(element, url)
    if radios[element] then
        return setSoundPaused(radios[element], false)
    end
    
    local x, y, z = getElementPosition(element)
    local radio = playSound3D(url, x, y, z, true)
    setSoundMinDistance(radio, 2)
    setSoundMaxDistance(radio, 40)
    attachElements(radio, element)
    radios[element] = radio
end)

addEvent("pauseRadio_Request", true)
addEventHandler("pauseRadio_Request", resourceRoot, function(element)
    setSoundPaused(radios[element], true)
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
