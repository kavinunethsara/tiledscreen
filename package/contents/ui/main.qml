/*
    SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root
    switchHeight: Kirigami.Units.gridUnit * 3
    switchWidth: Kirigami.Units.gridUnit * 3
    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation{
        plasmoidRoot: root
    }
    fullRepresentation: FullRepresentation{
        id: fullRep
        kicker: KickerModel{
            onUpdated: {
                fullRep.update()
            }
        }
    }
}
