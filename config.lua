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
        distance = {
            min = 2,
            max = 40
        },
    },
}
--Infobox:
function dxMsg(msg, player, type, sound)
    if (localPlayer) then
        return triggerEvent("dxNotification", resourceRoot, msg, type, sound) --client
    end
    triggerClientEvent(player, "dxNotification", resourceRoot, msg, type, sound) --server
end

--[[
    Sistema para salvar e tocar musicas na radio dos veiculos

    Autor: yMaaster
    Contato: ymaaster, Maaster#0001 ou https://discord.gg/wMkcasT
    
    Github repository: https://github.com/yHammes/music_system
]]