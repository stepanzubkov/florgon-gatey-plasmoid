import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import "events.js" as Events
import "urlUtils.js" as UrlUtils

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
        if (pagesModel[pagesModel.length-1].value != max) {
            pagesModel.push({value: max});
            pagesModel = pagesModel;
        }
        if (pagesModel[0].value != 1) {
            pagesModel.unshift({value: 1});
            pagesModel = pagesModel;
        }
        console.log(pagesModel);
    }

    onCurrentProjectNameChanged: {
        eventsModel.getEvents();
    }

    Component.onCompleted: {
        Events.includeUrlUtils(UrlUtils);
    }

    Plasmoid.compactRepresentation: cr
    Plasmoid.fullRepresentation: fr
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    ListModel {
        id: eventsModel
        property int totalCount: 0

        function callbackEvents(request) {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === 200) {
                    var body = JSON.parse(request.responseText);
                    if (body.body) {
                        body = JSON.parse(body.body);
                    }

                    var events = body.success.events;
                    eventsModel.clear();
                    for (let event of events) {
                        eventsModel.append(event);
                    }
                    updatePages(body.success.pagination.page, body.success.pagination.max_page);
                    eventsModel.totalCount = body.success.pagination.total;
                }
            } 
        }

        function getEvents(page=1) {
            Events.requestForEvents(
                plasmoid.configuration.accessToken,
                plasmoid.configuration.currentProject,
                callbackEvents,
                page);
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
