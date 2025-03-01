/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */
import QtCore
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
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

    property var installer: Plasma5Support.DataSource {
        engine: "executable"
        connectedSources: []
        onNewData: function(source, data) {
            disconnectSource(source)
            let jsdata = data.stdout + data.stderr
            if (jsdata != "") {
                root.statusDialog.text = jsdata
            } else {
                root.controller.getTiles()
                root.statusDialog.text = "Successfully installed"
            }
            root.statusDialog.open()
        }

        function install(file) {
            const scriptUrl = Qt.resolvedUrl("../scripts/tileInstaller.py").toString().replace("file://", "")
            let path = file.replace("file://", "")
            root.installer.connectSource("python '" + scriptUrl+ "' '"+path+"'")
        }
    }

    property var statusDialog:Kirigami.Dialog {
        property alias text: statusDialogLabel.text
        ColumnLayout {
            PlasmaComponents.Label {
                id: statusDialogLabel
                Layout.fillWidth: true
                Layout.margins: Kirigami.Units.largeSpacing
            }
        }
    }

    property var fileDialog: FileDialog {
        currentFolder: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0]
        nameFilters: ["Tile zip archive (*.tile.zip)"]
        onAccepted: {
            root.installer.install(selectedFile.toString())
        }
    }

    customFooterActions: [
        Kirigami.Action {
            text: i18n("Download Tiles...")
            icon.name: "download"
            onTriggered: {
                Qt.openUrlExternally("https://kavinunethsara.github.io/tiledwidgets/store")
            }
        },
        Kirigami.Action {
            text: i18n("Install from file")
            icon.name: "install"
            onTriggered: root.fileDialog.open()
        }
    ]

    ListView {
        id: listView
        Layout.fillWidth: true
        implicitWidth: Kirigami.Units.gridUnit * 18
        implicitHeight: Kirigami.Units.gridUnit * 20
        clip: true

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

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: function (mouse) {
                let pos = mapToItem(parent.contentItem, Qt.point(mouse.x, mouse.y))
                let tile = listView.indexAt(pos.x, pos.y)
                if (tile == -1)
                    return
                    root.controller.createTile(root.tiles[tile], root.position.x, root.position.y)
                    root.close()
            }

            onMouseXChanged:  function(mouse) { setCurrent(mouse) }
            onMouseYChanged:  function(mouse) { setCurrent(mouse) }

            function setCurrent(mouse) {
                let pos = mapToItem(parent.contentItem, Qt.point(mouse.x, mouse.y))
                let tile = listView.indexAt(pos.x, pos.y)
                if (tile == -1)
                    return
                    listView.currentIndex = tile
            }

        }
    }
}
