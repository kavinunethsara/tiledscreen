/*
 S PDX-FileCopyrightText: 2024 Ka*vinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

import './Components'

Item {
    id: root
    Layout.minimumWidth: Kirigami.Units.gridUnit * 2
    Layout.preferredWidth: Kirigami.Units.gridUnit * 25
    Layout.preferredHeight: Kirigami.Units.gridUnit * 45

    property string currentPage: "home"
    required property KickerModel kicker

    ColumnLayout{
        id: container
        anchors.fill: parent

        RowLayout {
            spacing: Kirigami.Units.smallSpacing * 2
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: Kirigami.Units.largeSpacing * 2
            Layout.fillHeight: true
            Layout.fillWidth: true

            ColumnLayout{
                id: mainColumn
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.preferredWidth: Kirigami.Units.gridUnit * 5

                Category{
                    title: root.currentPage == "home" ? "Favourites" : "All Apps"
                    action: root.currentPage != "home" ? "Favourites" : "All Apps"

                    Layout.fillHeight: true
                    fill: true
                    useBackground: true

                    onActivated: root.currentPage == "home" ? root.currentPage = "all" : root.currentPage = "home"

                    Component.onCompleted: {
                        root.kicker.appModel.refresh()
                        appsView.model = root.kicker.appModel.modelForRow(2)
                    }

                    AppView {
                        id: appsView
                        model: root.kicker.appModel.modelForRow(2)
                    }
                }

                PlasmaComponents.TextField {
                    placeholderText: "Search"
                    Layout.fillWidth: true
                }
            }

            Sidebar {
                id: sidebar
                currentPage: root.currentPage
                kicker: root.kicker
            }
        }
    }

    function update() {
        sidebar.update()
        appsView.model = root.kicker.appModel.modelForRow(2)
    }
}
