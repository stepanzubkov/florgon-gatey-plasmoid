import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.9 as Kirigami

import "oauth.js" as OAuth
import "translated_errors.js" as TranslatedErrors

Item {
    id: root

    property alias cfg_accessToken: getAccessTokenButton.cfg_accessToken

    function callbackRequestAccessToken(request) {
        if (request.readyState === XMLHttpRequest.DONE) {
            var response = JSON.parse(request.responseText);
            if (request.status === 200) {
                getAccessTokenButton.cfg_accessToken = response.success.access_token
                sessionTokenStatus.setPositiveStatus(i18n("You are authorised successfully!"))
            } else {
                console.error(`HTTP Request for projects failed. Status code: ${request.status}`);
                sessionTokenStatus.setNegativeStatus(
                    i18n("Server returned an error: ") + i18n(response.error.message.trim())
                );
            }
        }
    }
    Kirigami.FormLayout {
        RowLayout {
            Kirigami.FormData.label: i18n("Session token: ")
            PlasmaComponents.TextField {
                id: sessionTokenInput
                onWidthChanged: width = 200
                Layout.preferredWidth: 200
            }
            PlasmaComponents.Button {
                id: getAccessTokenButton
                property string cfg_accessToken: ""
                text: i18n("Get access token")
                onClicked: {
                    if (sessionTokenInput.text) {
                        sessionTokenStatus.visible = false;
                        OAuth.requestAccessTokenUsingSessionToken(sessionTokenInput.text, callbackRequestAccessToken);
                    } else {
                        sessionTokenStatus.setNegativeStatus(i18n("Session token shouldn't be empty"))
                    }
                }
            }
        }
        PlasmaComponents.Label {
            id: sessionTokenStatus
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
        }
    }
}
