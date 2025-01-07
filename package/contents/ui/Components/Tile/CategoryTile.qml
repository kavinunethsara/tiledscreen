import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    required property variant metadata

    signal update

    property string name: metadata.name
    property string icon: metadata.icon

    readonly property string config: "CatTileConfig"

    required property QtObject container

    onNameChanged: {
        updateMeta()
    }
    onIconChanged: {
        updateMeta()
    }

    function updateMeta() {
        metadata.name = root.name
        metadata.icon = root.icon

        root.update()
    }

    color: "transparent"

    Item {
        id: iconContainer
        visible: root.icon != ""
        width: root.icon == ""? 0 : iconItem.implicitWidth
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        Kirigami.Icon {
            id: iconItem
            anchors.centerIn: parent
            height: parent.height * 0.75
            width: height
            source: root.icon
        }

    }

    PlasmaComponents.Label {
        id: textLabel
        text: root.name
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        anchors.left: iconContainer.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.margins: Kirigami.Units.smallSpacing
        elide: Qt.ElideRight


        color: Kirigami.Theme.textColor
    }
}
