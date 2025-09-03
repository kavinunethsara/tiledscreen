import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

Page {
  id: root
  previous: "NewTile"
  next: "JumpIn"

  Kirigami.Heading {
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.largeSpacing
    horizontalAlignment: Qt.AlignHCenter
    text: "Custom Tiles"
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    Layout.maximumWidth: Kirigami.Units.gridUnit * 28
    Layout.alignment: Qt.AlignHCenter
    horizontalAlignment: Qt.AlignHCenter
    onLinkActivated: function (link) { Qt.openUrlExternally(link) }
    text: "Selecting <b>Download Tiles</b> will open the <a href='https://kavinunethsara.github.io/tiledwidgets/store'>Tile Store website</a> where you can download custom tiles. After downloading, you can use <b>Install from File</b> to install the tile. These addons are shared between both TiledLauncher and TiledScreen (If you have both of them installed)."
    wrapMode: Text.WordWrap
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    Layout.maximumWidth: Kirigami.Units.gridUnit * 28
    Layout.alignment: Qt.AlignHCenter
    horizontalAlignment: Qt.AlignHCenter
    onLinkActivated: function (link) { Qt.openUrlExternally(link) }
    text: "You can even create your own tiles. TiledWidget Tiles can generally do anything normal Plasma Widgets are capable of. Documentation for developing custom tiles can be found in the <a href='https://kavinunethsara.github.io/tiledwidgets/docs'>documetation page of TiledWidgets website</a>."
    wrapMode: Text.WordWrap
  }
}
