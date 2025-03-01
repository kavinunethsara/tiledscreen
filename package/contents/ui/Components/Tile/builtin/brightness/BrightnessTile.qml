/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import ".."

AbstractSlider {
    id: root

    BrightnessSource {
        id: brightness
    }

    from: 0
    value: brightness.valueSlider
    to: brightness.maxSlider

    icon: "brightness-high-symbolic"

    onAdjusted: {
        brightness.realValueSlider = value / 100
    }
}
