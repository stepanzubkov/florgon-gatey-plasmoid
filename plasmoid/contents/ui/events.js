var UrlUtils;

function requestForEvents(accessToken, project_id, callback, page=1) {
    var request = new XMLHttpRequest();
    var target = UrlUtils.getGateyAPIServer() + "/v1/project.getEvents";
    var query_params = _constructQueryParams({
        project_id: project_id,
        page: page,
        signed_only: plasmoid.configuration.onlySignedEvents,
        exceptions_only: plasmoid.configuration.onlyExceptionsEvents,
    });

    request.open("GET", target + query_params);
    request.setRequestHeader("Authorization", accessToken);
    request.setRequestHeader("User-Agent", "florgon-gatey-plasmoid (github.com/stepan-zubkov/florgon-gatey-plasmoid)");

    request.onreadystatechange = function () { callback(request); }

    request.send();

}


function _constructQueryParams(params) {
  return "?" + Object
    .keys(params)
    .map(function(key){
      return key+"="+encodeURIComponent(params[key])
    })
    .join("&")
}

function includeUrlUtils(module)  {
    UrlUtils = module;
}
