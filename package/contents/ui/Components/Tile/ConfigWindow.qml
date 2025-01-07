import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard


FormCard.FormCardDialog {
    id: root
    title: "Edit Tile"
    required property variant tile

    FormCard.FormHeader {
        title: "General"
    }

    FormCard.FormTextFieldDelegate {
        label: "Name"
        placeholderText: "Name to display on tile"
        text: root.tile.internalTile.name
        onTextChanged: {
            root.tile.internalTile.name = text;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Width"
        value: root.tile.len
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.len = value;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Height"
        value: root.tile.breadth
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.breadth = value;
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
            checked: root.tile.internalTile.useCustomBack
            onCheckedChanged: {
                root.tile.internalTile.useCustomBack = checked
            }
        }

        FormCard.FormColorDelegate {
            enabled: customBack.checked
            text: "Background color"
            color: root.tile.internalTile.backColor
            onColorChanged: {
                root.tile.internalTile.backColor = color
            }
        }

        FormCard.FormSwitchDelegate {
            id: customFront
            text: "Custom text color"
            checked: root.tile.internalTile.useCustomFront
            onCheckedChanged: {
                root.tile.internalTile.useCustomFront = checked
            }
        }

        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: "Text color"
            color: root.tile.internalTile.frontColor
            onColorChanged: {
                root.tile.internalTile.frontColor = color
            }
        }

        FormIconDelegate {
            iconName: root.tile.internalTile.icon
            onIconNameChanged: {
                root.tile.internalTile.icon = iconName
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
            currentIndex: root.tile.internalTile.actionType
            onCurrentIndexChanged: {
                root.tile.internalTile.actionType = currentIndex
            }
        }

        FormCard.FormTextFieldDelegate {
            label: (actType.currentIndex == 0) ? "File Path" : actType.currentText + " Command"
            text: root.tile.internalTile.action
            onTextChanged: {
                root.tile.internalTile.action = text
            }
        }
    }
}
