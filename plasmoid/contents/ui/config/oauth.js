function requestAccessTokenUsingSessionToken(sessionToken, callback) {
    var request = new XMLHttpRequest();
    request.open("GET", `https://api.florgon.com/v1/_oauth._allowClient?client_id=10&scope=gatey&redirect_uri=https://florgon.com&state=&response_type=token&session_token=${sessionToken}`);
    request.onreadystatechange = function () { callback(request); }

    request.send();
}
