function requestForEvents(accessToken, project_id, callback) {
    if (!project_id) {
        return [];
    }
   
    
    var request = new XMLHttpRequest();
    request.open("GET", `https://api-gatey.florgon.space/v1/project.getEvents?project_id=${project_id}&limit=20&offset=0`);
    request.setRequestHeader("Authorization", accessToken);

    request.onreadystatechange = function () { callback(request); }

    request.send();

}
