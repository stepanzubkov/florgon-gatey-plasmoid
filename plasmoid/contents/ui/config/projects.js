function requestForProjects(accessToken, callback) {
    if (!accessToken) {
        return [];
    }
    var request = new XMLHttpRequest();
    request.open("GET", "https://api-gatey.florgon.space/v1/project.list");
    request.setRequestHeader("Authorization", accessToken);

    request.onreadystatechange = function () { callback(request); }

    request.send();
}
