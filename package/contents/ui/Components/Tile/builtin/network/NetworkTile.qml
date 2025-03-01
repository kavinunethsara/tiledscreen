/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import ".."
import org.kde.plasma.networkmanagement as PlasmaNM
import org.kde.plasma.components as PlasmaComponents

AbstractToggle {
    id: root

    readonly property bool administrativelyEnabled:
    !PlasmaNM.Configuration.airplaneModeEnabled
    && availableDevices.wirelessDeviceAvailable
    && enabledConnections.wirelessHwEnabled

    opacity: administrativelyEnabled ? 1 : 0.5
    toggled: administrativelyEnabled && enabledConnections.wirelessEnabled
    text: "Network"
    icon: toggled ? "network-wireless" : "network-wireless-offline"

    function activate(mouse) {
        mouse.accepted = false
        if (mouse.button == Qt.LeftButton)
            return root.container.expandView()
            handler.enableWireless(!toggled)
    }

    PlasmaNM.Handler {
        id: handler
    }

    PlasmaNM.EnabledConnections {
        id: enabledConnections

        // When user interactively toggles a checkbox, a binding may be
        // preserved, but the state gets out of sync until next relevant
        // notify signal is dispatched. So, we refresh the bindings here.

        onWirelessEnabledChanged: root.toggled = Qt.binding(() =>
        root.administrativelyEnabled && enabledConnections.wirelessEnabled
        );
    }

    PlasmaNM.AvailableDevices {
        id: availableDevices
    }

    PlasmaComponents.BusyIndicator {
        parent: root
        anchors {
            fill: root
            margins: Kirigami.Units.mediumSpacing
        }
        z: 1

        // Scanning may be too fast to notice. Prolong the animation up to at least `humanMoment`.
        running: handler.scanning || timer.running
        Timer {
            id: timer
            interval: Kirigami.Units.humanMoment
        }
        Connections {
            target: handler
            function onScanningChanged() {
                if (handler.scanning) {
                    timer.restart();
                }
            }
        }
    }
}
