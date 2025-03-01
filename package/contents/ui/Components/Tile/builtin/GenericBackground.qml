/*
 * SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import ".."

Rectangle {
    id: root
    anchors.fill: parent
    anchors.margins: Kirigami.Units.smallSpacing

    required property var metadata
    required property Tile container

    color: root.metadata.useCustomBack? root.metadata.backColor : Kirigami.Theme.backgroundColor
    radius: root.metadata.rounded ? Kirigami.Units.mediumSpacing : 0
}
