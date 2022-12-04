import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: root

    Layout.minimumWidth: compactText.width
    Layout.maximumWidth: compactText.width
  
    PlasmaComponents.Label {
        id: compactText

        text: plasmoid.configuration.accessToken ? i18np("1 event", "%1 events", eventsModel.count) : i18n("- events")


        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                plasmoid.expanded = !plasmoid.expanded;
            }     

        }
    }

    Component.onCompleted: {
        eventsModel.getEvents();
    }
}


  
