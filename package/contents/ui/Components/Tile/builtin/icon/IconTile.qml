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

    function activate() {
        if (metadata.actionType === 0)
            container.controller.appsView.runApp(root.metadata.action)
        if (metadata.actionType === 1)
            container.controller.exec(root.metadata.action)
    }

    Component.onCompleted: {
        if (!root.metadata.useCustomBack) {
            root.metadata.backColor = imageColor.background
        }
        if (!root.useCustomFront) {
            root.metadata.frontColor = imageColor.foreground
        }
    }

    Kirigami.ImageColors {
        id: imageColor
        source: root.metadata.icon
    }

    color: root.metadata.useCustomBack? root.metadata.backColor : imageColor.background

    Item {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: root.container.model.tileHeight > 1 ? textLabel.top : parent.bottom
        }
        Kirigami.Icon {
            anchors.centerIn: parent
            width: parent.width * 0.75
            source: root.metadata.icon
        }

    }

    PlasmaComponents.Label {
        id: textLabel
        text: root.metadata.name
        horizontalAlignment: Qt.AlignHCenter
        visible: root.container.model.tileHeight > 1
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: Kirigami.Units.smallSpacing
        }
        elide: Qt.ElideRight

        color: root.metadata.useCustomFront? root.metadata.frontColor : imageColor.foreground
    }
}
