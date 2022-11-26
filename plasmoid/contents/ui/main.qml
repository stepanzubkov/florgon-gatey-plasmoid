import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import "events.js" as Events

Item {

    property Component fr: FullRepresentation {}
    property Component cr: CompactRepresentation {}
    Plasmoid.compactRepresentation: cr
    Plasmoid.fullRepresentation: fr
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    ListModel {
        id: eventsModel

        function callbackEvents(request) {
            if (request.readyState === XMLHttpRequest.DONE) {
                console.log(request.responseText);
                if (request.status === 200) {
                    var events = JSON.parse(request.responseText).success.events;
                    eventsModel.clear();
                    for (let event of events) {
                        eventsModel.append(event);
                    }
                }
            } 
        }

        function getEvents() {
            Events.requestForEvents(
                plasmoid.configuration.accessToken,
                plasmoid.configuration.currentProject,
                callbackEvents);
        }
    }

    Timer {
        id: eventsUpdateTimer
        interval: 60000 * plasmoid.configuration.updateInterval
        running: Boolean(plasmoid.configuration.accessToken)
        repeat: true
        onTriggered: {
            eventsModel.getEvents();
        }
    }

}
