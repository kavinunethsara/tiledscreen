/*
 * SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */
import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

GenericBackground {
    id: root
    property bool toggled
    property alias icon: icon.source
    property alias text: label.text

    Component.onCompleted: {
        container.toggleOnActivate = false
    }

    Rectangle {
        visible: root.toggled
        anchors.fill: parent
        radius: parent.radius
        color: Kirigami.Theme.highlightColor
        opacity: 0.3
    }

    Kirigami.Icon {
        id: icon
        anchors {
            top: parent.top
            bottom: label.visible ? label.top : parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: Kirigami.Units.mediumSpacing
        }
        color: root.metadata.useCustomFront? root.metadata.frontColor : Kirigami.Theme.textColor
    }

    PlasmaComponents.Label {
        id: label
        visible: root.metadata.width > 1 && root.metadata.height > 1 && root.metadata.showLabel
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: Kirigami.Units.mediumSpacing
        }
        horizontalAlignment: Qt.AlignHCenter
    }
}
