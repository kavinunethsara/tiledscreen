import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

import "../Tile" as Tile

Page {
  id: root
  previous: "AddTile"
  next: "NewTile"

  Kirigami.Heading {
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.largeSpacing
    horizontalAlignment: Qt.AlignHCenter
    text: "Editing Tiles"
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    horizontalAlignment: Qt.AlignHCenter
    text: "You can <b>drag</b> tiles around to place them somewhere else.
          <br><b>Right Click</b> on a tile and select Edit Tile to enter Edit Mode.
          <br>While in Edit Mode, You can quickly switch editing tile by clicking on it."
  }

  Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    Tile.Grid {
      property variant appsView: {
        return ({
          runApp: (url) => {
            for (var i = 0; i < appsModel.count; i++) {
              var modelIndex = appsModel.index(i, 0)
              var favoriteId = appsModel.data(modelIndex, Qt.UserRole + 3)
              if (favoriteId == url) {
                appsModel.trigger(i, "", null)
                return
              }
            }
          }
        })
      }
    }
  }
}
