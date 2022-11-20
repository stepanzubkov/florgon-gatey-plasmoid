import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import org.kde.kquickcontrols 2.0


Item {

	property alias cfg_popupMessage: popupMessage.text
	property alias cfg_messageColor: textColor.currentColor

	GridLayout {
		columns: 2
		width: 500
		Layout.fillWidth: true


		Label {
			width: 200
			text: "Message Text:"

		}

		TextField {
			id: popupMessage
			Layout.fillWidth: true
		}

		Label {
			width: 200
			text: "Pick a color"
		}

		ColorButton {
			id: textColor
			

		}



	}
}