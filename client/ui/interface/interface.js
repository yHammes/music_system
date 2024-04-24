function playMusicFromURL() {
    const name = document.getElementById("name").value;
    const url = document.getElementById("url").value;
    mta.triggerEvent("playMusicFromURL", name, url)
}

function saveMusic() {
    const name = document.getElementById("name").value;
    const url = document.getElementById("url").value;
    mta.triggerEvent("saveMusic", name, url)
}

function deleteMusic(id) {
    mta.triggerEvent("deleteMusic", id)
}

function playMusic(id) {
    mta.triggerEvent("playMusic", id)
}