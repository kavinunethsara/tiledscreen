import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Page {
  next: "AddTile"

  Kirigami.Icon {
    Layout.alignment: Qt.AlignHCenter
    Layout.preferredHeight: Kirigami.Units.gridUnit * 6
    Layout.preferredWidth: Layout.preferredHeight
    source: "start-here-kde-plasma"
  }

  Kirigami.Heading {
    font.pixelSize: Kirigami.Units.gridUnit
    Layout.fillWidth: true
    horizontalAlignment: Qt.AlignHCenter
    text: "Welcome to"
  }

  Kirigami.Heading {
    font.pixelSize: Kirigami.Units.gridUnit * 2
    Layout.fillWidth: true
    horizontalAlignment: Qt.AlignHCenter
    text: "Tiled Screen"
  }

  Kirigami.Heading {
    level: 2
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.gridUnit
    horizontalAlignment: Qt.AlignHCenter
    text: "A configurable tile based fullscreen launcher inspired by Windows 8"
  }

}
