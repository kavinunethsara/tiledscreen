/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import ".."
import org.kde.ksysguard.sensors as Sensors

AbstractToggle {
    id: root

    property variant inhibitor: undefined
    toggled: inhibitor && (inhibitor.isManuallyInhibited || inhibitor.inhibitions.length > 0)

    function activate(mouse) {
        if (!inhibitor) return
            if (!toggled) {
                const reason = i18n("The battery applet has enabled suppressing sleep and screen locking");
                inhibitor.inhibit(reason)
            } else {
                inhibitor.uninhibit()
            }
    }

    Sensors.SensorDataModel {
        id: plasmaVersionModel
        sensors: ["os/plasma/plasmaVersion"]
        enabled: true

        onDataChanged: {
            const value = data(index(0, 0), Sensors.SensorDataModel.Value);
            let elem = undefined
            if (value !== undefined && value !== null) {
                if (value.indexOf("6.3") >= 0) {
                    elem = Qt.createComponent("InhibitionAPI.qml")
                } else {
                    elem = Qt.createComponent("PowerManagementAPI.qml")
                }
            }
            if (elem.status == Component.Ready) {
                var inhibitor = elem.createObject(root, {} );
                root.inhibitor = inhibitor
            }
        }
    }

    icon: "system-lock-screen-symbolic"
    text: "Caffeine"
}
