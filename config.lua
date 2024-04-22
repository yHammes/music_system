Config = {
    bind = "F5",
    command = "mymusics",
    sound = {
        volume = {
            default = 1,
            min = 0.1,
            max = 2
        },
    },

    saveMusics = {
        nameLimitCharacters = 60;
    }
}

--Mensagens:
function dxMsg(msg, player, type, sound)
    if (localPlayer) then
        return triggerEvent("dxNotification", resourceRoot, msg, type, sound) --client
    end
    triggerClientEvent(player, "dxNotification", resourceRoot, msg, type, sound) --server
end

--[[
    Sistema para salvar musicas

    Meu contato (Discord): ymaaster, Maaster#0001 ou https://discord.gg/wMkcasT
]]