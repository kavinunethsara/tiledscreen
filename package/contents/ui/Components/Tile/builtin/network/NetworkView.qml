import QtQuick
import QtQuick.Layouts
import './plasmoid/' as Applet
import org.kde.kirigami as Kirigami
import org.kde.plasma.networkmanagement as PlasmaNM
import org.kde.config as KConfig

Item {
    id: root
    anchors.fill: parent
    property string title: "Networks"

    readonly property string kcm: "kcm_networkmanagement"
    readonly property bool kcmAuthorized: KConfig.KAuthorized.authorizeControlModule("kcm_networkmanagement")


    readonly property bool delayModelUpdates: dialogItem.connectionModel !== null
    && dialogItem.connectionModel.delayModelUpdates
    readonly property bool airplaneModeAvailable: availableDevices.modemDeviceAvailable || availableDevices.wirelessDeviceAvailable

    PlasmaNM.Handler {
        id: handler
    }

    PlasmaNM.NetworkStatus {
        id: networkStatus
    }

    PlasmaNM.AvailableDevices {
        id: availableDevices
    }

    Applet.PopupDialog {
        id: dialogItem
        nmHandler: handler
        nmStatus: networkStatus
        Layout.minimumWidth: Kirigami.Units.iconSizes.medium * 10
        Layout.minimumHeight: Kirigami.Units.gridUnit * 20
        anchors.fill: parent
        focus: true
    }

    Timer {
        id: scanTimer
        interval: 10200
        repeat: true
        running: !PlasmaNM.Configuration.airplaneModeEnabled && !root.delayModelUpdates

        onTriggered: handler.requestScan()
    }
}
