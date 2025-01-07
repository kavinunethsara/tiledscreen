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

    backgroundColor: Kirigami.Theme.backgroundColor.alpha(0.65)

    onVisibleChanged: {
        if (visible) {
            root.currentPage = "home"
            mainCat.searchText = "";
            mainCat.grabFocus();
        }
    }

    function reloadData() {
    }

    Component.onCompleted: {
        rootModel.refresh();
        kicker.reset.connect(reloadData);
    }


    mainItem: Item {
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.toggle();
            }
        }

        ColumnLayout{
            id: container
            anchors.fill: parent

            ColumnLayout {
                spacing: Kirigami.Units.smallSpacing * 2
                Layout.alignment: Qt.AlignHCenter
                Layout.margins: Kirigami.Units.largeSpacing * 2
                Layout.bottomMargin: 0
                Layout.fillHeight: true
                Layout.fillWidth: true

                ToolBar {
                    id: toolBar
                    onToggle: {
                        root.toggle();
                    }
                }

                Category{
                    id: mainCat

                    title: (root.currentPage == "search") ? "Search" : root.currentPage == "home" ? "Favourites" : "All Apps"
                    action: root.currentPage != "home" ? "Favourites" : "All Apps"

                    Layout.fillHeight: parent? true : false
                    anchors {
                        top: toolBar.bottom
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }

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
                        model: rootModel.count ? rootModel.modelForRow(0) : null
                        onAddTile: function (metadata) {
                            tileView.addTile("IconTile", metadata)
                        }
                        onToggle: {
                            root.toggle()
                        }
                    }

                    AppView {
                        id: searchView
                        // Forces the function be re-run every time runnerModel.count changes.
                        // This is absolutely necessary to make the search view work reliably.'
                        // (From Kickoff source code)
                        model: runnerModel.count ? runnerModel.modelForRow(0) : null
                        visible: root.currentPage == "search"
                        onAddTile: function (metadata) {
                            tileView.addTile("IconTile", metadata)
                        }
                        onToggle: {
                            root.toggle()
                        }
                    }

                    Tile.Grid {
                        id: tileView
                        visible: root.currentPage == "home"
                        appsView: appsView
                        onToggled: {
                            root.toggle()
                        }
                    }
                }
            }
        }
    }
}
