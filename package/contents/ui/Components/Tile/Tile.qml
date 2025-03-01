/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import '../scripts/util.js' as Utils

Item {
    id: root

    required property var model
    required property int index
    property var controller: model.controller
    property var grid: model.grid
    property bool toggleOnActivate: true

    property variant config: {}
    property variant tileData: {}
    property QtObject internalTile: Item{}

    property alias hover: mouseArea.containsMouse

    width: model.tileWidth * controller.cellSize
    height: model.tileHeight * controller.cellSize
    x: model.column * controller.cellSize
    y: model.row * controller.cellSize

    z: 1000

    Component.onCompleted: {
        let tileInfo = controller.tiles.find((tile) => tile.plugin == root.model.plugin)
        root.config = new Utils.TileData(root, tileInfo.defaults)

        // For backward compatibility with API 0.9
        root.tileData = JSON.parse(root.model.metadata)

        const tileContent = Qt.createComponent(tileInfo.path + "/" +tileInfo.main)
        if (tileContent.status == Component.Ready) {
            var intTile = tileContent.createObject(root, {
                metadata: Qt.binding(function() { return root.config }),
                container: root
            } );
            internalTile = intTile
        }

    }

    // Sync changes from old API to new one
    onTileDataChanged: {
        if (root.tileData) {
            root.config.metadata = root.tileData
            root.configChanged()
            root.model.metadata = JSON.stringify(root.tileData)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        hoverEnabled: true

        property variant prevItem: null

        onClicked: function (mouse) {
            // If we are in the same place, acctivate the tile
            if (mouse.button != Qt.RightButton) {
                if (root.controller.editMode){
                    root.openEditor();
                    return
                }
                if (root.internalTile.activate) {
                    root.internalTile.activate(mouse)
                    if (toggleOnActivate)
                        controller.toggled()
                }
                return;
            }
            if (mouse.button == Qt.RightButton) {
                root.showContextMenu(model.index);
                mouse.accepted = true;
            }
        }

        onReleased: function(mouse) {
            prevItem.current = false
            var loc = grid.mapFromItem(root.controller.tileContainer, root.x, root.y)
            var item = grid.childAt(loc.x, loc.y)

            // Need to reset row and column ensure that position will be updated
            var col = root.model.column;
            var row = root.model.row;
            root.model.column = 0
            root.model.row = 0

            // Only move or activate if on a valid tile block
            if (item) {
                root.model.column = item.col
                root.model.row = item.row

                // Move items below the tile if it's a grouping tile
                if ( root.tileData.hasOwnProperty("grouping") && root.tileData.grouping ) {
                    // 'grouping' is treated as a special metadata to signal that the tile is a Groouping tile
                    for (let i =0; i < controller.itemModel.count; i++) {
                        if (root.index  == i) continue // Skip if its the same tile

                        let tempElem = controller.itemModel.get(i)
                        let verticallyInside = tempElem.row >= row + root.model.tileHeight
                        let horizontallyInside = tempElem.column >= col && tempElem.column < col + root.model.tileWidth

                        if (verticallyInside && horizontallyInside) {
                            controller.itemModel.get(i).row += (root.model.row - row)
                            controller.itemModel.get(i).column += (root.model.column - col)
                        }
                    }
                }
            } else {
                // Reset the position if not in a valid grid cell
                root.model.column = col;
                root.model.row = row;
            }

            controller.updateGrid();
        }

        drag.onActiveChanged:  {
            if (mouseArea.drag.active)
                root.controller.dragMode = true
            else {
                root.controller.dragMode = false
            }
        }

        onMouseXChanged: function(mouse) { mouseArea.move(mouse) }
        onMouseYChanged: function(mouse) { mouseArea.move(mouse) }

        function move(mouse) {
            var loc = root.grid.mapFromItem(root.controller.tileContainer, root.x, root.y)
            var item = root.grid.childAt(loc.x, loc.y)
            if (!item) return
            if (prevItem)
                prevItem.current = false
            item.current = true
            prevItem = item
        }
    }

    HoverOutlineEffect {
        anchors.fill: parent
        mouseArea: mouseArea
        anchors.margins: Kirigami.Units.smallSpacing
        z: 2
    }


    PlasmaComponents.Menu {
        id: contextMenu
        property int current: 0
        PlasmaComponents.MenuItem{
            text: i18n("Edit Tile")
            icon.name: "editor"
            onClicked: {
                root.openEditor()
            }
        }

        PlasmaComponents.MenuItem{
            text: i18n("Delete Tile")
            icon.name: "delete"
            onClicked: {
                root.controller.itemModel.remove(contextMenu.current);
            }
        }
    }

    function showContextMenu(index: int) {
        contextMenu.current = index;
        contextMenu.popup();
    }


    function openEditor() {
        const tileInfo = controller.tiles.find((tile) => tile.plugin == root.model.plugin)
        var conf = Qt.createComponent(tileInfo.path + "/" + tileInfo.config);
        if (conf.status === Component.Ready) {
            const tileOpts = {
                tile: root,
                config: Qt.binding(function() {
                    return root.config
                })
            }
            root.controller.openEditor(conf, tileOpts);
        }
    }

    function expandView() {
        const tileInfo = controller.tiles.find((tile) => tile.plugin == root.model.plugin)
        if (!tileInfo.expandedView) return
        var expansion = Qt.createComponent(tileInfo.path + "/" + tileInfo.expandedView);
        if (expansion.status === Component.Ready) {
            const tileOpts = {
                tile: root,
                config: Qt.binding(function() {
                    return root.config
                })
            }
            root.controller.expanded(expansion, tileOpts);
        }
    }
}
