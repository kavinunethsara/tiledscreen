import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.private.kicker as Kicker
import org.kde.kirigami as Kirigami


pragma ComponentBehavior: Bound

Item {
    id: root
    anchors.fill: parent
    property int minRows: 0
    property int count: 0
    property ListModel itemModel: ListModel {
        onDataChanged: {
            refreshItems();
        }
        onCountChanged: {
            refreshItems();
        }
    }
    property QtObject appsView
    property real cellSizeMultiplier: plasmoid.configuration.cellSize / 10
    readonly property real cellSize: Kirigami.Units.gridUnit * 2.5 * cellSizeMultiplier

    property QtObject tileContainer: tileBody

    property bool dragMode: false
    property bool editMode: sidebar.visible
    property bool initialLoad: true

    function refreshItems () {
        if (!initialLoad) {
            plasmoid.configuration.tiles = JSON.stringify(serializeModel());
        }
    }

    function openEditor(widget = null, data = {}) {
        if (sidebar.currentPage)
            sidebar.currentPage.destroy();
        if (widget)
            sidebar.currentPage = widget.createObject(sidebar.content, data);
        sidebar.visible = true;
    }

    function closeEditor() {
        if (sidebar.currentPage)
            sidebar.currentPage.destroy();
        sidebar.visible = false;
    }

    signal toggled()

    Component.onCompleted: {
        initialLoad = true
        var items = JSON.parse(plasmoid.configuration.tiles);
        items.forEach((item) => {
            itemModel.append({ grid: grid, controller: root, metadata: JSON.stringify(item.metadata), plugin: item.plugin, tileWidth: item.tileWidth, tileHeight: item.tileHeight, column: item.column, row: item.row });
        });
        initialLoad = false
    }

    // Editor Sidebar
    Editor {
        id: sidebar

        anchors {
            top: root.top
            left: root.left
            bottom: root.bottom
            margins: Kirigami.Units.largeSpacing
        }
        width: root.width * 0.25 - Kirigami.Units.largeSpacing * 2

        onVisibleChanged: {
            if (visible) {
                scaleOut.restart();
            } else {
                scaleAnim.restart();
            }
        }

        onCloseClicked: root.closeEditor()
    }

    // Tile view
    Item {
        id: gridContainer
        anchors.fill: parent

        // Edit mode background
        Rectangle {
            visible: sidebar.visible
            opacity: 0.3
            anchors.fill: gridContainer
            color: Kirigami.Theme.textColor
            radius: Kirigami.Units.mediumSpacing
            z: -1
        }

        transformOrigin: Item.Right

        ScaleAnimator {
            id: scaleAnim
            from: 0.75
            to: 1
            duration: 100
            target: gridContainer
            running: false
        }

        ScaleAnimator {
            id: scaleOut
            from: 1
            to: 0.75
            duration: 100
            target: gridContainer
            running: false
        }

        ScrollView {
            id: scroll
            anchors.fill: parent
            contentWidth: grid.implicitWidth
            contentHeight: grid.implicitHeight

            function getNewIndex(): int {
                root.count += 1
                return (root.count - 1);
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
                            opacity: root.dragMode ? 0.7 : 0
                        }

                        Component.onCompleted: {
                            if (index == 1) {
                                grid.celx = rt.col
                            }
                        }
                    }
                }
            }

            Item {
                id: tileBody
                anchors.fill:grid
                Repeater {
                    model: root.itemModel
                    delegate: Tile {}
                }
            }

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                acceptedButtons: Qt.RightButton
                onClicked: function (mouse) {
                    var pos = scroll.mapToItem(grid, mouse.x, mouse.y);
                    var tilepos = scroll.mapToItem(tileBody, mouse.x, mouse.y);
                    var tile = tileBody.childAt(tilepos.x, tilepos.y);
                    var item = grid.childAt(pos.x, pos.y);
                    if (tile && tile.model.plugin) {
                        mouse.accepted = false;
                        return;
                    }
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
        for (var i=0; i < root.itemModel.count; i++) {
            var item = root.itemModel.get(i);
            if (row < (item.row + item.tileHeight)) row = item.row + item.tileHeight + 1;
            root.refreshItems()

            root.minRows = row
        }
    }

    function serializeModel() {
        var list = [];
        for (var i=0; i < root.itemModel.count; i++) {
            var item = root.itemModel.get(i);
            list.push({
                metadata: JSON.parse(item.metadata),
                plugin: item.plugin,
                tileWidth: item.tileWidth,
                tileHeight: item.tileHeight,
                column: item.column,
                row: item.row,
            });
        }
        return list;
    }

    function addTile(type: string, metadata: variant, len = 2, breadth = 2, col = 0, row = 0, index = 0) {

        itemModel.append({ grid: grid, controller: root, metadata: JSON.stringify(metadata), plugin: type, tileWidth: len, tileHeight: breadth, column: col, row: row });

        root.updateGrid();
    }

}
