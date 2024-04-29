Radio = {};
Radio.__index = Radio;

local instances = {}

function Radio.new(element, url)
    local data = {
        element = element,
        volume = 1,
        state = "stopped",
        url = url
    }

    setmetatable(data, Radio);
    instances[element] = data;
    return data;
end

function Radio:toggle()
    self.state = self.state == "playing" and "stopped" or "playing";

    triggerClientEvent("toggleRadio_Request", resourceRoot, self);
end

function Radio:destroy()
    if (self.state == "playing") then
        triggerClientEvent("destroyRadio_Request", resourceRoot, self.element);
    end
    instances[self.element] = nil;
    self = nil;
end

function Radio:toggleVolume(state)
    if (self.state == "playing") then
        if (state == "up" and self.volume < Config.radio.volume.max) then
            self.volume = self.volume + 0.1
        elseif (state == "down" and self.volume > Config.radio.volume.min) then
            self.volume = self.volume - 0.1
        end
        triggerClientEvent("toggleVolumeRadio_Request", resourceRoot, self);    
    end
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