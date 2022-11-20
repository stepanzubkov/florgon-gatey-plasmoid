import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {

  
    PlasmaComponents.Label {
        id: compactText
        text: "3 logs"


        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                plasmoid.expanded = !plasmoid.expanded;
            }     

        }
    }
}


  