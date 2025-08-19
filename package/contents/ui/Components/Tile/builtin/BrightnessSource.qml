/**
 * Taken from Plasma.Flex.Hub by zayronxio
 * SPDX-FileCopyrightText: 2025 zayronxio
 * SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 * SPDX-License-Identifier: LGPL-3.0-or-later
 **/

import QtQuick
import org.kde.kitemmodels as KItemModels
import org.kde.plasma.private.brightnesscontrolplugin
import org.kde.plasma.workspace.dbus as DBus

Item {

    id: root

    ScreenBrightnessControl {
        id: systemBrightnessControl
        isSilent: false
    }

    DBus.Properties {
        id: nightM
        busType: DBus.BusType.Session
        service: "org.kde.KWin.NightLight"
        path: "/org/kde/KWin/NightLight"
        iface: "org.kde.KWin.NightLight"

        // This property holds a value to indicate if Night Light is available.
        readonly property bool available: Boolean(properties.available)
        // This property holds a value to indicate if Night Light is enabled.
        readonly property bool enabled: Boolean(properties.enabled)
        // This property holds a value to indicate if Night Light is running.
        readonly property bool running: Boolean(properties.running)
        // This property holds a value to indicate whether night light is currently inhibited.
        readonly property bool inhibited: Boolean(properties.inhibited)
        // This property holds a value to indicate whether night light is currently inhibited from the applet can be uninhibited through it.
        readonly property bool inhibitedFromApplet: NightLightInhibitor.inhibited
        // This property holds a value to indicate which mode is set for transitions (0 - automatic location, 1 - manual location, 2 - manual timings, 3 - constant)
        readonly property int mode: Number(properties.mode)
        // This property holds a value to indicate if Night Light is on day mode.
        readonly property bool daylight: Boolean(properties.daylight)
        // This property holds a value to indicate currently applied color temperature.
        readonly property int currentTemperature: Number(properties.currentTemperature)
        // This property holds a value to indicate currently applied color temperature.
        readonly property int targetTemperature: Number(properties.targetTemperature)
        // This property holds a value to indicate the end time of the previous color transition in msec since epoch.
        readonly property double currentTransitionEndTime: Number(properties.previousTransitionDateTime) * 1000 + Number(properties.previousTransitionDuration)
        // This property holds a value to indicate the start time of the next color transition in msec since epoch.
        readonly property double scheduledTransitionStartTime: Number(properties.scheduledTransitionDateTime) * 1000

        readonly property bool transitioning: currentTemperature != targetTemperature
        readonly property bool hasSwitchingTimes: mode != 3
        readonly property bool togglable: !inhibited || inhibitedFromApplet
    }

    signal nightMode

    onNightMode: {
        NightLightInhibitor.toggleInhibition()
    }

    property bool runningNightToggle: nightM.running
    property bool active: systemBrightnessControl.isBrightnessAvailable

    Connections {
        id: displayModelConnections
        target: systemBrightnessControl.displays
        property var screenBrightnessInfo: []

        function update() {
            const [labelRole, brightnessRole, maxBrightnessRole, displayNameRole] = ["label", "brightness", "maxBrightness", "displayName"].map(
                (roleName) => target.KItemModels.KRoleNames.role(roleName));

            screenBrightnessInfo = [...Array(target.rowCount()).keys()].map((i) => { // for each display index
                const modelIndex = target.index(i, 0);
                return {
                    displayName: target.data(modelIndex, displayNameRole),
                                                                            label: target.data(modelIndex, labelRole),
                                                                            brightness: target.data(modelIndex, brightnessRole),
                                                                            maxBrightness: target.data(modelIndex, maxBrightnessRole),
                };
            });
            root.mainScreen = screenBrightnessInfo[0];
        }
        function onDataChanged() { update(); }
        function onModelReset() { update(); }
        function onRowsInserted() { update(); }
        function onRowsMoved() { update(); }
        function onRowsRemoved() { update(); }
    }

    property int realValueSlider: 0
    property int cnValue: mainScreen.brightness
    property var mainScreen: displayModelConnections.screenBrightnessInfo[0]
    property var valueSlider: mainScreen.brightness
    property var maxSlider: mainScreen.maxBrightness
    property bool disableBrightnessUpdate: true
    readonly property int brightnessMin: (mainScreen.maxBrightness > 100 ? 1 : 0)


    onRealValueSliderChanged: {
        systemBrightnessControl.setBrightness(mainScreen.displayName, Math.max(brightnessMin, Math.min(mainScreen.maxBrightness, (realValueSlider*100)))) ;
    }

    Connections {
        target: systemBrightnessControl
    }
}
