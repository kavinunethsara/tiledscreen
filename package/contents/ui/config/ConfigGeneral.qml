/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick

import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard
import "../Components" as Utils

KCM.SimpleKCM {
    id: root
    property alias cfg_icon: icon.iconName
    property alias cfg_cellSize: cellSize.value
    property string cfg_tiles
    property string cfg_tilesDefault

    FormCard.FormCardPage {
        FormCard.FormHeader {
            title: "Icon"
        }
        FormCard.FormCard {
            Utils.FormIconDelegate {
                id: icon
                text: "Icon"
            }

            FormCard.FormDelegateSeparator {}
            FormCard.FormButtonDelegate {
                text: "Reset Icon"
                onClicked: {
                    icon.iconName = "start-here-kde-symbolic"
                }
            }
        }

        FormCard.FormHeader {
            title: "Tiles"
        }
        FormCard.FormCard {
            FormCard.FormSpinBoxDelegate {
                id: cellSize
                label: "Tile size"
                from: 0
                to: 40
                stepSize: 2
            }
            FormCard.FormButtonDelegate {
                text: "Reset tiles"
                onClicked: {
                    root.cfg_tiles = root.cfg_tilesDefault
                }
            }
        }
    }
}
