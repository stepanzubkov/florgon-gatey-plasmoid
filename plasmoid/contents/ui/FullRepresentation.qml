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

    header: PlasmaExtras.PlasmoidHeading {
        PlasmaComponents.Label {
            text: plasmoid.configuration.currentProjectName || i18n("Choose project in settings")
            anchors.fill: parent
            font.pointSize: 12
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

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

        anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
            bottomMargin: 10
            topMargin: 10
        }
        spacing: 15
        model: eventsModel
        delegate: Item {
            id: eventDelegate

            height: eventMessageText.height + eventIdText.height + eventLevelText.height + eventSubtypeText.height + 30
            width: eventsList.width
            clip: true

            function getColorForLevel(level) {
                switch (level.toLowerCase()) {
                    case "error" || "fatal" || "critical": return PlasmaCore.ColorScope.negativeTextColor;
                    case "info" || "log": return PlasmaCore.ColorScope.positiveTextColor;
                    case "debug": return "#ffa500";
                    default: return PlasmaCore.ColorScope.textColor;

                }
            }

            Rectangle {
                anchors {
                    bottom: parent.bottom
                }
                color: PlasmaCore.ColorScope.disabledTextColor
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
                id: eventIdText

                text: `ID ${model.id}`
                anchors.top: eventMessageText.bottom
                anchors.topMargin: 4
                font.pointSize: 10
                color: PlasmaCore.ColorScope.disabledTextColor
            }

            PlasmaComponents.Label {
                id: eventLevelText

                text: model.level
                anchors.top: eventIdText.bottom
                anchors.topMargin: 2
                font.bold: true
                color: getColorForLevel(model.level);
            }
            PlasmaComponents.Label {
                id: eventSubtypeText
                text: model.is_exception ? i18n("Exception") : i18n("Message")
                anchors.top: eventLevelText.bottom
                color: getColorForLevel(model.level);
                anchors.topMargin: 2
            }

            PlasmaComponents.Label {
                id: createdAtLabel
                anchors.right: parent.right
                text: new Date(model.created_at * 1000).toLocaleString(Qt.locale(), Locale.ShortFormat);

                font.italic: true
            }
        }
    }

    
    
}




