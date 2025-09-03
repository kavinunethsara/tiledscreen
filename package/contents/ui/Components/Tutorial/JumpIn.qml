import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

Page {
  id: root
  previous: "ConfigureLauncher"

  Kirigami.Heading {
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.largeSpacing
    horizontalAlignment: Qt.AlignHCenter
    text: "That's it."
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    Layout.maximumWidth: Kirigami.Units.gridUnit * 28
    Layout.alignment: Qt.AlignHCenter
    horizontalAlignment: Qt.AlignHCenter
    onLinkActivated: function (link) { Qt.openUrlExternally(link) }
    text: "Click <b>Finish</b> to complete the tutorial. "
    wrapMode: Text.WordWrap
  }

  Kirigami.Heading {
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.largeSpacing
    horizontalAlignment: Qt.AlignHCenter
    text: "Tiled Screen"
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    Layout.maximumWidth: Kirigami.Units.gridUnit * 28
    Layout.alignment: Qt.AlignHCenter
    horizontalAlignment: Qt.AlignHCenter
    onLinkActivated: function (link) { Qt.openUrlExternally(link) }
    text: "Tiled Screen is a configurable and extensible tile based fullscreen launcher. It is onw of the two widgets in TiledWidgets collection - the other being TiledLauncher. For more information, visit <a href='https://kavinunethsara.github.io/tiledwidgets'>kavinunethsara.github.io/tiledwidgets</a> . "
    wrapMode: Text.WordWrap
  }
}
