/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.kicker as Kicker

Item {
    id: root

    property bool shouldHaveLabel: plasmoid.configuration.label != ""
    required property bool inPanel
    required property bool vertical

    readonly property var sizing: {
        let impWidth = buttonIcon.implicitWidth;
        if (shouldHaveLabel) {
            impWidth += buttonLabel.contentWidth + buttonLabel.Layout.leftMargin + buttonLabel.Layout.rightMargin;
        }

        // at least square, but can be wider/taller
        if (inPanel) {
            if (vertical) {
                return {
                    preferredWidth: buttonIcon.implicitWidth,
                };
            } else { // horizontal
                return {
                    preferredWidth: impWidth,
                };
            }
        } else {
            return {
                preferredWidth: impWidth,
            };
        }
    }

    Layout.minimumWidth: sizing.preferredWidth

    signal reset

    RowLayout{
        id: rootLayout
        anchors.fill: parent

        Kirigami.Icon {
            id: buttonIcon

            Layout.fillHeight: true
            Layout.minimumHeight: implicitHeight
            Layout.fillWidth: !root.shouldHaveLabel
            Layout.alignment: root.shouldHaveLabel ? Qt.AlignVCenter | Qt.AlignHCenter : Qt.AlignVCenter | Qt.AlignLeft
            source: plasmoid.configuration.icon
            active: mouseArea.containsMouse
            smooth: true
        }
        Label {
            id: buttonLabel
            visible: plasmoid.configuration.label != ""

            Layout.margins: Kirigami.Units.smallSpacing
            verticalAlignment: Qt.AlignVCenter

            text: plasmoid.configuration.label
        }
    }

    FullRepresentation {
        id: dashWindow
    }

    MouseArea
    {
        id: mouseArea

        anchors.fill: parent
        property bool wasExpanded: false;

        activeFocusOnTab: true
        hoverEnabled: !dashWindow.visible

        onClicked: {
            dashWindow.toggleMode();
        }
    }

    Connections {
        target: Plasmoid
        enabled: dashWindow !== null

        function onActivated(): void {
            dashWindow.toggleMode();
            //justOpenedTimer.start();
        }
    }
}
