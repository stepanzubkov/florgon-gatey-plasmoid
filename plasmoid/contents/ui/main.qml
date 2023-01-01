import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import "events.js" as Events

Item {

    property Component fr: FullRepresentation {}
    property Component cr: CompactRepresentation {}
    property string currentProjectName: plasmoid.configuration.currentProjectName
    property var pagesModel: []

    function updatePages(current, max) {
        pagesModel = [
            {value: current-2},
            {value: current-1},
            {value: current, disabled: true},
            {value: current+1},
            {value: current+2},
        ];
        pagesModel = pagesModel.filter((obj) => obj.value > 0 && obj.value <= max);
        if (pagesModel[pagesModel.length-1] != max) {
            pagesModel.push({value: max});
            pagesModel = pagesModel;
        }
        console.log(pagesModel);
    }

    onCurrentProjectNameChanged: {
        eventsModel.getEvents();
    }

    Plasmoid.compactRepresentation: cr
    Plasmoid.fullRepresentation: fr
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    ListModel {
        id: eventsModel

        function callbackEvents(request) {
            if (request.readyState === XMLHttpRequest.DONE) {
                console.log(request.responseText);
                if (request.status === 200) {
                    var body = JSON.parse(request.responseText);
                    var events = body.success.events;
                    eventsModel.clear();
                    for (let event of events) {
                        eventsModel.append(event);
                    }
                    updatePages(body.success.pagination.page, body.success.pagination.max_page);
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
