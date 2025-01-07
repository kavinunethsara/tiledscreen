/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick

import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.kirigamiaddons.formcard as FormCard

KCM.SimpleKCM {
    id: root
    property alias cfg_icon: icon.text
    property alias cfg_cellSize: cellSize.value
    property string cfg_tiles
    property string cfg_tilesDefault

    FormCard.FormCardPage {
        FormCard.FormHeader {
            title: "Icon"
        }
        FormCard.FormCard {
            FormCard.AbstractFormDelegate {
                contentItem: Kirigami.Icon {
                    id: buttonIcon
                    height: Kirigami.Units.gridUnit * 3
                    anchors.fill: parent
                    source: icon.text
                    smooth: true
                }
            }
            FormCard.FormDelegateSeparator {}
            FormCard.FormTextFieldDelegate {
                id: icon
                label: "Icon Name"
            }
            FormCard.FormButtonDelegate {
                text: "Select Icon"
            }
            FormCard.FormButtonDelegate {
                text: "Reset Icon"
                onClicked: {
                    icon.text = "start-here-kde-symbolic"
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
