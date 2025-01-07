import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami

pragma ComponentBehavior: Bound

Kirigami.Dialog {
    id: root
    title: "Tiles"

    required property var tiles
    required property var controller
    property point position: Qt.point(0, 0)

    Item {
        id: container
        // hints for the dialog dimensions
        implicitWidth: Kirigami.Units.gridUnit * 20 + Kirigami.Units.mediumSpacing * 4 + Kirigami.Units.largeSpacing * 2
        implicitHeight: Kirigami.Units.gridUnit * 16 + Kirigami.Units.largeSpacing * 2

        GridView {
            id: listView
            anchors.fill: parent
            anchors.margins: Kirigami.Units.largeSpacing

            cellWidth: Kirigami.Units.gridUnit * 10 + Kirigami.Units.mediumSpacing * 2
            cellHeight: Kirigami.Units.gridUnit * 4 + Kirigami.Units.mediumSpacing * 2

            highlight: Rectangle { radius: 5; color: Kirigami.Theme.highlightColor }

            model: root.tiles

            delegate: Item {
                id: del
                required property var model
                required property int index

                width: Kirigami.Units.gridUnit * 10 + Kirigami.Units.mediumSpacing * 2
                height: Kirigami.Units.gridUnit * 4 + Kirigami.Units.mediumSpacing * 2

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.mediumSpacing

                    Kirigami.Icon {
                        source: del.model.icon
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter

                        Layout.margins: Kirigami.Units.mediumSpacing
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.margins: Kirigami.Units.mediumSpacing
                        Label {
                            text: del.model.name
                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignLeft
                            elide: Qt.ElideRight
                            color: listView.currentIndex == del.index ? Kirigami.Theme.highlightedTextColor: Kirigami.Theme.textColor
                        }
                        Label {
                            text: del.model.description
                            Layout.fillWidth: true
                            horizontalAlignment: Qt.AlignLeft
                            wrapMode:Text.WordWrap
                            elide: Qt.ElideRight
                            color: listView.currentIndex == del.index ? Kirigami.Theme.highlightedTextColor: Kirigami.Theme.textColor
                        }
                    }
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
