local sounds = {}

addEvent("playSound_Request", true)
addEventHandler("playSound_Request", resourceRoot, function(element, url)
    if sounds[element] then
        return setSoundPaused(sounds[element], false)
    end
    
    local x, y, z = getElementPosition(element)
    local sound = playSound3D(url, x, y, z, true)
    setSoundMinDistance(sound, 2)
    setSoundMaxDistance(sound, 40)
    attachElements(sound, element)
    sounds[element] = sound
end)

addEvent("pauseSound_Request", true)
addEventHandler("pauseSound_Request", resourceRoot, function(element)
    setSoundPaused(sounds[element], true)
end)

addEvent("stopSound_Request", true)
addEventHandler("stopSound_Request", resourceRoot, function(element)
    destroyElement(sounds[element]);
    sounds[element] = nil;
end)

addEvent("toggleVolumeSound_Request", true)
addEventHandler("toggleVolumeSound_Request", resourceRoot, function(element, volume)
    setSoundVolume(sounds[element], volume)
end)

addEventHandler("onClientSoundStream", resourceRoot, function(success, length)
    if streamName then
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh then
            if sounds[veh] then
                outputChatBox("#696969Rádio: #22AA22 " .. streamName, 0, 0, 0, true)
            end
        end
    end
end)

addEventHandler("onClientSoundChangedMeta", resourceRoot, function(streamTitle)
    if streamTitle then
        local veh = getPedOccupiedVehicle(localPlayer)
        if veh then
            if sounds[veh] then
                outputChatBox("#696969Música: #AA2222 " .. streamTitle, 0, 0, 0, true)
            end
        end
    end
end)
