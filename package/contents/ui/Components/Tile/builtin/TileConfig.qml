import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.platform
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

    Switch {
        id: customBack
        text: "Custom background"
        checked: root.tile.tileData.useCustomBack
        onCheckedChanged: {
            root.tile.tileData.useCustomBack = checked;
            root.tile.tileData = root.tile.tileData;
        }
    }

    ConfigEntry {
        label: "Background color"
        Button {
            text: "Select"
            enabled: customBack.checked
            onClicked: {
                backColorDialog.open()
            }
        }
    }

    ColorDialog {
        id: backColorDialog
        currentColor: root.tile.tileData.backColor
        onCurrentColorChanged: {
            root.tile.tileData.backColor = currentColor;
            root.tile.tileData = root.tile.tileData;
        }
    }

    Switch {
        id: customFront
        text: "Custom text color"
        checked: root.tile.tileData.useCustomFront
        onCheckedChanged: {
            root.tile.tileData.useCustomFront = checked;
            root.tile.tileData = root.tile.tileData;
        }
    }

    ConfigEntry {
        label: "Text color"
        Button {
            text: "Select"
            enabled: customFront.checked
            onClicked: {
                textColorDialog.open()
            }
        }
    }

    ColorDialog {
        id: textColorDialog
        currentColor: root.tile.tileData.frontColor
        onCurrentColorChanged: {
            root.tile.tileData.frontColor = currentColor;
            root.tile.tileData = root.tile.tileData;
        }
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

    Label {
        text: "Actions"
    }

    ConfigEntry{
        label: "Action type"
        ComboBox{
            id: actType
            model: ["Desktop File", "DBus", "Shell"]
            currentIndex: root.tile.tileData.actionType
            onCurrentIndexChanged: {
                root.tile.tileData.actionType = currentIndex;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }

    ConfigEntry{
        label: (actType.currentIndex == 0) ? "File Path" : actType.currentText + " Command"
        TextField {
            text: root.tile.tileData.action
            onTextChanged: {
                root.tile.tileData.action = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
