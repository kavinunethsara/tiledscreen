import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
//import 'scripts/util.js' as Util

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
    focus: true

    ListView {
        id: list
        anchors.fill: parent
        property bool mouseActive: true
        focus: true
        clip: true
        highlight: Rectangle {
            color: Kirigami.Theme.highlightColor
            radius: Kirigami.Units.largeSpacing
            opacity: 0.7
        }
        highlightMoveDuration: 0
        delegate: AppDelegate{ list: ListView.view; small: root.small }
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
