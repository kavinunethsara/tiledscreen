import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

Item {
  id: guide
  anchors.fill: parent
  visible: plasmoid.configuration.firstRun

  property Page current: welcome

  ColumnLayout {
    id: container

    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      bottom: toolbar.top
    }

    Welcome {
      id: welcome
    }
  }

  RowLayout {
    id: toolbar

    anchors {
      left: parent.left
      right: parent.right
      bottom: parent.bottom
    }

    Controls.Button {
      text: "Back"
      visible: guide.current.previous

      onClicked: {
        const previous = guide.current.previous
        if (guide.current)
          guide.current.destroy()
          if (previous) {
            const item = Qt.createComponent(previous + ".qml");
            if (item.status === Component.Ready) {
              guide.current = item.createObject(container, {})
            }
          }
      }
    }

    Item { Layout.fillWidth: true }

    Controls.Button {
      text: guide.current.next ? "Skip" : "Finish"

      onClicked: {
        plasmoid.configuration.firstRun = false
        guide.destroy()
      }
    }

    Controls.Button {
      text: "Next"
      visible: guide.current.next

      onClicked: guide.next()
    }
  }

  function next() {
    const next = guide.current.next
    if (guide.current)
      guide.current.destroy()
      if (next) {
        const item = Qt.createComponent(next + ".qml");
        if (item.status === Component.Ready) {
          guide.current = item.createObject(container, {})
        }
      }
  }

}
