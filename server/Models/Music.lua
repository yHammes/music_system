Music = {};
Music.__index = Music;

setmetatable(Music, {__index = Model});

Music.db_table = "user_music";
Music.fillable = {"id", "created_at", "acc", "name", "url"};

function Music:play(player)
    local veh = getPedOccupiedVehicle(player);
    local currentSound = Sound.find(veh);
    if (currentSound) then
        currentSound:destroy();
    end

    local sound = Sound.new(veh, self.url);
    sound:play()
end

-- function Music:stop()

-- end
