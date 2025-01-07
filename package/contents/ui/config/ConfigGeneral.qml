/*
 S *PDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick

import org.kde.kcmutils as KCM
import org.kde.kirigamiaddons.formcard as FormCard

KCM.SimpleKCM {
    id: root
    property var cfg_icon
    property var cfg_useExtraRunners
    property var cfg_extraRunners

    FormCard.FormCardPage {
        FormCard.FormHeader {
            title: "General"
        }
        FormCard.FormCard {
            FormCard.FormTextFieldDelegate {
                label: "Icon"
                text: root.cfg_icon
            }
        }

        FormCard.FormHeader {
            title: "Search"
        }
        FormCard.FormCard {
            FormCard.FormCheckDelegate {
                text: "Use extra search plugins"
                checked: root.cfg_extraRunners
            }
        }
    }
}
