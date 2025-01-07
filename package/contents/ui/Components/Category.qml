/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

Item{
    id: root
    property string title
    property string action
    property bool fill: false
    property alias useBackground: containerItem.useBackground
    default property alias content: containerItem.content

    height: mainLayout.implicitHeight
    signal activated
    Layout.fillWidth: true
    Layout.minimumWidth: mainLayout.implicitWidth

    ColumnLayout {
        id: mainLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: root.fill? parent.top : undefined
        anchors.bottom: root.fill? parent.bottom : undefined
        spacing: Kirigami.Units.smallSpacing * 2

        RowLayout {
            Layout.preferredHeight: actionButton.implicitHeight
            PlasmaComponents.Label {
                Layout.fillWidth: true
                text: root.title
            }
            PlasmaComponents.Button {
                id: actionButton
                text: root.action
                visible: root.action
                onClicked: root.activated();
            }
        }

        Card {
            id: containerItem
            Layout.fillHeight: root.fill? true : false
        }
    }
}
