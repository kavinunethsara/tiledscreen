/*
 SPDX-FileCopyrightText: 2025 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import ".."
import org.kde.notificationmanager as NotificationManager

AbstractToggle {
    id: root

    NotificationManager.Settings {
        id: notificationSettings
    }

    toggled: checkInhibition()

    function activate(mouse) {
        if (checkInhibition()) {
            notificationSettings.notificationsInhibitedUntil = undefined;
            notificationSettings.revokeApplicationInhibitions();

            // overrules current mirrored screen setup, updates again when screen configuration
            notificationSettings.screensMirrored = false;
            notificationSettings.save();

            return;
        }

        var d = new Date();
        d.setYear(d.getFullYear()+1)

        notificationSettings.notificationsInhibitedUntil = d
        notificationSettings.save()
    }

    function checkInhibition() {
        var inhibited = false

        console.warn("Notif P1", inhibited)

        if (!NotificationManager.Server.valid) {
            return false
        }

        console.warn("Notif P2", inhibited)

        var inhibitedUntil = notificationSettings.notificationsInhibitedUntil

        if (!isNaN(inhibitedUntil.getTime())) {
            inhibited |= (Date.now() < inhibitedUntil.getTime())
        }

        if (notificationSettings.notificationsInhibitedByApplication) {
            inhibited |= true
        }

        if (notificationSettings.inhibitNotificationsWhenScreensMirrored) {
            inhibited |= notificationSettings.screensMirrored
        }

        console.warn("Notif", inhibited)
        return inhibited
    }

    icon: root.toggled? "notifications-disabled" : "notifications"
    text: "Don't Disturb"
}
