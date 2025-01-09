/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Rectangle {
    id: sidebar
    z: 10
    radius: Kirigami.Units.smallSpacing

    Kirigami.Theme.colorSet: Kirigami.Theme.Window
    Kirigami.Theme.inherit: false

    color: Kirigami.Theme.backgroundColor;

    property QtObject content: editor
    property var currentPage

    signal closeClicked

    visible: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.smallSpacing
        Button {
            text: i18n("Close")
            onClicked: sidebar.closeClicked()
        }

        Item {
            id: editor
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
