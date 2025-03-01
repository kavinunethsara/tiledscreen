/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import ".."

AbstractToggle {
    id: root

    toggled: brightnessControl.runningNightToggle
    BrightnessSource {
        id: brightnessControl
    }

    function activate(mouse) {
        brightnessControl.nightMode()
    }

    icon: root.toggled ? "redshift-status-on" : "redshift-status-off"
    text: "Nightlight"
}
