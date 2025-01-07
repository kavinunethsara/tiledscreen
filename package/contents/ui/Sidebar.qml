/*
 S PDX-FileCopyrightText: 2024 Kavin*u Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import "./Components"

ColumnLayout {
    id: root
    required property string currentPage
    required property KickerModel kicker
    property bool active: currentPage == "home" ? true : false
    visible: opacity != 0
    property double offst: 0

    Layout.leftMargin: -offst;
    Layout.preferredWidth: Kirigami.Units.gridUnit * 3

    state: "visible"
    states: [
        State {
            name: "visible"
            when: root.active
            PropertyChanges { target: root; opacity:1 }
            PropertyChanges { target: root;  offst: 0 }
        },
        State {
            name: "invisible"
            when: !root.active
            PropertyChanges { target: root; offst: implicitWidth }
            PropertyChanges { target: root; opacity:0 }
        }
    ]
    transitions: Transition {
        NumberAnimation { properties: "offst"; easing.type: Easing.InOutQuad; duration: Kirigami.Units.shortDuration * 3 }
        NumberAnimation { properties: "opacity"; easing.type: Easing.InOutQuad; duration:  Kirigami.Units.shortDuration * 3 }
    }
    Category{
        title: "Recents"
        action: ""

        Layout.fillHeight: true

        LocationItem{
            name: "Home"
            icon: "go-home"
        }
        LocationItem{
            name: "Documents"
            icon: "folder-documents"
        }
        LocationItem{
            name: "Downloads"
            icon: "folder-downloads"
        }
        LocationItem{
            name: "Pictures"
            icon: "folder-pictures"
        }
        LocationItem{
            name: "Videos"
            icon: "folder-videos"
        }
    }

    PowerButton {}

    function update() {
        //recentsView.model = root.kicker.appModel.modelForRow(1)
    }
}
