local initBrowser

local function openPanel(musics)
    initBrowser = guiCreateBrowser(0, 0, 1, 1, true, true, true)
    local panelBrowser = guiGetBrowser(initBrowser)

    addEventHandler("onClientBrowserCreated", panelBrowser, function()
        guiSetInputMode("no_binds_when_editing");
        loadBrowserURL(source, "http://mta/" .. getResourceName(getThisResource()) .. "/client/ui/interface.html")
    end)

    addEventHandler("onClientBrowserDocumentReady", panelBrowser, function()
        for _, music in ipairs(musics) do
            executeBrowserJavascript(source, [[
                var itemDiv = document.createElement("div");
                itemDiv.classList.add("d-flex", "align-items-center", "justify-content-between", "p-3", "item");
                
                var textDiv = document.createElement("div");
                textDiv.classList.add("d-flex", "texts");

                var textItem = document.createElement("li");
                textItem.textContent = "]] .. music.name .. [[";

                var urlItem = document.createElement("span");
                urlItem.textContent = "(]] ..  music.url .. [[)";
                urlItem.classList.add("text-muted", "mx-2");
                
                textDiv.appendChild(textItem);
                textDiv.appendChild(urlItem);
                

                var buttonDiv = document.createElement("div");
                buttonDiv.classList.add("d-flex");
                
                var playButton = document.createElement("button");
                playButton.classList.add("btn", "btn-sm", "btn-success", "mx-2");
                playButton.textContent = "Tocar";
                playButton.onclick = function() {
                    playMusic(]] .. music.id .. [[);
                };
                
                var deleteButton = document.createElement("button");
                deleteButton.classList.add("btn", "btn-sm", "btn-danger");
                deleteButton.textContent = "Deletar";
                deleteButton.onclick = function() {
                    deleteMusic(]] .. music.id .. [[);
                };
                
                buttonDiv.appendChild(playButton);
                buttonDiv.appendChild(deleteButton);
                
                itemDiv.appendChild(textDiv);
                itemDiv.appendChild(buttonDiv);
                
                var itemsDiv = document.querySelector(".items");
                
                itemsDiv.appendChild(itemDiv);
                
            ]]);
        end
    end)

    showCursor(true)
end

local function closePanel()
    destroyElement(initBrowser)
    showCursor(false)
end

addEvent("toggleMusicPanel", true)
addEventHandler("toggleMusicPanel", resourceRoot, function(musics)
    if not isElement(initBrowser) then
        playSoundFrontEnd(1)
        openPanel(musics)
    else
        playSoundFrontEnd(2)
        closePanel()
    end
end)

addEvent("reloadMusicPanel", true)
addEventHandler("reloadMusicPanel", resourceRoot, function(musics)
    if isElement(initBrowser) then
        closePanel()
    end
    openPanel(musics)
end)

addEvent("saveMusic", true)
addEventHandler("saveMusic", resourceRoot, function(name, url)
    local limitCharacters = Config.saveMusics.nameLimitCharacters;

    if (string.len(name) > limitCharacters) then
        return dxMsg("Você atingiu o limite de caracteres! (" .. limitCharacters .. ")", localPlayer, "error", 4)
    end

    triggerServerEvent("saveMusic", resourceRoot, name, formatMusicURL(url));
end)

addEvent("deleteMusic", true)
addEventHandler("deleteMusic", resourceRoot, function(id)
    triggerServerEvent("deleteMusic", resourceRoot, id);
end)

addEvent("playMusic", true)
addEventHandler("playMusic", resourceRoot, function(id)
    if isPedInVehicle(localPlayer) then
        return triggerServerEvent("playMusic", resourceRoot, id);
    end
    return dxMsg("Você precisa de um veiculo!", localPlayer, "error", 4);
end)

addEvent("playMusicFromURL", true)
addEventHandler("playMusicFromURL", resourceRoot, function(name, url)
    if not isPedInVehicle(localPlayer) then
        return dxMsg("Você precisa de um veiculo!", localPlayer, "error", 4)
    end
    if (url == '') then
        return dxMsg("Informe uma URL válida!", localPlayer, "error", 4)
    end

    return triggerServerEvent("playMusicFromURL", resourceRoot, name, formatMusicURL(url));
end)

-- by ymaaster
