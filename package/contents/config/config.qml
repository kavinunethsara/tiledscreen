/*
    SPDX-FileCopyrightText: 2014 Eike Hein <hein@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
         name: i18n("General")
         icon: "preferences-desktop-plasma"
         source: "config/ConfigGeneral.qml"
    }

    ConfigCategory {
        name: i18n("Appearance")
        icon: "preferences-color"
        source: "config/ConfigAppearance.qml"
    }
}
