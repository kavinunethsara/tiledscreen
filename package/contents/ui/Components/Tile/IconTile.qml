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
    property bool useCustomBack: metadata.useCustomBack
    property bool useCustomFront: metadata.useCustomFront
    property color backColor: metadata.backColor
    property color frontColor: metadata.frontColor
    property int actionType: metadata.actionType
    property string action: metadata.action

    readonly property string config: "TileConfig"

    required property QtObject container

    onNameChanged: {
        updateMeta()
    }
    onIconChanged: {
        updateMeta()
    }
    onUseCustomBackChanged: {
        updateMeta()
    }
    onUseCustomFrontChanged: {
        updateMeta()
    }
    onBackColorChanged: {
        updateMeta()
    }
    onFrontColorChanged: {
        updateMeta();
    }
    onActionTypeChanged: {
        updateMeta();
    }
    onActionChanged: {
        updateMeta();
    }

    function updateMeta() {
        metadata.name = root.name
        metadata.icon = root.icon
        metadata.useCustomBack = root.useCustomBack
        metadata.useCustomFront = root.useCustomFront
        metadata.backColor = root.backColor
        metadata.frontColor = root.frontColor
        metadata.actionType =  root.actionType
        metadata.action =  root.action

        root.update()
    }

    Component.onCompleted: {
        if (!root.useCustomBack) {
            root.backColor = imageColor.background
        }
        if (!root.useCustomFront) {
            root.frontColor = imageColor.foreground
        }
    }

    Kirigami.ImageColors {
        id: imageColor
        source: root.icon
    }

    color: useCustomBack? backColor : imageColor.background

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
            source: root.icon
        }

    }

    PlasmaComponents.Label {
        id: textLabel
        text: name
        horizontalAlignment: Qt.AlignHCenter

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Kirigami.Units.smallSpacing
        elide: Qt.ElideRight

        color: root.useCustomFront? root.frontColor : imageColor.foreground
    }
}
