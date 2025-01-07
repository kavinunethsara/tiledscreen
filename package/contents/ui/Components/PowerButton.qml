import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
Item {
    id: root
    height: content.implicitHeight
    width: content.implicitWidth
    Layout.alignment: Qt.AlignRight

    RowLayout{
        id: content
        Layout.fillWidth: false
        spacing: Kirigami.Units.smallSpacing
        PlasmaComponents.Button {
            text: "Shutdown"
        }
        PlasmaComponents.Button {
            icon.name: "usermenu-up"
            checkable: true
            checked: powerMenu.visible
            onClicked: {
                powerMenu.popup()
            }

            PlasmaComponents.Menu {
                id: powerMenu
                PlasmaComponents.MenuItem { text: "Restart" }
                PlasmaComponents.MenuItem { text: "Logout" }
                PlasmaComponents.MenuItem { text: "Sleep" }
            }
        }
    }
}
