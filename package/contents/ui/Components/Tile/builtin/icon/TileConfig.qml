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
            text: root.tile.tileData.name
            onTextChanged: {
                root.tile.tileData.name = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: i18n("Width")
            value: root.tile.model.tileWidth
            from: 1
            to: 100
            stepSize: 1
            onValueChanged: {
                root.tile.model.tileWidth = value;
            }
        }
        FormCard.FormSpinBoxDelegate {
            label: i18n("Height")
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
        title: i18n("Appearance")
    }
    FormCard.FormCard {
        FormCard.FormSwitchDelegate {
            id: customBack
            text: i18n("Custom background")
            checked: root.tile.tileData.useCustomBack
            onCheckedChanged: {
                root.tile.tileData.useCustomBack = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormColorDelegate {
            enabled: customBack.checked
            text: i18n("Background Color")
            color: root.tile.tileData.backColor
            onColorChanged: {
                root.tile.tileData.backColor = color.toString();
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormSwitchDelegate {
            id: customFront
            text: i18n("Custom text color")
            checked: root.tile.tileData.useCustomFront
            onCheckedChanged: {
                root.tile.tileData.useCustomFront = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: i18n("Text Color")
            color: root.tile.tileData.frontColor
            onColorChanged: {
                root.tile.tileData.frontColor = color.toString();
                root.tile.tileData = root.tile.tileData;
            }
        }
        Utils.FormIconDelegate {
            text: i18n("Icon")
            iconName: root.tile.tileData.icon
            onIconNameChanged: {
                root.tile.tileData.icon = iconName;
                root.tile.tileData = root.tile.tileData;
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
            model: [i18n("Desktop File"), i18n("Shell")]
            currentIndex: root.tile.tileData.actionType
            onCurrentIndexChanged: {
                root.tile.tileData.actionType = currentIndex;
                root.tile.tileData = root.tile.tileData;
            }
        }
        FormCard.FormTextFieldDelegate {
            label: (actType.currentIndex == 0) ? i18n("File Path") : actType.currentText + i18n(" Command")
            text: root.tile.tileData.action
            onTextChanged: {
                root.tile.tileData.action = text;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
