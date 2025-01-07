import QtQuick
// import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    required property variant grid
    required property variant controller
    required property int index
    id: dragger
    color: "green"
    width: len * controller.cellSize
    height: breadth * controller.cellSize
    property int col: 0
    property int row: 0
    property int len: 2
    property int breadth: 2

    border.color: "white"
    border.width: 2

    z: 1000

    Label {
        id: tee
        text: "NAN"
    }

    Component.onCompleted: {
        controller.items.push(
            {
                id: dragger.index,
                col: dragger.col,
                row:dragger.row,
                len: dragger.len,
                breadth:dragger.breadth,
                plugin: "icon",
                metadata: {
                    name: "Icon"
                }
            }
        );
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent

        property variant prevItem: null
        onReleased: function(mouse) {
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
            if (prevItem)
                prevItem.current = false
                var loc = grid.mapFromItem(grid, dragger.x, dragger.y)
                var item = grid.childAt(loc.x, loc.y)
                item.current = true
                prevItem = item
        }
    }
}
