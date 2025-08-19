/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasma5support as Plasma5Support
import "../.."

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    required property var metadata
    required property Tile container

    property var fillModes: [Image.Stretch, Image.PreserveAspectCrop, Image.PreserveAspectFit, Image.Pad]

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: function(source, data) {
            disconnectSource(source)
        }

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }

    function activate() {
        if (metadata.actionType === 0)
            container.controller.appsView.runApp(root.metadata.action)
        if (metadata.actionType === 1)
            executable.exec(root.metadata.action)
    }

    Component.onCompleted: {
        if (!root.metadata.useCustomBack) {
            root.metadata.backColor = imageColor.background.toString()
        }
        if (!root.metadata.useCustomFront) {
            root.metadata.frontColor = imageColor.foreground.toString()
        }
    }

    /* This timer is required to prevent multiple refreshes of the imageColors object.
     * Otherwise it refreshes too many times and crash when usin a path as an icon
     */
    Timer {
        id: iconTimer
        interval: 1000
        repeat: false
        triggeredOnStart: true
        onTriggered: {
            imageColor.source = root.metadata.icon
        }
    }

    onMetadataChanged: {
        iconTimer.restart()
    }

    // BUG: Multiple consecutive refreshes when using a file path causes SegmentationFault
    // Worked around by using a timer to stagger the refreshes
    Kirigami.ImageColors {
        id: imageColor
    }

    // Background Image
    Image {
        id: backImage
        anchors.fill: parent
        visible: root.metadata.useBackgroundImage

        source: root.metadata.backgroundImage
        fillMode: root.fillModes[root.metadata.imageMode]
    }

    color: root.metadata.useCustomBack? root.metadata.backColor : imageColor.background

    Item {
        visible: root.metadata.showIcon
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
