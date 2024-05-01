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
            max = 5,
        },
        distance = {
            multipler = 25 -- Este valor aumenta com base no volume
        },
    },

    logs = {
        debug = true,
        discord = true,
        discordWebhook = "https://discord.com/api/webhooks/1145092658553958500/Hzp_2B9p0s369GAOr9h34afn0VIHEHCmDh2_c5RJWD0g6sMz6hhzuRLPui5gx-792xy1",
    }
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