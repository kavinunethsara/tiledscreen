/*
 * SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

GenericBackground {
    id: root
    property double cellSize: container.controller.cellSize

    property double sidepadding: metadata.height < 2 ? cellSize * 0.2 : cellSize * 0.4

    property alias value: slider.value
    property alias from: slider.from
    property alias to: slider.to
    property alias icon: icon.source
    property bool activatable: false

    signal adjusted()
    signal activated()

    Kirigami.Icon {
        id: icon
        visible: root.metadata.showIcon
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: root.sidepadding
        }
        height: Math.min(root.cellSize * 0.5, parent.height - anchors.margins * 2)
        color: root.metadata.useCustomFront? root.metadata.frontColor : Kirigami.Theme.textColor

        MouseArea {
            anchors.fill: parent
            enabled: root.activatable
            onClicked: root.activated()
        }
    }

    PlasmaComponents.Slider {
        id: slider
        anchors {
            left: icon.right
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: root.sidepadding
        }
        snapMode: PlasmaComponents.Slider.SnapAlways
        onMoved: root.adjusted()
    }
}
