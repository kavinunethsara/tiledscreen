import QtQuick
import org.kde.kirigamiaddons.formcard as FormCard
import ".."

FormCard.FormCardDialog {
    id: root
    title: "Edit Tile"
    required property Tile tile

    FormCard.FormHeader {
        title: "General"
    }

    FormCard.FormTextFieldDelegate {
        label: "Name"
        placeholderText: "Name to display on tile"
        text: root.tile.tileData.name
        onTextChanged: {
            root.tile.tileData.name = text;
            root.tile.tileData = root.tile.tileData;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Width"
        value: root.tile.tileWidth
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.tileWidth = value;
        }
    }

    FormCard.FormSpinBoxDelegate {
        label: "Height"
        value: root.tile.tileHeight
        from: 1
        to: 100
        stepSize: 1
        onValueChanged: {
            root.tile.tileHeight = value;
        }
    }

    FormCard.FormDelegateSeparator {}

    FormIconDelegate {
        iconName: root.tile.tileData.icon
        onIconNameChanged: {
            root.tile.tileData.icon = iconName;
            root.tile.tileData = root.tile.tileData;
        }
    }
}
