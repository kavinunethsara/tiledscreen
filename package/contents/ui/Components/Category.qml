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
    property bool hasSearch: false
    property bool fill: false
    property alias useBackground: containerItem.useBackground
    property alias searchText: search.text
    property alias textField: search
    default property alias content: containerItem.content

    Keys.forwardTo: hasSearch? [search] : [root]

    signal activated

    height: mainLayout.implicitHeight
    Layout.fillWidth: true
    Layout.minimumWidth: mainLayout.implicitWidth
    ColumnLayout {
        id: mainLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: root.fill? parent.top : undefined
        anchors.bottom: root.fill? parent.bottom : undefined
        //spacing: Kirigami.Units.smallSpacing * 2

        Item {
            Layout.preferredHeight: actionButton.implicitHeight
            Layout.fillWidth: true

            PlasmaComponents.Label {
                text: root.title
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
            }
            PlasmaComponents.TextField {
                id: search
                visible: root.hasSearch
                implicitWidth: Kirigami.Units.gridUnit * 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: "Search..."
            }
            PlasmaComponents.Button {
                id: actionButton

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

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

    function grabFocus () {
        search.forceActiveFocus();
    }
}
