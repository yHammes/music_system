Config = {
    Panel = {
        bind = "F5",
        command = "mymusics",

        nameLimitCharacters = 60;
    },
    radio = {
        command = "setradio",
        toggleRadio = "R",
        initialRadio = "https://live.hunter.fm/pop_normal",
        volume = {
            default = 1,
            min = 0,
            max = 2
        },
    },
}

--Infobox:
function dxMsg(msg, player, type, radio)
    if (localPlayer) then
        return triggerEvent("dxNotification", resourceRoot, msg, type, radio) --client
    end
    triggerClientEvent(player, "dxNotification", resourceRoot, msg, type, radio) --server
end

--[[
    Sistema para salvar e tocar musicas na radio dos veiculos

    Autor: yMaaster
    Contato: ymaaster, Maaster#0001 ou https://discord.gg/wMkcasT
    
    Github repository: https://github.com/yHammes/music_system
]]