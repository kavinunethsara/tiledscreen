import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

import "../Tile" as Tile

Page {
  id: root
  previous: "EditTile"
  next: "GetNew"

  Kirigami.Heading {
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.largeSpacing
    horizontalAlignment: Qt.AlignHCenter
    text: "Adding new Tiles"
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    horizontalAlignment: Qt.AlignHCenter
    text: "<i>Right Click</i>   on an empty space and select <b>Add Tile</b> to create new tiles.
          <br>This will open the <b>Tile Selector</b>, where you can select the type of tile you need.
          <br>Try adding a <b>Volume Slider</b> Tile"
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
