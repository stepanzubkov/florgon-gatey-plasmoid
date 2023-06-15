import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.9 as Kirigami

import "oauth.js" as OAuth

Item {
    id: root

    property alias cfg_accessToken: getAccessTokenButton.cfg_accessToken
    property alias cfg_selfhostedServer: selfhostedServerInput.text
    property alias cfg_selfhostedServerEnabled: useSelfhostedServer.checked

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
                console.error("\n\n\n\n\n\n\n\n", `\"${response.error.message.trim()}\"`)
            }
        }
    }

    Kirigami.FormLayout {
        RowLayout {
            Kirigami.FormData.label: i18n("Session token: ")
            TextField {
                id: sessionTokenInput
                width: 200
            }
            Button {
                id: getAccessTokenButton
                property string cfg_accessToken: ""
                text: i18n("Get access token")
                onClicked: {
                    if (sessionTokenInput.text) {
                        sessionTokenStatus.hide()
                        OAuth.requestAccessTokenUsingSessionToken(sessionTokenInput.text, callbackRequestAccessToken);
                    } else {
                        sessionTokenStatus.setNegativeStatus(i18n("Session token shouldn't be empty"))
                    }
                }
            }
        }
        StatusLabel {
            id: sessionTokenStatus
        }
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
        }
        RadioButton {
            id: useDefaultServer
            text: i18n("Use default Florgon Gatey server")
            checked: !plasmoid.configuration.selfhostedServerEnabled
        }
        RadioButton {
            id: useSelfhostedServer
            text: i18n("Use self-hosted Gatey server")
            checked: plasmoid.configuration.selfhostedServerEnabled
        }
        TextField {
            id: selfhostedServerInput
            Kirigami.FormData.label: i18n("Self-hosted server: ")
            text: plasmoid.configuration.selfhostedServer
            enabled: useSelfhostedServer.checked
        }
    }
}
