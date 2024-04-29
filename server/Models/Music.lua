Music = {};
Music.__index = Music;

setmetatable(Music, {__index = Model});

Music.db_table = "user_music";
Music.fillable = {"id", "created_at", "acc", "name", "url"};

function Music:play(player)
    local veh = getPedOccupiedVehicle(player);
    local currentRadio = Radio.find(veh);
    if (currentRadio) then
        currentRadio:destroy();
    end

    local radio = Radio.new(veh, self.url);
    radio:toggle()
end

-- function Music:stop()

-- end
