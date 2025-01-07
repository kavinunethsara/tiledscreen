/*
 S PDX-FileCopyrightText: 2024 Ka*vinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

Item {
    id: root
    property PlasmoidItem plasmoidRoot

    Kirigami.Icon {
        id: buttonIcon

        anchors.fill: parent
        source: "kickoff"
        active: mouseArea.containsMouse
        smooth: true
    }

    MouseArea
    {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true

        onClicked: plasmoidRoot.plasmoid.toggled = !plasmoidRoot.plasmoid.toggled
    }
}
