local x, y = guiGetScreenSize()
local volume

addEvent("dxVolume", true)
addEventHandler("dxVolume", resourceRoot, function(volume_updated)
    volume = math.max(0, math.min(math.round(volume_updated / Config.radio.volume.max * 100, 1), 100));

    if isTimer(timer) then
        return resetTimer(timer)
    end

    addEventHandler("onClientRender", root, renderVolume)

    timer = setTimer(function()
        removeEventHandler("onClientRender", root, renderVolume)
    end, 3000, 1)
end)

function renderVolume()
    dxDrawText(volume, x * 0.85, y * 0.70, x * 0.85, y * 0.70, tocolor(255, 255, 255, 255), 4, "default-bold", "right", "bottom", false, false, true, true)
end
