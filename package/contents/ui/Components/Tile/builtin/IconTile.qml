import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import ".."

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    required property var metadata

    readonly property string config: "TileConfig"

    required property Tile container

    function activate() {
        container.controller.appsView.runApp(root.metadata.action);
    }

    Component.onCompleted: {
        if (!root.metadata.useCustomBack) {
            root.metadata.backColor = imageColor.background
        }
        if (!root.useCustomFront) {
            root.metadata.frontColor = imageColor.foreground
        }
    }

    Kirigami.ImageColors {
        id: imageColor
        source: root.metadata.icon
    }

    color: root.metadata.useCustomBack? root.metadata.backColor : imageColor.background

    Item {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: textLabel.top
        }
        Kirigami.Icon {
            anchors.centerIn: parent
            width: parent.width * 0.75
            source: root.metadata.icon
        }

    }

    PlasmaComponents.Label {
        id: textLabel
        text: root.metadata.name
        horizontalAlignment: Qt.AlignHCenter

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Kirigami.Units.smallSpacing
        elide: Qt.ElideRight

        color: root.metadata.useCustomFront? root.metadata.frontColor : imageColor.foreground
    }
}
