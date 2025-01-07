import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import ".."

FormCard.FormCardDialog {
    id: root
    title: "Edit Tile"
    required property Tile tile

    FormCard.FormHeader {
        title: "General"
    }

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
        value: root.tile.tileWidth
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.tileWidth = value;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Height"
        value: root.tile.tileHeight
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.tileHeight = value;
        }
    }

    FormCard.FormDelegateSeparator {}


    FormCard.FormButtonDelegate {
        text: "Appearance Settings"
        onClicked: {
            appearanceDialog.open()
        }
    }

    FormCard.FormButtonDelegate {
        text: "Action Settings"
        onClicked: {
            actionDialog.open()
        }
    }

    FormCard.FormCardDialog {
        id: appearanceDialog
        title: "Appearance"

        FormCard.FormSwitchDelegate {
            id: customBack
            text: "Custom background"
            checked: root.tile.tileData.useCustomBack
            onCheckedChanged: {
                root.tile.tileData.useCustomBack = checked
                root.tile.tileData = root.tile.tileData;
            }
        }

        FormCard.FormColorDelegate {
            enabled: customBack.checked
            text: "Background color"
            color: root.tile.tileData.backColor
            onColorChanged: {
                root.tile.tileData.backColor = color
                root.tile.tileData = root.tile.tileData;
            }
        }

        FormCard.FormSwitchDelegate {
            id: customFront
            text: "Custom text color"
            checked: root.tile.tileData.useCustomFront
            onCheckedChanged: {
                root.tile.tileData.useCustomFront = checked
                root.tile.tileData = root.tile.tileData;
            }
        }

        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: "Text color"
            color: root.tile.tileData.frontColor
            onColorChanged: {
                root.tile.tileData.frontColor = color
                root.tile.tileData = root.tile.tileData;
            }
        }

        FormIconDelegate {
            iconName: root.tile.tileData.icon
            onIconNameChanged: {
                root.tile.tileData.icon = iconName
                root.tile.tileData = root.tile.tileData;
            }
        }
    }


    FormCard.FormCardDialog {
        id: actionDialog
        title: "Action"

        FormCard.FormComboBoxDelegate {
            id: actType
            text: "Action type"
            model:[
                "Desktop File",
                "DBus",
                "Shell"
            ]
            currentIndex: root.tile.tileData.actionType
            onCurrentIndexChanged: {
                root.tile.tileData.actionType = currentIndex
                root.tile.tileData = root.tile.tileData;
            }
        }

        FormCard.FormTextFieldDelegate {
            label: (actType.currentIndex == 0) ? "File Path" : actType.currentText + " Command"
            text: root.tile.tileData.action
            onTextChanged: {
                root.tile.tileData.action = text
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
