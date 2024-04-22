Sound = {};
Sound.__index = Sound;

local instances = {}

function Sound.new(element, url)
    local data = {
        element = element,
        volume = 1,
        state = "paused",
        url = url
    }

    setmetatable(data, Sound);
    instances[element] = data;
    return data;
end

function Sound:play()
    triggerClientEvent("playSound_Request", resourceRoot, self.element, self.url);
    self.state = "playing";
end

function Sound:pause()
    triggerClientEvent("pauseSound_Request", resourceRoot, self.element);
    self.state = "paused";
end

function Sound:stop()
    triggerClientEvent("stopSound_Request", resourceRoot, self.element);
    instances[self.element] = nil;
    self = nil;
end

function Sound:toggleVolume(state)
    if (state == "up" and self.volume < Config.sound.volume.max) then
        self.volume = self.volume + 0.1
    elseif (state == "down" and self.volume > Config.sound.volume.min) then
        self.volume = self.volume - 0.1
    end
    triggerClientEvent("toggleVolumeSound_Request", resourceRoot, self.element, self.volume);
    print(self.volume)
    
end

function Sound.find(element)
    if instances[element] then
        return instances[element];
    end
    return false;
end

function Sound.getAll()
    return instances;
end