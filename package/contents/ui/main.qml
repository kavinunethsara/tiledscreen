/*
    SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
    SPDX-License-Identifier: LGPL-2.1-or-later
    */
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.kicker as Kicker

PlasmoidItem {
    id: kicker
    switchHeight: 0
    switchWidth: 0
    preferredRepresentation: fullRepresentation
    compactRepresentation: null
    fullRepresentation: compactRepresentationComponent

    signal reset

    Component {
        id: compactRepresentationComponent
        CompactRepresentation {}
    }

    Kicker.RootModel {
        id: rootModel

        autoPopulate: false

        flat: true
        // TODO: appletInterface property now can be ported to "applet" and have the real Applet* assigned directly
        //appletInterface: kicker

        showAllApps: true
        showAllAppsCategorized: false
        showTopLevelItems: false
        showRecentApps: false
        showRecentDocs: false
        showFavoritesPlaceholder: false

        Component.onCompleted: {
            favoritesModel.initForClient("whjjackwhite.tiledscreen.favorites.instance-" + Plasmoid.id)

            if (!Plasmoid.configuration.favoritesPortedToKAstats) {
                if (favoritesModel.count < 1) {
                    favoritesModel.portOldFavorites(Plasmoid.configuration.favoriteApps);
                }
                Plasmoid.configuration.favoritesPortedToKAstats = true;
            }

            rootModel.refresh();
        }
    }

    Kicker.WindowSystem {
        id: windowSystem
    }

    Connections {
        target: kicker

        function onExpandedChanged(expanded) {
            if (expanded) {
                windowSystem.monitorWindowVisibility(Plasmoid.fullRepresentationItem);
                //justOpenedTimer.start();
            } else {
                kicker.reset();
            }
        }
    }

    function enableHideOnWindowDeactivate() {
        kicker.hideOnWindowDeactivate = true;
    }

    Component.onCompleted: {
        if (Plasmoid.hasOwnProperty("activationTogglesExpanded")) {
            Plasmoid.activationTogglesExpanded = false
        }

        windowSystem.focusIn.connect(enableHideOnWindowDeactivate);
        kicker.hideOnWindowDeactivate = true;

        rootModel.refreshed.connect(reset);
        if (rootModel.status == Component.Ready) rootModel.refresh();
    }
}
