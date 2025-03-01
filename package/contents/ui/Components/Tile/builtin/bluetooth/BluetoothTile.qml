/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import ".."
import org.kde.bluezqt as BluezQt

AbstractToggle {
    id: root
    readonly property BluezQt.Manager manager: BluezQt.Manager
    property bool toggled: manager.operational && !manager.bluetoothBlocked
    function activate(mouse) {
        manager.bluetoothBlocked = !manager.bluetoothBlocked
    }

    icon: root.toggled ? "bluetooth-symbolic" : "bluetooth-disabled-symbolic"
    text: "Bluetooth"
}
