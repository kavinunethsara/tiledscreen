import QtQuick
import QtQuick.Controls
import org.kde.iconthemes as KIconThemes

pragma ComponentBehavior: Bound

Button {
    id: root
    onClicked: {
        dialogLoader.active = true
    }

    Loader {
        id: dialogLoader
        active: false
        sourceComponent: KIconThemes.IconDialog {
            id: dialog
            visible: true
            modality: Qt.WindowModal
            onIconNameChanged: {
                root.icon.name = dialog.iconName
            }
            onVisibleChanged: {
                if (!visible) {
                    dialogLoader.active = false
                }
            }
        }
    }
}
