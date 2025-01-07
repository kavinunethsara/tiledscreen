import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

Item {
    id: root

    required property var model
    property var controller: model.controller
    property var grid: model.grid

    property variant tileData: {}
    property QtObject internalTile: Item{}

    property alias hover: mouseArea.containsMouse

    width: model.tileWidth * controller.cellSize
    height: model.tileHeight * controller.cellSize
    x: model.column * controller.cellSize
    y: model.row * controller.cellSize

    z: 1000

    Component.onCompleted: {
        root.tileData = JSON.parse(root.model.metadata);
        let tileInfo = controller.tiles.find((tile) => tile.plugin == root.model.plugin)
        const tileContent = Qt.createComponent(tileInfo.path + "/" +tileInfo.main);
        if (tileContent.status == Component.Ready) {
            var intTile = tileContent.createObject(root, { metadata: Qt.binding(function() { return root.tileData }), container: root } );
            internalTile = intTile
        }

    }

    onTileDataChanged: {
        root.model.metadata = JSON.stringify(root.tileData);
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        property variant prevItem: null

        onClicked: function (mouse) {
            // If we are in the same place, acctivate the tile
            if (mouse.button == Qt.LeftButton) {
                if (root.controller.editMode){
                    root.openEditor();
                    return
                }
                root.internalTile.activate();
                controller.toggled();
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
            text: "Edit Tile"
            icon.name: "editor"
            onClicked: {
                root.openEditor()
            }
        }

        PlasmaComponents.MenuItem{
            text: "Delete Tile"
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
        let tileInfo = controller.tiles.find((tile) => tile.plugin == root.model.plugin)
        var conf = Qt.createComponent(tileInfo.path + "/" + tileInfo.config);
        if (conf.status === Component.Ready) {
            root.controller.openEditor(conf, {tile: root});
        }
    }
}
