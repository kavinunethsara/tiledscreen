/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
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
            title: i18n("Icon")
        }
        FormCard.FormCard {
            Utils.FormIconDelegate {
                id: icon
                text: i18n("Icon")
            }

            FormCard.FormDelegateSeparator {}
            FormCard.FormButtonDelegate {
                text: i18n("Reset Icon")
                onClicked: {
                    icon.iconName = "start-here-kde-symbolic"
                }
            }
        }

        FormCard.FormHeader {
            title: i18n("Tiles")
        }
        FormCard.FormCard {
            FormCard.FormSpinBoxDelegate {
                id: cellSize
                label: i18n("Tile size")
                from: 0
                to: 40
                stepSize: 2
            }
            FormCard.FormButtonDelegate {
                text: i18n("Reset tiles")
                onClicked: {
                    root.cfg_tiles = root.cfg_tilesDefault
                    infoDial.open()
                }

                Kirigami.Dialog {
                    id: infoDial
                    title: i18n("Requires Re-Login")
                    RowLayout {
                        Layout.margins: Kirigami.Units.smallSpacing
                        Kirigami.Icon {
                            source: "dialog-warning-symbolic"
                            Layout.margins: Kirigami.Units.smallSpacing
                        }
                        Controls.Label {
                            id: dialLabel
                            text: "You need to log out and log back in for this to take effect."
                            Layout.margins: Kirigami.Units.smallSpacing
                        }
                    }
                }
            }
        }
    }
}
