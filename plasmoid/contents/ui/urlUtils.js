function getGateyAPIServer() {
    var gateyAPIServer = plasmoid.configuration.selfhostedServerEnabled ?
                         plasmoid.configuration.selfhostedServer : plasmoid.configuration.defaultServer;
    if (gateyAPIServer[gateyAPIServer.length - 1] == "/")
        gateyAPIServer = gateyAPIServer.substring(0, gateyAPIServer.length - 1);
    return gateyAPIServer;
}
