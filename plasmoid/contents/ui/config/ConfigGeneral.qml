import QtQuick 2.2
import QtQuick.Window 2.2
import QtWebEngine 1.10
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import org.kde.kquickcontrols 2.0

Item {
    id: root

    property alias cfg_accessToken: authWindow.cfg_accessToken

    Window {
        id: authWindow

        visible: false
        height: 800
        width: 1100
        property string cfg_accessToken: ""

        WebEngineView {
            id: webView
            anchors.fill: parent
            profile: WebEngineProfile {
                offTheRecord: true
            }
            onUrlChanged: {
                if (webView.url.toString().startsWith("http://localhost")) {
                    let tokenData = webView.url.toString().replace("http://localhost/#token=", "");
                    let idTokenStart = tokenData.indexOf("&");
                    let token = tokenData.substring(0, idTokenStart);
                    authWindow.cfg_accessToken = token;
                    authWindow.visible = false;
                    console.log("New token recieved: " + token); 
                }
            }
        }

        function login() {
            if (!authWindow.visible) authWindow.show();
            webView.url = "https://florgon.space/oauth/authorize?client_id=10&state=&redirect_uri=http://localhost&scope=gatey&response_type=token"
        }
    }
    RowLayout {
        Label {
            id: token
            text: "Florgon access token"
        }
        Button {
            text: "Login"
            onClicked: {
                authWindow.login();
            }
        }
    }
}
