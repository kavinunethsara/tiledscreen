import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import "../.."
import "../../../" as Utils

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property Tile tile

    FormCard.FormHeader {
        title: "General"
    }
    FormCard.FormCard {
        FormCard.FormTextFieldDelegate {
            label: "Name"
            placeholderText: "Name to display on tile"
            text: root.tile.tileData.name
            onTextChanged: {
                root.tile.tileData.name = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: "Width"
            value: root.tile.model.tileWidth
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileWidth = value;
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: "Height"
            value: root.tile.model.tileHeight
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileHeight = value;
            }
        }
    }

    FormCard.FormHeader {
        title: "Appearance"
    }
    FormCard.FormCard {
        FormCard.FormSwitchDelegate {
            id: customBack
            text: "Custom background"
            checked: root.tile.tileData.useCustomBack
            onCheckedChanged: {
                root.tile.tileData.useCustomBack = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormColorDelegate {
            enabled: customBack.checked
            text: "Background Color"
            color: root.tile.tileData.backColor
            onColorChanged: {
                root.tile.tileData.backColor = color.toString();
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSwitchDelegate {
            id: customFront
            text: "Custom text color"
            checked: root.tile.tileData.useCustomFront
            onCheckedChanged: {
                root.tile.tileData.useCustomFront = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: "Text Color"
            color: root.tile.tileData.frontColor
            onColorChanged: {
                root.tile.tileData.frontColor = color.toString();
                root.tile.tileData = root.tile.tileData;
            }
        }
        Utils.FormIconDelegate {
            text: "Icon"
            iconName: root.tile.tileData.icon
            onIconNameChanged: {
                root.tile.tileData.icon = iconName;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
    FormCard.FormHeader {
        title: "Actions"
    }
    FormCard.FormCard {
        FormCard.FormComboBoxDelegate {
            id: actType
            text: "Action Type"
            model: ["Desktop File", "DBus", "Shell"]
            currentIndex: root.tile.tileData.actionType
            onCurrentIndexChanged: {
                root.tile.tileData.actionType = currentIndex;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormTextFieldDelegate {
            label: (actType.currentIndex == 0) ? "File Path" : actType.currentText + " Command"
            text: root.tile.tileData.action
            onTextChanged: {
                root.tile.tileData.action = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
