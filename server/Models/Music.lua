Music = {};
Music.__index = Music;

setmetatable(Music, {__index = Model});

Music.db_table = "user_music";
Music.fillable = {"id", "created_at", "acc", "name", "url"};

-- function Music:play()
--     executeCommandHandler("setradio", client, music.url)
-- end

-- function Music:stop()

-- end
