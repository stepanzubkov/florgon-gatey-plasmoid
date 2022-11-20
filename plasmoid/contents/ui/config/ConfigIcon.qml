import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
	
	property alias cfg_iconIndex:	iconBox.currentIndex

	GridLayout {
		columns: 2


		Label {
			text: "Select a popout icon:"
		}

		ComboBox {
			id: iconBox
			model: ListModel {
				id: iconItems
				ListElement {text: "Plasma logo"; image: "images/plasma.svg"}
				ListElement {text: "Cool"; image: "images/face-cool.svg"}
				ListElement {text: "Devil"; image: "images/face-devilish.svg"}
				ListElement {text: "Pirate"; image: "images/face-pirate.svg"}
				ListElement {text: "Smile"; image: "images/face-smile.svg"}
				ListElement {text: "Surprise"; image: "images/face-surprise.svg"}
				ListElement {text: "KDE logo"; image: "imageskde.svg"}
				

			}
		}
	}

}