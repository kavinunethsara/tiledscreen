/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import QtQuick.Effects
import ".."

GenericBackground {
    id: root
    clip: true

    SourceMultimedia {
        id: player
    }

    property color defaultBack: root.metadata.useCustomBack? root.metadata.backColor : Kirigami.Theme.backgroundColor
    property color defaultFront: root.metadata.useCustomFront? root.metadata.frontColor : Kirigami.Theme.textColor

    color: defaultBack
    layer.enabled: true

    Image {
        id: backgroundImage
        visible: false
        anchors.fill: parent
        source: player.cover
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
    }

    MultiEffect {
        visible: player.cover && root.metadata.backCover
        source: backgroundImage
        anchors.fill: backgroundImage
        maskEnabled: true
        maskSource: root
        blur: 1.0
        blurEnabled: true
        colorizationColor: root.defaultBack
        colorization: 0.65

        autoPaddingEnabled : true
    }

    Kirigami.Icon {
        id: icon
        visible: !player.cover && player.trackName != ""
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: Kirigami.Units.largeSpacing
        }
        height: parent.height - anchors.margins * 2
        source: "emblem-music-symbolic"
        color: root.defaultFront
    }

    Image {
        id: cover
        visible: false
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: Kirigami.Units.largeSpacing
        }
        width: parent.height - anchors.margins * 2
        source: player.cover
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
    }

    Rectangle {
        id: coverMask
        visible: false
        anchors.fill: cover
        color: "black"
        radius: Kirigami.Units.mediumSpacing
        layer.enabled: true
    }

    MultiEffect {
        source: cover
        visible: player.cover
        anchors.fill: cover
        maskEnabled: true
        maskSource: coverMask
    }

    ColumnLayout {
        spacing: Kirigami.Units.smallSpacing
        anchors {
            verticalCenter: parent.verticalCenter
            left: cover.right
            right: buttons.left
            margins: Kirigami.Units.mediumSpacing
        }
        PlasmaComponents.Label {
            text: player.trackName || "No Media Playing"
            Layout.fillWidth: true
            elide: Qt.ElideRight
        }
        PlasmaComponents.Label {
            visible: player.albumName + player.artistName
            text: player.albumName + " | " + player.artistName
            Layout.fillWidth: true
            elide: Qt.ElideRight
        }
    }

    RowLayout {
        id: buttons
        spacing: Kirigami.Units.smallSpacing
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            margins: Kirigami.Units.mediumSpacing
        }
        PlasmaComponents.Button {
            flat: true
            icon.source: "media-seek-backward"
            onClicked: player.prevTrack()
        }
        PlasmaComponents.Button {
            flat: true
            icon.source: player.isPlaying ? "media-playback-pause" : "media-playback-start"
            onClicked: player.playPause()
        }
        PlasmaComponents.Button {
            flat: true
            icon.source: "media-seek-forward"
            onClicked: player.nextTrack()
        }
    }
}
