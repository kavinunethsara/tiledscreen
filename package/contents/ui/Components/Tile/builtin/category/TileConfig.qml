/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import org.kde.kirigami as Kirigami
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
        Utils.FormIconDelegate {
            text: "Icon"
            iconName: root.tile.tileData.icon
            onIconNameChanged: {
                root.tile.tileData.icon = iconName;
                root.tile.tileData = root.tile.tileData;
            }
        }
    }

}
