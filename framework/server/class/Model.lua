Model = {}
Model.__index = Model

local instances = {}

function Model.new(data, model)
    setmetatable(data, model);

    return data;
end

function Model:create(data)
    data.created_at = now();

    local model = Model.new(data, self)
    local columns, placeholders = model:getColumnsForCreate(data)
    dbExec(db, "INSERT INTO `" .. model.db_table .. "` (" .. columns .. ") VALUES(" .. placeholders .. ")", unpack(model:getValues(data)))

    model.id = dbPoll(dbQuery(db, "SELECT last_insert_rowid() as lastID"), -1)[1]['lastID'];
    -- instances[model.id] = model;

    return model;
end

function Model:update(data)
    local columns = self:getColumnsForUpdate(data)
    dbExec(db, "UPDATE `" .. self.db_table .. "` SET " .. columns .. " WHERE `id`=?", unpack(self:getValues(data)), self.id)
end

function Model:delete()
    -- instances[self.id] = nil;
    dbExec(db, "DELETE FROM `" .. self.db_table .. "` WHERE `id`=?", self.id)
end

function Model:cleanInstance(id)
    instances[id] = nil;
end

function Model:find(id)
    -- if (instances[tonumber(id)]) then
    --     return instances[tonumber(id)];
    -- end

    local data = dbPoll(dbQuery(db, "SELECT * FROM " .. self.db_table .. " WHERE `id`=?", id), -1)[1]
    return Model.new(data, self);
end

function Model:where(find, value)
    local modelsData = dbPoll(dbQuery(db, "SELECT * FROM " .. self.db_table .. " WHERE `"..find.."`=?", value), -1)
    
    local models = {}
    for _, data in ipairs(modelsData) do
        table.insert(models, Model.new(data, self))
    end
    return models;
end

-- Formata duas strings (columns e placeholders) para usar no query do CREATE
function Model:getColumnsForCreate(data)
    local columns = "";
    local placeholders = "";

    for index, _ in pairs(data) do
        if table.contains(self.fillable, index) then
            columns = columns .. index .. ","
            placeholders = placeholders .. "?" .. ","
        end
    end

    return columns:sub(1, -2), placeholders:sub(1, -2)
end

-- Formata uma string com as colunas para usar no query do UPDATE
function Model:getColumnsForUpdate(data)
    local columns = "";

    for index, _ in pairs(data) do
        if table.contains(self.fillable, index) then
            columns = columns .. index .. "=?,"
        end
    end

    return columns:sub(1, -2)
end

-- Pega os valores com base no fillable
function Model:getValues(data)
    local values = {}
    for _, value in pairs(data) do
        if type(value) == "table" then
            value = toJSON(value);
        end
        table.insert(values, value)
    end
    return values;
end
