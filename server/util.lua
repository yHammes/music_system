function log(msg)
    local msg = msg:gsub("#%x%x%x%x%x%x", "");
    if (Config.logs.debug) then
        outputDebugString(msg, 4, 255, 255, 255)
    end
    if (Config.logs.discord) then
        fetchRemote(Config.logs.discordWebhook, {
            formFields = {
                content = msg
            }
        }, function()
        end)
    end
end