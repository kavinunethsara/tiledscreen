/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import "../../../" as Utils
import QtQuick.Dialogs as Dialogs
import QtCore

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property variant config

    FormCard.FormHeader {
        title: i18n("General")
    }
    FormCard.FormCard {
        FormCard.FormTextFieldDelegate {
            id: tet
            label: i18n("Name")
            placeholderText: i18n("Name to display on tile")
            text: config.name
            onTextChanged: {
                config.name = text
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: i18n("Width")
            value: config.width
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                config.width = value
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: i18n("Height")
            value: config.height
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                config.height = value
            }
        }
    }

    FormCard.FormHeader {
        title: i18n("Appearance")
    }
    FormCard.FormCard {
        FormCard.FormSwitchDelegate {
            text: i18n("Show icon")
            checked: config.showIcon
            onCheckedChanged: {
                config.showIcon = checked
            }
        }

        FormCard.FormSwitchDelegate {
            id: customBack
            text: i18n("Custom background")
            checked: config.useCustomBack
            onCheckedChanged: {
                config.useCustomBack = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customBack.checked
            text: i18n("Background Color")
            color: config.backColor
            onColorChanged: {
                config.backColor = color.toString()
            }
        }
        FormCard.FormSwitchDelegate {
            id: customFront
            text: i18n("Custom text color")
            checked: config.useCustomFront
            onCheckedChanged: {
                config.useCustomFront = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: i18n("Text Color")
            color: config.frontColor
            onColorChanged: {
                config.frontColor = color.toString()
            }
        }
        Utils.FormIconDelegate {
            text: i18n("Icon")
            iconName: config.icon
            onIconNameChanged: {
                config.icon = iconName
            }
        }
    }
    FormCard.FormHeader {
        title: i18n("Actions")
    }
    FormCard.FormCard {
        FormCard.FormComboBoxDelegate {
            id: actType
            text: i18n("Action Type")
            model: [i18n("Desktop File"), i18n("Command Line")]
            currentIndex: config.actionType
            onCurrentIndexChanged: {
                config.actionType = currentIndex
            }
        }
        FormCard.FormTextFieldDelegate {
            label: (actType.currentIndex == 0) ? i18n("File Path") : i18n("%1 Command", actType.currentText)
            text: config.action
            onTextChanged: {
                config.action = text
            }
        }
    }

    FormCard.FormHeader {
        title: i18n("Background Image")
    }

    FormCard.FormCard {
        FormCard.FormSwitchDelegate {
            id: imageBack
            text: i18n("Background Image")
            checked: config.useBackgroundImage
            onCheckedChanged: {
                config.useBackgroundImage = checked
            }
        }
        FormCard.FormTextFieldDelegate {
            id: imagePath
            enabled: imageBack.checked
            label: "Image Path"
            placeholderText: "Path to the image"
            text: config.backgroundImage
            onTextChanged: {
                config.backgroundImage = text
            }
        }
        FormCard.FormButtonDelegate {
            id: imageSelector
            enabled: imageBack.checked
            text: "Select Image"
            onClicked: imageDialog.open()
        }
        Dialogs.FileDialog {
            id: imageDialog
            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            onAccepted: {
                imagePath.text = selectedFile.toString()
            }
        }
        FormCard.FormComboBoxDelegate {
            text: "Background Scaling Mode"
            enabled: imageBack.checked
            model:["Stretch", "Crop and Fit", "Fit Inside", "No scaling"]
            currentIndex: config.imageMode
            onCurrentIndexChanged: {
                config.imageMode = currentIndex
            }
        }
    }
}
