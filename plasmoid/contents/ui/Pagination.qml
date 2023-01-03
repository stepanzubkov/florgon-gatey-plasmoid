import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4

ListView {
    id: pagesList
    height: 40
    model: pagesModel
    width: 45*pagesModel.length
    spacing: 5 
    orientation: ListView.Horizontal
    anchors.horizontalCenter: parent.horizontalCenter
    delegate: SwitchControlledButton {
        width: 40
        height: 30
        text: modelData.value
        disabled: Boolean(modelData.disabled)
        onClicked: {
            eventsModel.getEvents(modelData.value);
        }
    } 
}
