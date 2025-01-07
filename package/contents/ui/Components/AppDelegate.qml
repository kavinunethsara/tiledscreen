import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
Item {
    id: root
    required property variant model
    required property variant list
    property bool small: false
    property double listWidth: list.width
    height: content.implicitHeight
    width: listWidth

    RowLayout {
        id: content
        Layout.fillWidth: true
        Kirigami.Icon {
            id: icon
            Layout.margins: root.small ? Kirigami.Units.mediumSpacing : Kirigami.Units.largeSpacing
            Layout.preferredWidth: root.small ? Kirigami.Units.gridUnit : undefined
            source: root.model.decoration
        }
        PlasmaComponents.Label {
            Layout.fillWidth: true
            Layout.maximumWidth: root.listWidth - 4 * (root.small ? Kirigami.Units.mediumSpacing : Kirigami.Units.largeSpacing) - icon.implicitWidth
            Layout.margins: root.small ? Kirigami.Units.mediumSpacing : Kirigami.Units.largeSpacing
            text: root.model.display
            elide: Qt.ElideRight
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: root.trigger()
    }

    Keys.onPressed: event => {
        if ((event.key === Qt.Key_Enter || event.key === Qt.Key_Return)) {
            event.accepted = true
            root.trigger()
        }
    }

    function trigger() {
        if ("trigger" in root.list.model) {
            root.list.model.trigger(root.model.index, "", null)
            root.toggle()
        }
    }
}
