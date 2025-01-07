/*
    SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    switchHeight: Kirigami.Units.gridUnit
    switchWidth: Kirigami.Units.gridUnit
    compactRepresentation: Item{}
    fullRepresentation: ColumnLayout {
        anchors.fill: parent
        Rectangle {
            color: Kirigami.Theme.highlightColor
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            PlasmaComponents.Label {
                text: "Hello World!"
            }
        }
    }
}
