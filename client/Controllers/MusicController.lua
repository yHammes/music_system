local initBrowser
local panelBrowser

addEventHandler("onClientResourceStart", resourceRoot, function()
    initBrowser = guiCreateBrowser(0, 0, 1, 1, true, true, true)
    panelBrowser = guiGetBrowser(initBrowser)
    guiSetVisible(initBrowser, false)

    addEventHandler("onClientBrowserCreated", panelBrowser, function()
        loadBrowserURL(source, "http://mta/" .. getResourceName(getThisResource()) .. "/client/ui/interface/interface.html")
    end)
end)

local function openPanel(musics)
    guiSetVisible(initBrowser, true)
    guiSetInputMode("no_binds_when_editing");
    executeBrowserJavascript(panelBrowser, [[
        var itemsDiv = document.querySelector(".items");
            
        while (itemsDiv.firstChild) {
            itemsDiv.removeChild(itemsDiv.firstChild);
        }
    ]])

    for _, music in ipairs(musics) do
        executeBrowserJavascript(panelBrowser, [[
            var itemDiv = document.createElement("div");
            itemDiv.classList.add("d-flex", "align-items-center", "justify-content-between", "p-3", "item");
            
            var textDiv = document.createElement("div");
            textDiv.classList.add("d-flex", "texts");

            var textItem = document.createElement("li");
            textItem.textContent = "]] .. music.name .. [[";

            var urlItem = document.createElement("span");
            urlItem.textContent = "(]] .. music.url .. [[)";
            urlItem.classList.add("text-secondary", "mx-2");
            
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

    showCursor(true)
end

local function closePanel()
    guiSetVisible(initBrowser, false)
    showCursor(false)
end

addEvent("toggleMusicPanel", true)
addEventHandler("toggleMusicPanel", resourceRoot, function(musics)
    if guiGetVisible(initBrowser) == false then
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
addEventHandler("playMusicFromURL", resourceRoot, function(url)
    if not isPedInVehicle(localPlayer) then
        return dxMsg("Você precisa de um veiculo!", localPlayer, "error", 4)
    end
    if (url == '') then
        return dxMsg("Informe uma URL válida!", localPlayer, "error", 4)
    end

    return triggerServerEvent("playMusicFromURL", resourceRoot, formatMusicURL(url));
end)
