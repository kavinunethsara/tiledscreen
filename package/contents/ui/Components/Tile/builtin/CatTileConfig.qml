import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami
import ".."

ColumnLayout {
    id: root
    anchors.fill: parent
    spacing: Kirigami.Units.mediumSpacing
    required property Tile tile

    Label {
        text: "General"
    }

    ConfigEntry {
        label: "Name"
        TextField {
            placeholderText: "Name to display on tile"
            text: root.tile.tileData.name
            onTextChanged: {
                root.tile.tileData.name = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }

    ConfigEntry{
        label: "Width"
        SpinBox {
            value: root.tile.model.tileWidth
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileWidth = value;
            }
        }
    }

    ConfigEntry{
        label: "Height"
        SpinBox {
            value: root.tile.model.tileHeight
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileHeight = value;
            }
        }
    }


    Label {
        text: "Appearance"
    }

    ConfigEntry {
        label: "Icon "
        IconSelector {
            text: "Select"
            icon.name: root.tile.tileData.icon
            onIconChanged: {
                root.tile.tileData.icon = icon.name;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
