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

    property var fillModes: [Image.Stretch, Image.PreserveAspectCrop, Image.PreserveAspectFit, Image.Pad]

    color: "transparent"

    function activate () {}

    Image {
        id: wallPaper
        clip: true
        fillMode: root.fillModes[root.metadata.mode]
        anchors.fill: parent
        source: root.metadata.image
    }

    Kirigami.Icon {
        anchors.fill: parent
        source: "image-generic"
        visible: wallPaper.status != Image.Ready
        Rectangle {
            color: Kirigami.Theme.textColor
            anchors.fill: parent
            opacity: 0.2
        }
    }

    PlasmaComponents.Label {
        id: textLabel
        text: root.metadata.name
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: Kirigami.Units.smallSpacing
        }
        elide: Qt.ElideRight


        color: root.metadata.useCustomFront ? root.metadata.frontColor : Kirigami.Theme.textColor
    }
}
