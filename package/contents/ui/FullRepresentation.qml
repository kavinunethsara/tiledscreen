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
            mainCat.grabFocus();
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

                searchView.model = runnerModel.modelForRow(0)
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
                    id: mainCat

                    title: (root.currentPage == "search") ? "Search" : root.currentPage == "home" ? "Favourites" : "All Apps"
                    action: root.currentPage != "home" ? "Favourites" : "All Apps"

                    Layout.fillHeight: true
                    hasSearch: true
                    fill: true
                    useBackground: false

                    onActivated: {
                        if (searchText != "") {
                            searchText = "";
                            return;
                        }
                        if (root.currentPage == "home") {
                            root.currentPage = "all" ;
                        } else {
                            root.currentPage = "home";
                        }
                    }

                    onSearchTextChanged: {
                        if (searchText != "") {
                            root.currentPage = "search"
                        } else {
                            root.currentPage = "home"
                            return
                        }
                        runnerModel.query = searchText;
                    }

                    AppView {
                        id: appsView
                        visible: root.currentPage == "all"
                        onAddTile: function (metadata) {
                            tileView.addTile("IconTile", metadata)
                        }
                    }

                    AppView {
                        id: searchView
                        visible: root.currentPage == "search"
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
