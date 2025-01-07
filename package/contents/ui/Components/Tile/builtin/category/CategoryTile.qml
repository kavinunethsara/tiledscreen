/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import "../.."

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    required property var metadata
    required property Tile container

    color: "transparent"

    Item {
        id: iconContainer
        visible: root.metadata.icon != ""
        width: root.metadata.icon == ""? 0 : iconItem.implicitWidth
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        Kirigami.Icon {
            id: iconItem
            anchors.centerIn: parent
            height: parent.height * 0.75
            width: height
            source: root.metadata.icon
        }

    }

    PlasmaComponents.Label {
        id: textLabel
        text: root.metadata.name
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        anchors.left: iconContainer.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.margins: Kirigami.Units.smallSpacing
        elide: Qt.ElideRight


        color: Kirigami.Theme.textColor
    }
}
