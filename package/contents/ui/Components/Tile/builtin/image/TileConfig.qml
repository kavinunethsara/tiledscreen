/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtCore
import org.kde.kirigamiaddons.formcard as FormCard
import QtQuick.Dialogs as Dialogs
import "../.."

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property variant config

    FormCard.FormHeader {
        title: "General"
    }
    FormCard.FormCard {
        FormCard.FormTextFieldDelegate {
            label: "Text"
            placeholderText: "Text to display on tile"
            text: config.name
            onTextChanged: {
                config.name = text
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: "Width"
            value: config.width
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                config.widthidth = value
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: "Height"
            value: config.height
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                config.height = value
            }
        }
        FormCard.FormTextFieldDelegate {
            label: "Image Path"
            placeholderText: "Path to the image"
            text: config.image
            onTextChanged: {
                config.image = text
            }
        }
        FormCard.FormButtonDelegate {
            id: imageSelector
            text: "Select Image"
            onClicked: imagePath.open()
        }
        Dialogs.FileDialog {
            id: imagePath
            currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        }
        FormCard.FormComboBoxDelegate {
            text: "Scaling Mode"
            model:["Stretch", "Crop and Fit", "Fit Inside", "No scaling"]
            currentIndex: config.mode
            onCurrentIndexChanged: {
                config.mode = currentIndex
            }
        }
        FormCard.FormSwitchDelegate {
            id: customFront
            text: "Custom text color"
            checked: config.useCustomFront
            onCheckedChanged: {
                config.useCustomFront = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: "Text Color"
            color: config.frontColor
            onColorChanged: {
                config.frontColor = color.toString()
            }
        }
    }
}
