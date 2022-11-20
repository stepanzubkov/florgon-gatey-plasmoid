import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Controls 1.4

Item {

    width: 200
    height: 400
    ColumnLayout {
        anchors.fill: parent
        Label {
            width: parent.width
            text: "Hello Mate"
            font.pixelSize: 32
            Layout.alignment: Qt.AlignHCenter
        } 
    }
}




