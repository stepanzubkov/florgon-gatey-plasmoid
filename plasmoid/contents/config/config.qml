import org.kde.plasma.configuration 2.0

ConfigModel { 
    ConfigCategory {
        name: i18n("General")
        source: "config/ConfigGeneral.qml"
        icon: "plasma"
    }
    ConfigCategory {
        name: i18n("For Developers")
        source: "config/ConfigForDevelopers.qml"
        icon: "applications-development"
    }
}
