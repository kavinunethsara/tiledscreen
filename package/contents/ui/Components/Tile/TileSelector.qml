/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */
import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import org.kde.plasma.extras as PlasmaExtras

import QtQuick.Dialogs
import org.kde.plasma.plasma5support as Plasma5Support

pragma ComponentBehavior: Bound

Kirigami.Dialog {
    id: root
    title: i18n("Tiles")

    required property var tiles
    required property var controller
    property point position: Qt.point(0, 0)

    Item {
        id: container
        // hints for the dialog dimensions
        implicitWidth: Kirigami.Units.gridUnit * 20 + Kirigami.Units.mediumSpacing * 4 + Kirigami.Units.largeSpacing * 2
        implicitHeight: Kirigami.Units.gridUnit * 16 + Kirigami.Units.largeSpacing * 2

        Button {
            id: installButton
            text: i18n("Install from file")
            anchors.top: parent.top
            anchors.right: parent.right
            onClicked: fileDialog.open()
        }

        Plasma5Support.DataSource {
            id: installer
            engine: "executable"
            connectedSources: []
            onNewData: function(source, data) {
                disconnectSource(source)
                let jsdata = data.stdout + data.stderr
                if (jsdata != "") {
                    statusDialog.text = jsdata
                } else {
                    root.controller.getTiles()
                    statusDialog.text = "Successfully installed"
                }
                statusDialog.open()
            }

            function install(file) {
                const scriptUrl = Qt.resolvedUrl("../scripts/tileInstaller.py").toString().replace("file://", "")
                let path = file.replace("file://", "")
                installer.connectSource("python '" + scriptUrl+ "' '"+path+"'")
            }
        }

        Kirigami.Dialog {
            id: statusDialog
            property alias text: statusDialogLabel.text
            ColumnLayout {
                Label {
                    id: statusDialogLabel
                    Layout.fillWidth: true
                    Layout.margins: Kirigami.Units.largeSpacing
                }
            }
        }

        FileDialog {
            id: fileDialog
            currentFolder: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0]
            nameFilters: ["Tile zip archive (*.tile.zip)"]
            onAccepted: {
                installer.install(selectedFile.toString())
            }
        }

        ListView {
            id: listView
            anchors {
                top: installButton.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            anchors.margins: Kirigami.Units.largeSpacing

            highlight: PlasmaExtras.Highlight {}

            model: root.tiles

            delegate:  RowLayout {
                id: del
                required property var model
                anchors.left: parent.left
                anchors.right: parent.right
                Kirigami.IconTitleSubtitle {
                    icon.source: del.model.icon
                    title: del.model.name
                    subtitle: del.model.description
                    Layout.margins: Kirigami.Units.smallSpacing
                }
            }
        }

        MouseArea{
            id: mouseArea
            anchors.fill: listView
            hoverEnabled: true
            onClicked: function (mouse) {
                let pos = mouseArea.mapToItem(listView, Qt.point(mouse.x, mouse.y))
                let tile = listView.indexAt(pos.x, pos.y)
                if (tile == -1)
                    return
                root.controller.createTile(root.tiles[tile], root.position.x, root.position.y)
                root.close()
            }

            onMouseXChanged:  function(mouse) { setCurrent(mouse) }
            onMouseYChanged:  function(mouse) { setCurrent(mouse) }

            function setCurrent(mouse) {
                let pos = mouseArea.mapToItem(listView, Qt.point(mouse.x, mouse.y))
                let tile = listView.indexAt(pos.x, pos.y)
                if (tile == -1)
                    return
                listView.currentIndex = tile
            }

        }
    }
}
