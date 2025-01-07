import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami

pragma ComponentBehavior: Bound

Item {
    id: root
    anchors.fill: parent
    property int minRows: 0
    property variant items: []
    readonly property real cellSize: Kirigami.Units.gridUnit * 2.5

    property bool editMode: false

    RowLayout {
        anchors.fill: parent

        Label {
            id: code
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            text: JSON.stringify(root.items)
            wrapMode: Text.Wrap
        }

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
                            opacity: root.editMode || rt.current ? 0.7 : 0
                        }

                        Component.onCompleted: {
                            if (index == 1) {
                                grid.celx = rt.col
                            }
                        }
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
        code.text = JSON.stringify(root.items)

        root.minRows = row
    }

    function addTile(type: string, metadata: variant) {
        const tile = Qt.createComponent("Tile.qml");
        if (tile.status === Component.Ready) {
            var tileObj = tile.createObject(scroll, { grid: grid, index: scroll.getNewIndex(), len: 2, controller: root, metadata: metadata, tileType: type });
//
        }

    }

}
