import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4

ListView {
    id: pagesList
    height: 40
    model: pagesModel
    width: 40*pagesModel.length
    spacing: 40 
    orientation: ListView.Horizontal
    anchors.horizontalCenter: parent.horizontalCenter
    delegate: Item {
        PlasmaComponents.Button {
            width: 40
            height: 30
            text: modelData.value
            visible: !modelData.disabled
            onClicked: {
                eventsModel.getEvents(modelData.value)
            }
        }
        
        PlasmaComponents.Label {
            width: 40
            height: 30
            text: modelData.value
            visible: Boolean(modelData.disabled)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
