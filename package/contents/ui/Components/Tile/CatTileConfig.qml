import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard


FormCard.FormCardDialog {
    id: root
    title: "Edit Tile"
    required property variant tile

    FormCard.FormHeader {
        title: "General"
    }

    FormCard.FormTextFieldDelegate {
        label: "Name"
        placeholderText: "Name to display on tile"
        text: root.tile.internalTile.name
        onTextChanged: {
            root.tile.internalTile.name = text;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Width"
        value: root.tile.len
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.len = value;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Height"
        value: root.tile.breadth
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.breadth = value;
        }
    }

    FormCard.FormDelegateSeparator {}

    FormIconDelegate {
        iconName: root.tile.internalTile.icon
        onIconNameChanged: {
            root.tile.internalTile.icon = iconName
        }
    }
}
