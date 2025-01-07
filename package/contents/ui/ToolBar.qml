/*
 * SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.sessions as Sessions
import './Components'

Item {
    id: root
    signal toggle
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    height: shutdownIcon.height + Kirigami.Units.largeSpacing

    Sessions.SessionManagement {
        id: sm
    }

    ToolbarButton {
        source: "desktop-symbolic"
        hint: "Desktop"
        anchors.left: parent.left
        onActivated: {
            root.toggle()
        }
    }
    Label {
        id: timeLabel
        text: Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm")
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: Kirigami.Units.smallSpacing
        }
        height: parent.height
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        z: -1

        Timer {
            repeat: true
            interval: 10000
            Component.onCompleted: {
                start()
            }
            onTriggered: {
                timeLabel.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm")
            }
        }
    }
    ToolbarButton {
        source: "lock"
        hint: "Lock Screen"
        anchors.right: shutdownIcon.left
        onActivated: {
            sm.lock();
            root.toggle();
        }
    }
    ToolbarButton {
        id: shutdownIcon
        hint: "Shutdown / Restart"
        source: "system-shutdown"
        onActivated: {
            sm.requestLogoutPrompt();
            root.toggle();
        }
        anchors.right: parent.right
    }
}
