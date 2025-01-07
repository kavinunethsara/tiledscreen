/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.Card{
    id: root
    default property alias content: container.children
    property bool useBackground: false
    Layout.fillWidth: true
    Layout.minimumHeight: container.implicitHeight
    Layout.minimumWidth: container.implicitWidth
    Behavior on implicitHeight {
        NumberAnimation { duration: 10000000 }
    }
    ColumnLayout {
        id: container
        anchors.fill: parent
    }
    background: Rectangle {
        opacity: root.useBackground? 1 : 0
        radius: Kirigami.Units.largeSpacing
        color: Kirigami.Theme.backgroundColor
    }
}
