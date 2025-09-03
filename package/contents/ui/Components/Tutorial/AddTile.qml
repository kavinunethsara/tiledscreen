import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents

import "../" as Components

Page {
  id: root
  previous: "Welcome"
  next: "EditTile"

  Kirigami.Heading {
    Layout.fillWidth: true
    Layout.margins: Kirigami.Units.largeSpacing
    horizontalAlignment: Qt.AlignHCenter
    text: "Adding apps as Tiles"
  }

  PlasmaComponents.Label {
    Layout.margins: Kirigami.Units.largeSpacing
    Layout.fillWidth: true
    horizontalAlignment: Qt.AlignHCenter
    text: "It is as simple as selecting <b>Add to Tiles</b> from the context menu.
          <br>Try it out on the Dolphin icon below"
  }

  RowLayout {
    Layout.preferredWidth: Kirigami.Units.gridUnit * 6
    Layout.alignment: Qt.AlignHCenter
    Components.AppDelegate {
      z: 1
      id: del
      itemController: root
      model: {
        return {
          display: "Dolphin",
          decoration: "org.kde.dolphin"
        }
      }

      mouse.hoverEnabled: true

      Rectangle {
        anchors.fill: parent
        visible: del.mouse.containsMouse
        color: Kirigami.Theme.highlightColor
        radius: Kirigami.Units.cornerRadius
        opacity: 0.75
        z: -1
      }
    }

    PlasmaComponents.Menu {
      id: contextMenu

      PlasmaComponents.MenuItem{
        text: "Add to Tiles"
        icon.name: "emblem-favorite-symbolic"
        onClicked: guide.next()
      }

      PlasmaComponents.MenuSeparator {}

      PlasmaComponents.MenuItem{
        text: "Add to Desktop"
        icon.name: "list-add"
      }
    }
  }

  function showContextMenu () {
    contextMenu.popup()
  }
}
