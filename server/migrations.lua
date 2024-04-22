db = dbConnect("sqlite", "saved_music.db")

dbExec(db, [[
    CREATE TABLE IF NOT EXISTS `user_music` (
        `id` INTEGER PRIMARY KEY AUTOINCREMENT,
        `created_at` INT NOT NULL,
        `acc` VARCHAR(64) NOT NULL,
        `name` VARCHAR(128) NOT NULL,
        `url` VARCHAR(512) NOT NULL
    );
]])

--by ymaaster