/*
 * SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.kirigamiaddons.components 1.0 as KirigamiComponents
import org.kde.plasma.private.sessions as Sessions
import org.kde.coreaddons 1.0 as KCoreAddons
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

    Sessions.SessionsModel {
        id: sessionsModel
    }

    KCoreAddons.KUser {
        id: userInfo
    }

    ToolbarButton {
        source: "desktop-symbolic"
        hint: "Desktop"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
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
    Rectangle {
        visible:plasmoid.configuration.showUserInfo

        color: mouseArea.containsMouse ? Kirigami.Theme.highlightColor :Kirigami.Theme.backgroundColor
        width: userIcon.width + userLabel.width+ Kirigami.Units.mediumSpacing * 4
        height: userIcon.height + Kirigami.Units.mediumSpacing * 2
        radius: height

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: lockIcon.left

        KirigamiComponents.Avatar {
            id: userIcon

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: Kirigami.Units.mediumSpacing
            height: Kirigami.Units.gridUnit * 2
            width: height

            name: plasmoid.configuration.userInfoStyle == 0 ? userInfo.fullName : userInfo.loginName
            source: userInfo.faceIconUrl.toString()
        }
        Label {
            id: userLabel
            text: userInfo.fullName
            anchors.left: userIcon.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: Kirigami.Units.mediumSpacing

            color: mouseArea.containsMouse ? Kirigami.Theme.highlightedTextColor :Kirigami.Theme.textColor
        }

        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
            onClicked: sessionsModel.startNewSession(sessionsModel.shouldLock)
        }
    }
    ToolbarButton {
        id: lockIcon
        visible:plasmoid.configuration.showLockButton
        source: "lock"
        hint: "Lock Screen"
        anchors.right: shutdownIcon.left
        anchors.verticalCenter: parent.verticalCenter
        onActivated: {
            sm.lock();
            root.toggle();
        }
    }
    ToolbarButton {
        id: shutdownIcon
        visible:plasmoid.configuration.showLogoutButton
        hint: "Shutdown / Restart"
        source: "system-shutdown"
        onActivated: {
            sm.requestLogoutPrompt();
            root.toggle();
        }
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
