import QtQuick
import org.kde.plasma.private.kicker 0.1 as Kicker

Item {
    id: kicker
    property alias appModel: rootModel
    signal updated()

    Kicker.RootModel {
        id: rootModel

        flat: true
        sorted: true
        showSeparators: false
        showAllApps: true
        showAllAppsCategorized: false
        showRecentDocs: true
        showPowerSession: true

        // Component.onCompleted: {
        //     favoritesModel.initForClient("org.kde.plasma.kicker.favorites.instance-" + Plasmoid.id)
        //
        //     if (!Plasmoid.configuration.favoritesPortedToKAstats) {
        //         if (favoritesModel.count < 1) {
        //             favoritesModel.portOldFavorites(Plasmoid.configuration.favoriteApps);
        //         }
        //         Plasmoid.configuration.favoritesPortedToKAstats = true;
        //     }
        // }

        onRefreshed: {
            kicker.updated();
            console.log(this.count);
        }
    }
}
