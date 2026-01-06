/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.kicker as Kicker

import './Components'
import './Components/Tile' as Tile
import './Components/Tutorial' as Tutorial

Kicker.DashboardWindow {
    id: root

    property string currentPage: "home"
    property Timer activationTimer: Timer {
        interval: 250
        running: false

    }

    backgroundColor: "transparent"

    onVisibleChanged: {
        if (visible) {
            root.currentPage = "home"
            mainCat.searchText = ""
            mainCat.grabFocus()
        }
        tileView.closeEditor()
    }

    onCurrentPageChanged: {
        tileView.closeEditor()
    }

    function reloadData() {
    }

    function toggleMode() {
        if (root.visible) {
            if (activationTimer.running && root.currentPage == "home") {
                root.currentPage = "all";
                return;
            }
            activationTimer.stop();
        } else {
            activationTimer.start();
        }
        root.toggle();
    }

    Component.onCompleted: {
        rootModel.refresh();
        kicker.reset.connect(reloadData);
    }


    mainItem: Item {
        anchors.fill: parent

        Keys.onReleased: event => {
            if (event.key === Qt.Key_Escape) {
                root.close()
            }
        }

        Item{
            id: background
            anchors.fill: parent
            opacity: plasmoid.configuration.backgroundOpacity / 100
            z: 0
            Image {
                id: bgImage
                anchors.fill: parent;
                visible: plasmoid.configuration.useBackgroundImage
                source: plasmoid.configuration.backgroundImage
                opacity: 0
                fillMode: Image.PreserveAspectCrop
            }
            MultiEffect {
                visible: plasmoid.configuration.useBackgroundImage
                source: bgImage
                anchors.fill: bgImage
                anchors.margins: -64
                blurEnabled: true
                // saturation: 10
                // contrast: 0.2
                blurMax: 64
                blur: plasmoid.configuration.backgroundImageBlur / 100
            }
        }

        Rectangle {
            anchors.fill: parent
            color: Kirigami.Theme.backgroundColor
            opacity: plasmoid.configuration.overlayOpacity / 100
        }

        Loader {
            anchors.fill: parent
            visible: plasmoid.configuration.firstRun
            active: plasmoid.configuration.firstRun
            sourceComponent: Tutorial.Guide{}
        }

        ColumnLayout{
            id: container
            anchors.fill: parent
            visible: !plasmoid.configuration.firstRun

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

                    title: (root.currentPage == "search") ? i18n("Search") :
                    root.currentPage == "home" ? i18n("Favourites") :
                    root.currentPage == "all" ? i18n("All Apps") : root.currentPage

                    action: root.currentPage != "home" ? i18n("Favourites") : i18n("All Apps")

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
                        if (expandedView.currentView) {
                            expandedView.currentView.destroy()
                        }

                        if (searchText != "") {
                            searchText = ""
                            return
                        }
                        if (root.currentPage == "home") {
                            root.currentPage = "all"
                        } else {
                            root.currentPage = "home"
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
                            tileView.addTile("icon", metadata)
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
                            tileView.addTile("icon", metadata)
                        }
                        onToggle: {
                            root.toggle()
                        }
                    }

                    Tile.Grid {
                        id: tileView
                        visible: root.currentPage == "home"
                        property variant appsView: appsView

                        onToggled: {
                            root.toggle()
                        }

                        onExpanded: function (view, data) {
                            if (expandedView.currentView)
                                expandedView.currentView.destroy()
                            expandedView.currentView = view.createObject(expandedView, data)
                        }
                    }

                    Item {
                        id: expandedView
                        anchors.centerIn: parent

                        property Item currentView: null
                        visible: currentView

                        width: parent.width / 2
                        height: parent.height / 2

                        Rectangle {
                            anchors.fill: parent
                            color: Kirigami.Theme.backgroundColor
                            radius: Kirigami.Units.mediumSpacing
                        }

                    }
                }
            }
        }
    }
}
