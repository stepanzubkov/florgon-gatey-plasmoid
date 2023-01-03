import QtQuick 2.6
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtQuick.Controls 1.4

Item {
    id: root
    property bool disabled: false
    property string text: ""
    signal clicked()
    
    PlasmaComponents.Button {
        width: root.width
        height: root.height
        text: root.text 
        visible: !root.disabled
        onClicked: {
            root.clicked();
        }
    }
   
    PlasmaComponents.Label {
        width: root.width
        height: root.height
        text: root.text
        visible: root.disabled
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
