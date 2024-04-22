local function toggleMusicPanel(player)
    local account = getPlayerAccount(player)

    if account then
        local musics = Music:where('acc', getAccountName(account))
        return triggerClientEvent(player, "toggleMusicPanel", resourceRoot, musics)
    end
    
    dxMsg("Você deve logar para abrir este painel!", player, "error", 4)
end
addCommandHandler(Config.command, toggleMusicPanel)

addEventHandler("onPlayerResourceStart", root, function(resource)
    if (resource == getThisResource()) then
        bindKey(source, Config.bind, "down", toggleMusicPanel);
    end
end)

-- by ymaaster
