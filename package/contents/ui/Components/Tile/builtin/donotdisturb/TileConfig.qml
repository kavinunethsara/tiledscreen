/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import "../../../" as Utils
import QtQuick.Dialogs as Dialogs
import QtCore

FormCard.FormCardPage {
    id: root
    anchors.fill: parent
    required property variant config

    FormCard.FormHeader {
        title: i18n("General")
    }
    FormCard.FormCard {
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
            text: i18n("Show Label")
            checked: config.showLabel
            onCheckedChanged: {
                config.showLabel = checked
            }
        }

        FormCard.FormSwitchDelegate {
            text: i18n("Rounded corners")
            checked: config.rounded
            onCheckedChanged: {
                config.rounded = checked
            }
        }

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
            text: i18n("Custom icon color")
            checked: config.useCustomFront
            onCheckedChanged: {
                config.useCustomFront = checked
            }
        }
        FormCard.FormColorDelegate {
            enabled: customFront.checked
            text: i18n("Icon Color")
            color: config.frontColor
            onColorChanged: {
                config.frontColor = color.toString()
            }
        }
    }
}
