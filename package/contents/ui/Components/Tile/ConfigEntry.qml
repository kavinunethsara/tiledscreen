import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: root
    required property string label
    default property alias content: inner.children

    Layout.fillWidth: true

    Label {
        text: root.label
        verticalAlignment: Qt.AlignVCenter
        Layout.alignment: Qt.AlignVCenter
    }
    RowLayout {
        id: inner
        Layout.fillWidth: true
    }
}
