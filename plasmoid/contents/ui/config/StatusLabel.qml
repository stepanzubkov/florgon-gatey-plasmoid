import QtQuick 2.6
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaComponents.Label {
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
