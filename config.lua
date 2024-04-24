Config = {
    bind = "F5",
    command = "mymusics",
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

    saveMusics = {
        nameLimitCharacters = 60;
    }
}

--Mensagens:
function dxMsg(msg, player, type, radio)
    if (localPlayer) then
        return triggerEvent("dxNotification", resourceRoot, msg, type, radio) --client
    end
    triggerClientEvent(player, "dxNotification", resourceRoot, msg, type, radio) --server
end

--[[
    Sistema para salvar musicas

    Meu contato (Discord): ymaaster, Maaster#0001 ou https://discord.gg/wMkcasT
]]