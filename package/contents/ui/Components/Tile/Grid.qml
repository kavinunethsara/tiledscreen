import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

pragma ComponentBehavior: Bound

Item {
    id: root
    anchors.fill: parent
    property int minRows: 0
    property variant items: []
    property real cellSizeMultiplier: plasmoid.configuration.cellSize / 10
    readonly property real cellSize: Kirigami.Units.gridUnit * 2.5 * cellSizeMultiplier

    property bool editMode: false
    property bool initialLoad: true

    onItemsChanged: {
        refreshItems();
    }

    function refreshItems () {
        if (!initialLoad) {
            plasmoid.configuration.tiles = JSON.stringify(root.items)
        }
    }

    Component.onCompleted: {
        initialLoad = true
        items = JSON.parse(plasmoid.configuration.tiles)
        items.forEach((item) => {
           addTile(item.plugin, item.metadata, item.len, item.breadth, item.col, item.row, item.id);
        });
        initialLoad = false
    }

    RowLayout {
        anchors.fill: parent

        ScrollView {
            id: scroll
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: grid.implicitWidth
            contentHeight: grid.implicitHeight

            function getNewIndex(): int {
                return Math.random() * 100000
            }

            GridLayout {
                id: grid
                columns: Math.floor(scroll.width / root.cellSize)
                property real celx: 0
                columnSpacing: 0
                rowSpacing: 0
                Repeater {
                    model : Math.floor(scroll.width / root.cellSize) * Math.floor(Math.max(scroll.height / root.cellSize, root.minRows))
                    delegate: Item {
                        id: rt
                        required property int index
                        property int row: Math.floor(index / grid.columns)
                        property int col: index - (row * grid.columns)
                        property bool current: false
                        property bool gridBox: true
                        height: root.cellSize
                        width: root.cellSize

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 2
                            color: rt.current? Kirigami.Theme.highlightColor : Kirigami.Theme.linkColor
                            opacity: root.editMode ? 0.7 : 0
                        }

                        Component.onCompleted: {
                            if (index == 1) {
                                grid.celx = rt.col
                            }
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: function (mouse) {
                    var pos = scroll.mapToItem(grid, mouse.x, mouse.y);
                    var item = grid.childAt(pos.x, pos.y);
                    if (item.gridBox) {
                        contextMenu.current = item.index
                        contextMenu.popup();
                    }
                }
            }

            PlasmaComponents.Menu {
                id: contextMenu
                property int current: 0
                PlasmaComponents.MenuItem{
                    text: "Add Icon Tile"
                    icon.name: "application-x-executable"
                    onClicked: {
                        var metadata = {
                            name: "Icon",
                            icon: "empty",
                            useCustomBack: false,
                            useCustomFront: false,
                            backColor: Qt.color.white,
                            frontColor: Kirigami.Theme.textColor,
                            actionType: 0,
                            action: ""
                        }
                        root.addTile("IconTile",metadata);
                    }
                }
                PlasmaComponents.MenuItem{
                    text: "Add Header Tile"
                    icon.name: "category"
                    onClicked: {
                        var metadata = {
                            name: "Category",
                            icon: ""
                        }
                        root.addTile("CategoryTile",metadata, 4, 1);
                    }
                }
            }

        }

    }

    function updateGrid() {
        var rows = Math.floor(grid.children.length / grid.columns)
        var row = 0
        items.forEach((item) => {
            if (row < (item.row + item.breadth)) row = item.row + item.breadth + 1
        });
        root.refreshItems()

        root.minRows = row
    }

    function addTile(type: string, metadata: variant, len = 2, breadth = 2, col = 0, row = 0, index = 0) {
        const tile = Qt.createComponent("Tile.qml");
        if (index == 0) index = scroll.getNewIndex() + 1
        if (tile.status === Component.Ready) {
            var tileObj = tile.createObject(scroll, { grid: grid, index: index, len: len, breadth: breadth, col: col, row: row, controller: root, metadata: metadata, tileType: type });
//
        }
        root.updateGrid();
    }

}
