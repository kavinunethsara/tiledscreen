/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.plasma.private.volume
import ".."

AbstractSlider {
    id: root
    property var sink: PreferredDevice.sink
    value: (sink.volume * 100 / PulseAudio.NormalVolume)
    from: 0
    to: 100

    property bool toggled: sink.volume == 0
    property double oldval: 0
    icon: toggled ? "audio-volume-muted": "audio-volume-high"

    activatable: true
    onActivated: {
        if (!toggled) {
            oldval = sink.volume
            sink.volume = 0
        } else {
            sink.volume = oldval
        }
    }

    onAdjusted: {
        sink.volume = root.value * PulseAudio.NormalVolume / 100
    }
}
