import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

Item {
    id: dragger

    required property variant grid
    required property variant controller
    required property int index
    property variant metadata: {}
    property QtObject internalTile: Item{}
    property string tileType

    property alias hover: mouseArea.containsMouse

    width: len * controller.cellSize
    height: breadth * controller.cellSize
    property int col: 0
    property int row: 0
    property int len: 2
    property int breadth: 2

    signal toggled()

    z: 1000

    onLenChanged: {
        updateTile()
    }

    onBreadthChanged: {
        updateTile()
    }

    onTileTypeChanged: {
        updateTile()
    }

    function updateTile() {
        console.warn(dragger.index);
        controller.items.forEach((item) => {
            if (item.id == dragger.index) {
                item.col = dragger.col,
                item.row =dragger.row,
                item.len = dragger.len,
                item.breadth = dragger.breadth,
                item.plugin = dragger.tileType,
                item.metadata = dragger.metadata
                controller.updateGrid();
            }
        });
    }

    Component.onCompleted: {
        dragger.x = dragger.col * controller.cellSize
        dragger.y = dragger.row * controller.cellSize

        console.warn(dragger.tileType +" Setup");
        const tileContent = Qt.createComponent(dragger.tileType + ".qml");
        if (tileContent.status == Component.Ready) {
            console.warn("Comp created with index "+dragger.index);
            var intTile = tileContent.createObject(dragger, { metadata: metadata, container: dragger } );
            intTile.update.connect(function() {
                dragger.metadata = intTile.metadata;
                updateTile();
            });
            internalTile = intTile
        }
        var addItem = true
        controller.items.forEach ((item) => {
            console.warn("Comparing "+dragger.index+" to "+item.id+ " of type "+item.plugin)
           if (item.id == dragger.index) addItem = false
        });
        if (!addItem) return;
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
        hoverEnabled: true

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
            // Only move or activate if on a valid tile block
            if (item) {
                // If we are in the same place, acctivate the tile
                if (dragger.col == item.col && dragger.row == item.row && mouse.button == Qt.LeftButton) {
                    dragger.internalTile.activate();
                    dragger.toggled();
                    return;
                }

                // Else move
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
                var conf = Qt.createComponent("ConfigWindow.qml");
                if (dragger.internalTile.config != "")
                    conf = Qt.createComponent(dragger.internalTile.config + ".qml");
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
