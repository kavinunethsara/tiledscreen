import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
Item {
    id: root
    required property string name
    required property string icon

    Layout.fillWidth: true
    Layout.preferredHeight: content.implicitHeight
    Rectangle{
        anchors.fill: parent
        color: Kirigami.Theme.highlightColor
        radius: Kirigami.Units.smallSpacing
        opacity: mouseArea.containsMouse ? 0.4 : 0
        z: 0
    }

    RowLayout {
        id: content
        z: 1
        Kirigami.Icon {
            id: icon
            Layout.margins: Kirigami.Units.mediumSpacing
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            Layout.preferredWidth: Kirigami.Units.gridUnit
            source: root.icon
        }
        PlasmaComponents.Label {
            Layout.fillWidth: true
            Layout.margins: Kirigami.Units.mediumSpacing
            Layout.topMargin: 0
            Layout.bottomMargin: 0
            text: root.name
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
