import org.kde.kirigami as Kirigami
import QtQuick.Controls as Controls
import org.kde.kquickcontrolsaddons as KQuickControlsAddons

Kirigami.Dialog {
  id: root
  property string error
  padding: Kirigami.Units.largeSpacing
  standardButtons: Kirigami.Dialog.NoButton
  showCloseButton: true

  title: "Error"

  Controls.Label {
    text: root.error
  }

  customFooterActions: Kirigami.Action {
    text: "Copy"
    icon.name: "clipboard"
    onTriggered: {
      clipboard.content = root.error
    }
  }

  KQuickControlsAddons.Clipboard {
    id: clipboard
  }
}
