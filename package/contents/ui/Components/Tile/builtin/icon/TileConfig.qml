/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import "../.."
import "../../../" as Utils

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property Tile tile

    FormCard.FormHeader {
        title: i18n("General")
    }
    FormCard.FormCard {
        FormCard.FormTextFieldDelegate {
            label: i18n("Name")
            placeholderText: i18n("Name to display on tile")
            text: root.tile.config.name
            onTextChanged: {
                root.tile.config.name = text
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: i18n("Width")
            value: root.tile.config.width
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.config.width = value;
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: i18n("Height")
            value: root.tile.config.height
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.config.height = value;
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
            checked: root.tile.config.useCustomBack
            onCheckedChanged: {
                root.tile.config.useCustomBack = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customBack.checked
            text: i18n("Background Color")
            color: root.tile.config.backColor
            onColorChanged: {
                root.tile.config.backColor = color.toString()
            }
        }
        FormCard.FormSwitchDelegate {
            id: customFront
            text: i18n("Custom text color")
            checked: root.tile.config.useCustomFront
            onCheckedChanged: {
                root.tile.config.useCustomFront = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: i18n("Text Color")
            color: root.tile.config.frontColor
            onColorChanged: {
                root.tile.config.frontColor = color.toString()
            }
        }
        Utils.FormIconDelegate {
            text: i18n("Icon")
            iconName: root.tile.config.icon
            onIconNameChanged: {
                root.tile.config.icon = iconName
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
            currentIndex: root.tile.config.actionType
            onCurrentIndexChanged: {
                root.tile.config.actionType = currentIndex
            }
        }
        FormCard.FormTextFieldDelegate {
            label: (actType.currentIndex == 0) ? i18n("File Path") : i18n("%1 Command", actType.currentText)
            text: root.tile.config.action
            onTextChanged: {
                root.tile.config.action = text
            }
        }
    }
}
