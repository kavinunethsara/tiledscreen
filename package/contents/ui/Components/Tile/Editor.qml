import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Rectangle {
    id: sidebar
    z: 10
    radius: Kirigami.Units.mediumSpacing
    border.width: 1
    border.color: Kirigami.Theme.backgroundColor.darker(1.5)
    color: Kirigami.Theme.backgroundColor

    property QtObject content: editor.contentItem.contentItem
    property var currentPage

    signal closeClicked

    visible: false

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.mediumSpacing
        Button {
            text: "Close"
            onClicked: sidebar.closeClicked()
        }

        ScrollView {
            id: editor
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
