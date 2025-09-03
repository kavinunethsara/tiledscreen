/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
Item {
    id: root
    property alias mouse: mouseArea

    required property variant model
    property real itemWidth: Kirigami.Units.gridUnit * 14
    property bool small: false
    required property variant itemController
    signal toggle

    height: content.implicitHeight
    width: root.itemWidth - Kirigami.Units.gridUnit * 2

    RowLayout {
        id: content
        Layout.fillWidth: true
        Kirigami.Icon {
            id: icon
            Layout.margins: Kirigami.Units.largeSpacing
            Layout.preferredWidth: root.small ? Kirigami.Units.gridUnit : Kirigami.Units.gridUnit * 2
            source: root.model.decoration
        }
        PlasmaComponents.Label {
            Layout.fillWidth: true
            Layout.maximumWidth: root.width - 5 * Kirigami.Units.largeSpacing - icon.implicitWidth
            Layout.margins:  Kirigami.Units.largeSpacing
            text: root.model.display
            elide: Qt.ElideRight
        }
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        onClicked: function (mouse) {
            if (mouse.button == Qt.RightButton) {
                root.itemController.showContextMenu(root.model.index)
            } else {
                root.trigger()
            }
        }
    }

    Keys.onPressed: event => {
        if ((event.key === Qt.Key_Enter || event.key === Qt.Key_Return)) {
            event.accepted = true
            root.trigger()
        }
    }

    function trigger() {
        if ("trigger" in root.itemController.model) {
            root.itemController.model.trigger(root.model.index, "", null)
            root.toggle()
        }
    }
}
