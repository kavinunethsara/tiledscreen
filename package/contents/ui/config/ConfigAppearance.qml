/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

/*
 SPDX-FileCopyrightText: 2024 Kavinu Nethsara <kavinunethsarakoswattage@gmail.com>
 SPDX-License-Identifier: LGPL-2.1-or-later
 */

import QtQuick
import QtCore
import QtQuick.Dialogs as Dialogs
import org.kde.kcmutils as KCM
import org.kde.kirigamiaddons.formcard as FormCard

KCM.SimpleKCM {
    id: root
    property alias cfg_useBackgroundImage: useImage.checked
    property alias cfg_backgroundImage: imagePath.selectedFile
    property alias cfg_backgroundImageBlur: blurSlider.value
    property alias cfg_backgroundOpacity: opacitySlider.value
    property alias cfg_overlayOpacity: overlaySlider.value

    property alias cfg_displayUserInfo: showUser.checked
    property alias cfg_userInfoStyle: userNameStyle.currentIndex
    property alias cfg_showLogoutButton: showLogout.checked
    property alias cfg_showLockButton: showLock.checked
    property string cfg_backgroundImageDefault

    FormCard.FormCardPage {
        FormCard.FormHeader {
            title: i18n("Background")
        }
        FormCard.FormCard {
            FormCard.FormSwitchDelegate {
                id: useImage
                text: i18n("Background Image")
            }
            FormCard.FormButtonDelegate {
                id: imageSelector
                enabled: useImage.checked
                text: i18n("Select Background")
                onClicked: imagePath.open()
            }
            Dialogs.FileDialog {
                id: imagePath
                currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
            }
            FormCard.FormSpinBoxDelegate {
                id: blurSlider
                label: i18n("Image Blur")
                from: 0
                to: 100
                stepSize: 1
                enabled: useImage.checked
            }
            FormCard.FormSpinBoxDelegate {
                id: opacitySlider
                label: i18n("Background Opacity")
                from: 0
                to: 100
                stepSize: 1
                enabled: useImage.checked
            }
            FormCard.FormSpinBoxDelegate {
                id: overlaySlider
                label: i18n("Background Overlay Opacity")
                from: 0
                to: 100
                stepSize: 1
            }
        }

        FormCard.FormHeader {
            title: i18n("Toolbar")
        }
        FormCard.FormCard {
            FormCard.FormSwitchDelegate {
                id: showUser
                text: i18n("Show User Information")
            }
            FormCard.FormComboBoxDelegate {
                id: userNameStyle
                text: i18n("Show user name as")
                model: [
                    i18n("Full Name"),
                    i18n("User Name")
                ]
                enabled: showUser.checked
            }
            FormCard.FormSwitchDelegate {
                id: showLock
                text: i18n("Show lock button")
            }
            FormCard.FormSwitchDelegate {
                id: showLogout
                text: i18n("Show power button")
            }

        }
    }
}
