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
        title: i18n("Grouping")
    }
    FormCard.FormCard {
        FormCard.FormSwitchDelegate {
            text: i18n("Enable tile grouping")
            description: i18n("When enabled, tiles positioned directly below will be attached to this tile.")
            checked: root.tile.tileData.grouping
            onCheckedChanged: {
                root.tile.tileData.grouping = checked;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }
}
