var UrlUtils;

function requestForProjects(accessToken, callback) {
    var request = new XMLHttpRequest();
    request.open("GET", UrlUtils.getGateyAPIServer() + "/v1/project.list");
    request.setRequestHeader("Authorization", accessToken);

    request.onreadystatechange = function () { callback(request); }

    request.send();
}
function includeUrlUtils(module) {
    UrlUtils = module;
}
