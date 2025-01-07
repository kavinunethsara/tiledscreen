import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
//import 'scripts/util.js' as Util

pragma ComponentBehavior: Bound

FocusScope {
    id: root

    property bool small: false
    clip: true

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.margins: Kirigami.Units.largeSpacing

    property alias delegate: list.delegate
    property alias model: list.model
    property alias mouseActive: list.mouseActive
    readonly property int itemWidth: root.width / Math.round(root.width / (Kirigami.Units.gridUnit * 12))
    focus: true

    GridView {
        id: list
        anchors.fill: parent
        property bool mouseActive: true
        cellWidth: root.itemWidth
        cellHeight: Kirigami.Units.gridUnit * 2 + Kirigami.Units.largeSpacing * 4
        focus: true
        clip: true
        highlight: Rectangle {
            color: Kirigami.Theme.highlightColor
            radius: Kirigami.Units.largeSpacing
            opacity: 0.7
        }
        highlightMoveDuration: 0
        delegate: AppDelegate{ small: root.small; itemWidth: root.itemWidth }
    }

    MouseArea {
        anchors.fill: parent
        propagateComposedEvents: true
        hoverEnabled: true
        onPositionChanged: function(mouse) {
            let pos = list.contentItem.mapFromItem(root, mouse.x, mouse.y)
            list.currentIndex = list.indexAt(pos.x, pos.y)
            root.forceActiveFocus()
        }
    }
}
