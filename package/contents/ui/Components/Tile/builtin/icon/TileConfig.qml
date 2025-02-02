/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import "../../../" as Utils

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
}
