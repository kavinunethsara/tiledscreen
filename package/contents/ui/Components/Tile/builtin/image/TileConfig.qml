import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import "../.."

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property Tile tile

    FormCard.FormHeader {
        title: "General"
    }
    FormCard.FormCard {
        FormCard.FormTextFieldDelegate {
            label: "Text"
            placeholderText: "Text to display on tile"
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
        FormCard.FormTextFieldDelegate {
            label: "Image Path"
            placeholderText: "Path to the image"
            text: root.tile.tileData.image
            onTextChanged: {
                root.tile.tileData.image = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormComboBoxDelegate {
            text: "Scaling Mode"
            model:["Stretch", "Crop and Fit", "Fit Inside", "No scaling"]
            currentIndex: root.tile.tileData.mode
            onCurrentIndexChanged: {
                root.tile.tileData.mode = currentIndex;
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
    }
}
