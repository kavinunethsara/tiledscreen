import QtQuick
import org.kde.plasma.components as PlasmaComponents

Item {
    id: dragger

    required property variant grid
    required property variant controller
    required property int index
    property variant metadata: {}
    property QtObject internalTile: Item{}
    property string tileType: "IconTile"

    width: len * controller.cellSize
    height: breadth * controller.cellSize
    property int col: 0
    property int row: 0
    property int len: 2
    property int breadth: 2

    z: 1000

    onLenChanged: {
        updateTile()
    }

    onBreadthChanged: {
        updateTile()
    }

    function updateTile() {
        controller.items.forEach((item) => {
            console.warn(item.index + ":"+ dragger.index);
            if (item.id == dragger.index) {
                console.warn("inside");
                item.col = dragger.col,
                item.row =dragger.row,
                item.len = dragger.len,
                item.breadth = dragger.breadth,
                item.plugin = dragger.tileType,
                item.metadata = dragger.metadata
                console.warn(dragger.metadata.name);
                controller.updateGrid();
            }
        });
    }

    Component.onCompleted: {
        if (tileType == "IconTile") {
            const tileContent = Qt.createComponent("IconTile.qml");
            if (tileContent.status == Component.Ready) {
                var intTile = tileContent.createObject(dragger, { metadata: metadata } );
                intTile.update.connect(function() {
                    dragger.metadata = intTile.metadata;
                    updateTile();
                });
                internalTile = intTile
            }
        }

        controller.items.push(
            {
                id: dragger.index,
                col: dragger.col,
                row:dragger.row,
                len: dragger.len,
                breadth:dragger.breadth,
                plugin: dragger.tileType,
                metadata: dragger.metadata
            }
        );
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        property variant prevItem: null

        onPressed: function (mouse) {
            if (mouse.button == Qt.RightButton) {
                dragger.showContextMenu(dragger.index);
            }
            mouse.accepted = true;
        }

        onReleased: function(mouse) {
            prevItem.current = false
            var loc = grid.mapFromItem(grid, dragger.x, dragger.y)
            var item = grid.childAt(loc.x, loc.y)
            if (item) {
                dragger.col = item.col
                dragger.row = item.row
            }
            var itemObject = controller.items.find(o => o.id === dragger.index);
            itemObject.col = dragger.col
            itemObject.row = dragger.row
            dragger.x = dragger.col * controller.cellSize
            dragger.y = dragger.row * controller.cellSize

            controller.updateGrid();
        }

        drag.onActiveChanged:  {
            if (mouseArea.drag.active)
                dragger.controller.editMode = true
            else {
                dragger.controller.editMode = false
            }
        }

        onMouseXChanged: function(mouse) {
            var loc = grid.mapFromItem(grid, dragger.x, dragger.y)
            var item = grid.childAt(loc.x, loc.y)
            if (!item) return
            if (prevItem)
                prevItem.current = false
            item.current = true
            prevItem = item
        }
    }


    PlasmaComponents.Menu {
        id: contextMenu
        property int current: 0
        PlasmaComponents.MenuItem{
            text: "Edit Tile"
            icon.name: "editor"
            onClicked: {
                const conf = Qt.createComponent("ConfigWindow.qml");
                if (conf.status === Component.Ready) {
                    var confDial = conf.createObject(dragger.controller, {tile: dragger});
                    confDial.open();
                }
            }
        }
        PlasmaComponents.MenuItem{
            text: "Delete Tile"
            icon.name: "delete"
            onClicked: {
                var tileList = dragger.controller.items;
                dragger.controller.items = tileList.filter((value, index, arr) => {
                    if (value.id == dragger.index ) { return false; }
                    return true;
                });
                dragger.controller.updateGrid();
                dragger.destroy();
            }
        }
    }

    function showContextMenu(index: int) {
        contextMenu.current = index;
        contextMenu.popup();
    }
}
