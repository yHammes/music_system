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
        discord = false,
        discordWebhook = "",
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
    Sistema para salvar e tocar musicas na radio dos veiculos. Para duvidas ou suporte você pode me chamar no Discord: ymaaster

    * Autor: yMaaster

    * Contato:
        - Discord: ymaaster
        - Github: https://github.com/yHammes

        - Encomendas de resources: https://discord.gg/uVPrRRBnvh
        - Meu servidor (GFB): https://discord.gg/wMkcasT
]]
