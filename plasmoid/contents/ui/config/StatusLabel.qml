import QtQuick 2.6
import QtQuick.Controls 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Text {
    id: root
    visible: false
    text: ""
    color: PlasmaCore.ColorScope.negativeTextColor
    function setPositiveStatus(status) {
        color = PlasmaCore.ColorScope.positiveTextColor;
        text = status;
        visible = true;
    }
    function setNegativeStatus(status) {
        color = PlasmaCore.ColorScope.negativeTextColor;
        text = status;
        visible = true;
    }
    function setNormalStatus(status) {
        color = PlasmaCore.ColorScope.textColor;
        text = status;
        visible = true;
    }
    function hide() {
        visible = false;
    }
}
