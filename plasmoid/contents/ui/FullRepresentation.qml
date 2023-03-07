import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Controls 1.4
import org.kde.kirigami 2.9 as Kirigami

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

   ListView {
        id: eventsList
        anchors {
            fill: parent
            margins: 10
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

        header: Item {
            width: parent.width
            height: paginationHeader.height + eventsFilters.height + 50 + openInBrowserButton.height
            visible: Boolean(plasmoid.configuration.currentProject)

            PlasmaComponents.Button {
                id: openInBrowserButton
                text: i18n("Open in browser")
                width: 150
                height: 30
                anchors.left: parent.left
                anchors.leftMargin: (parent.width - width)/2
                onClicked: {
                    Qt.openUrlExternally(`https://gatey.florgon.com/dashboard/project/${plasmoid.configuration.currentProject}/analytics`)
                }
            }

            Pagination {
                id: paginationHeader
                anchors.top: openInBrowserButton.bottom
                anchors.topMargin: 20
            }
            
            Kirigami.FormLayout {
                id: eventsFilters

                anchors.top: paginationHeader.bottom
                Item {
                    Kirigami.FormData.isSection: true
                    Kirigami.FormData.label: i18n("Events filters:")
                }

                PlasmaComponents.CheckBox {
                    id: onlySignedFlag

                    Kirigami.FormData.label: i18n("Only signed:")
                    checked: plasmoid.configuration.onlySignedEvents
                    onClicked: {
                        plasmoid.configuration.onlySignedEvents = checked;
                        eventsModel.getEvents();
                    }
                }

                PlasmaComponents.CheckBox {
                    id: onlyExceptionsFlag

                    checked: plasmoid.configuration.onlyExceptionsEvents
                    Kirigami.FormData.label: i18n("Only exceptions:") 
                    onClicked: {
                        plasmoid.configuration.onlyExceptionsEvents = checked;
                        eventsModel.getEvents();
                    }
                }

            }

            Rectangle {
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 15
                }
                color: PlasmaCore.ColorScope.disabledTextColor
                width: parent.width
                height: 1
            }
        }

        footer: Item {
            height: paginationFooter.height + 15
            width: parent.width
            visible: Boolean(plasmoid.configuration.currentProject)

            Pagination {
                id: paginationFooter
                anchors.bottom: parent.bottom
            }
        } 
    } 
}




