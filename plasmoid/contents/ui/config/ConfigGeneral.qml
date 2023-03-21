import QtQuick 2.2
import QtQuick.Window 2.2
import QtWebEngine 1.10
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrols 2.0
import org.kde.kirigami 2.9 as Kirigami

import "projects.js" as Projects

Item {
    id: root
 
    property alias cfg_accessToken: authWindow.cfg_accessToken
    property alias cfg_currentProjectName: projectsList.cfg_currentProjectName
    property alias cfg_updateInterval: updateTime.value

    function projectsCallback(request) {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                let projects = [];
                let json_projects = JSON.parse(request.responseText).success.projects;
                for (let project of json_projects) {
                    projects.push({value: project.id, text: project.name});
                }
                projectsList.model = projects;

            } else {
                    console.error(`HTTP Request for projects failed. Status code: ${request.status}`);
            }
        }
    }

    onCfg_accessTokenChanged: {
        projectsList.model = Projects.requestForProjects(cfg_accessToken, projectsCallback);
    }

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
            webView.url = "https://florgon.com/oauth/authorize?client_id=10&state=&redirect_uri=http://localhost&scope=gatey&response_type=token"
        }
    }
    Kirigami.FormLayout {
        Button {
            Kirigami.FormData.label: i18n("Florgon access token:")
            text: i18n("Login")
            onClicked: {
                authWindow.login();
            }
        }
        ConfigComboBox {
            id: projectsList

            property string cfg_currentProjectName: ""

            Kirigami.FormData.label: i18n("Choose project:")
            configKey: "currentProject" 
            populated: false
            onPopulate: {
                Projects.requestForProjects(plasmoid.configuration.accessToken, projectsCallback);
            }
            onChoosed: function (item) {
                projectsList.cfg_currentProjectName = item.text;
            }
        }
		SpinBox {
		    id: updateTime

            Kirigami.FormData.label: i18n("Update every:")
		    minimumValue: 10
		    stepSize: 1
		    maximumValue: 720
		    suffix: i18n(" min")
		} 
    }
    
}
