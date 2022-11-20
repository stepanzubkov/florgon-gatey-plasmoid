import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {

  
  Image {
    id: logo

    //Layout.minimumWidth : plasmoid.formFactor == PlasmaCore.Types.Horizontal ? height : 1
    //Layout.minimumHeight : plasmoid.formFactor == PlasmaCore.Types.Vertical ? width : 1


    source: "images/face-smile.svg"
    sourceSize.width: parent.width
    sourceSize.height: parent.height
  }

    MouseArea {
    id: mouseArea
    anchors.fill: parent

     onClicked: {
        plasmoid.expanded = !plasmoid.expanded;
      }     

    } // end onClicked

} // end Item


  