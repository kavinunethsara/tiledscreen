/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
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

    FormCard.FormComboBoxDelegate {
        text: i18n("Text Align")
        model: [i18n("Left"), i18n("Center"), i18n("Right")]
        currentIndex: config.alignment
        onCurrentIndexChanged: {
            config.alignment = currentIndex
        }
    }

    FormCard.FormCard {
        Utils.FormIconDelegate {
            text: i18n("Icon")
            iconName: config.icon
            onIconNameChanged: {
                config.icon = iconName
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
            checked: config.grouping
            onCheckedChanged: {
                config.grouping = checked
            }
        }
    }
}
