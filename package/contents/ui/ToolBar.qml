/*
 * SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

RowLayout {
    PlasmaComponents.TextField {
        Layout.maximumWidth: Kirigami.Units.gridUnit * 20
        Layout.fillWidth: true
        id: search
        placeholderText: "Search..."
    }
}
