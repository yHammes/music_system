Radio = {};
Radio.__index = Radio;

local instances = {}

function Radio.new(element, url)
    local data = {
        element = element,
        volume = 1,
        state = "paused",
        url = url
    }

    setmetatable(data, Radio);
    instances[element] = data;
    return data;
end

function Radio:play()
    triggerClientEvent("playRadio_Request", resourceRoot, self.element, self.url);
    self.state = "playing";
end

function Radio:pause()
    triggerClientEvent("pauseRadio_Request", resourceRoot, self.element);
    self.state = "paused";
end

function Radio:destroy()
    triggerClientEvent("destroyRadio_Request", resourceRoot, self.element);
    instances[self.element] = nil;
    self = nil;
end

function Radio:toggleVolume(state)
    if (state == "up" and self.volume < Config.radio.volume.max) then
        self.volume = self.volume + 0.1
    elseif (state == "down" and self.volume > Config.radio.volume.min) then
        self.volume = self.volume - 0.1
    end
    triggerClientEvent("toggleVolumeRadio_Request", resourceRoot, self.element, self.volume);    
end

function Radio.find(element)
    if instances[element] then
        return instances[element];
    end
    return false;
end

function Radio.getAll()
    return instances;
end