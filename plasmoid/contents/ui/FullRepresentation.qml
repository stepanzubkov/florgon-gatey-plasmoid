import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Controls 1.4

import "events.js" as Events

PlasmaExtras.Representation {
    id: root

    readonly property var appletInterface: Plasmoid.self

    Layout.minimumWidth: PlasmaCore.Units.gridUnit * 20
    Layout.minimumHeight: PlasmaCore.Units.gridUnit * 30
    Layout.maximumWidth: PlasmaCore.Units.gridUnit * 80
    Layout.maximumHeight: PlasmaCore.Units.gridUnit * 40
    collapseMarginsHint: true

    function callbackEvents(request) {
        if (request.readyState === XMLHttpRequest.DONE) {
            console.log(request.responseText);
            if (request.status === 200) {
                var events = JSON.parse(request.responseText).success.events;
                eventsList.model = events;
            }
        } 
    }

    function getEvents() {
        Events.requestForEvents(
            plasmoid.configuration.accessToken,
            plasmoid.configuration.currentProject,
            callbackEvents);
    }

    ListView {
        id: eventsList

        anchors.fill: parent
        spacing: 5
        model: eventsModel
        delegate: Item {
            id: eventDelegate

            height: 150
            width: eventsList.width
            clip: true

            function getColorForLevel(level) {
                switch (level) {
                    case "ERROR": return "#ff0000";
                    case "INFO": return "#32cd32";
                    case "DEBUG": return "#ffa500";
                    default: return PlasmaCore.ColorScope.textColor;

                }
            }

            Rectangle {
                anchors {
                    bottom: parent.bottom
                }
                color: PlasmaCore.ColorScope.textColor
                width: parent.width
                height: 1
            }
            PlasmaComponents.Label {
                id: eventMessageText
                wrapMode: Text.WordWrap
                width: parent.width - createdAtLabel.width - 20
                font.pointSize: 12
                text: model.message
            }

            PlasmaComponents.Label {
                text: model.level
                anchors.top: eventMessageText.bottom
                anchors.topMargin: 5
                font.bold: true
                color: getColorForLevel(model.level);
            }

            PlasmaComponents.Label {
                id: createdAtLabel
                anchors.right: parent.right
                text: new Date(model.created_at * 1000).toLocaleDateString(Qt.locale(), "dd MMMM, yyyy");
                font.italic: true
            }
        }
    }

    
    
}




