function requestForEvents(accessToken, project_id, callback, page=1) {
    if (!project_id) {
        return [];
    }
    
    var request = new XMLHttpRequest();
    request.open("GET", `https://api-gatey.florgon.space/v1/project.getEvents?project_id=${project_id}&page=${page}`);
    request.setRequestHeader("Authorization", accessToken);
    request.setRequestHeader("User-Agent", "florgon-gatey-plasmoid (github.com/stepan-zubkov/florgon-gatey-plasmoid)");

    request.onreadystatechange = function () { callback(request); }

    request.send();

}
