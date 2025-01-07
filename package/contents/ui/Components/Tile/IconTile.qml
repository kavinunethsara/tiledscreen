import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    property string name: ""
    property string icon: ""

    Kirigami.ImageColors {
        id: imageColor
        source: root.icon
    }

    color: imageColor.background || "transparent"

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

        color: imageColor.foreground || Kirigami.Theme.textColor
    }
}
