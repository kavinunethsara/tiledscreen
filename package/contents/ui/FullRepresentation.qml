/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.kicker as Kicker

import './Components'
import './Components/Tile' as Tile

Kicker.DashboardWindow {
    id: root

    property string currentPage: "home"

    onVisibleChanged: {
        if (visible) {
            preloadAllAppsTimer.restart();
        }
    }

    function reloadData() {
        preloadAllAppsTimer.done = false;
        preloadAllAppsTimer.restart();
    }

    Component.onCompleted: {
        rootModel.refresh();
        kicker.reset.connect(reloadData);
    }

    mainItem: Item {
        anchors.fill: parent

        Timer {
            id: preloadAllAppsTimer

            property bool done: false

            interval: 1000
            repeat: false

            onTriggered: {
                if (done) {
                    return;
                }

                for (var i = 0; i < rootModel.count; ++i) {
                    var model = rootModel.modelForRow(i);

                    if (model.description === "KICKER_ALL_MODEL") {
                        appsView.model = model;
                        done = true;
                        break;
                    }
                }
            }
        }

        ColumnLayout{
            id: container
            anchors.fill: parent

            ColumnLayout {
                spacing: Kirigami.Units.smallSpacing * 2
                Layout.alignment: Qt.AlignHCenter
                Layout.margins: Kirigami.Units.largeSpacing * 2
                Layout.fillHeight: true
                Layout.fillWidth: true

                ToolBar {}

                Category{
                    title: root.currentPage == "home" ? "Favourites" : "All Apps"
                    action: root.currentPage != "home" ? "Favourites" : "All Apps"

                    Layout.fillHeight: true
                    fill: true
                    useBackground: false

                    onActivated: root.currentPage == "home" ? root.currentPage = "all" : root.currentPage = "home"

                    AppView {
                        id: appsView
                        visible: root.currentPage == "all"
                        onAddTile: function (metadata) {
                            tileView.addTile("IconTile", metadata)
                        }
                    }

                    Tile.Grid {
                        id: tileView
                        visible: root.currentPage == "home"
                    }
                }
            }
        }
    }
}
