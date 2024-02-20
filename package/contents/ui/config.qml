/*
    SPDX-FileCopyrightText: 2013 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2014 Kai Uwe Broulik <kde@privat.broulik.de>
    SPDX-FileCopyrightText: 2022 Fushan Wen <qydwhotmail@gmail.com>

    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick
import QtQuick.Controls as QQC2

import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: root
    twinFormLayouts: parentLayout

    property int cfg_ColorScheme: 0
    property alias cfg_FollowNightColor: followNightColorCheckBox.checked
    property int cfg_SlideInterval: 0
    property int hoursIntervalValue: Math.floor(cfg_SlideInterval / 3600)
    property int minutesIntervalValue: Math.floor(cfg_SlideInterval % 3600) / 60
    property int secondsIntervalValue: cfg_SlideInterval % 3600 % 60

    property alias formLayout: root

    QQC2.ComboBox {
        Kirigami.FormData.label: i18nc("@label:listbox", "Color scheme:")

        currentIndex: cfg_ColorScheme
        enabled: !followNightColorCheckBox.checked || !followNightColorCheckBox.enabled

        model: [
            {
                'label': i18nc("@item:inlistbox", "No Preference"),
                'value': 0
            },
            {
                'label': i18nc("@item:inlistbox", "Dark"),
                'value': 1
            },
            {
                'label': i18nc("@item:inlistbox", "Light"),
                'value': 2
            },
            {
                'label': i18nc("@item:inlistbox", "Follow Theme"),
                'value': 3
            },
            {
                'label': i18nc("@item:inlistbox", "Vivid"),
                'value': 4
            },
        ]

        textRole: "label"
        onCurrentIndexChanged: cfg_ColorScheme = model[currentIndex]["value"]
    }

    QQC2.CheckBox {
        id: followNightColorCheckBox
        enabled: nightColorLoader.status === Loader.Ready
        text: i18nc("@option:check", "Automatically select a color scheme based on Night Color active status")

        Loader {
            id: nightColorLoader
            source: "NightColorControl.qml"
        }
    }

    Row {
        Kirigami.FormData.label: i18nc("@label:spinbox slideshow change interval", "Change every:")
        spacing: Kirigami.Units.smallSpacing

        Connections {
            target: root

            function onHoursIntervalValueChanged() {
                hoursInterval.value = root.hoursIntervalValue;
            }

            function onMinutesIntervalValueChanged() {
                minutesInterval.value = root.minutesIntervalValue;
            }

            function onSecondsIntervalValueChanged() {
                secondsInterval.value = root.secondsIntervalValue;
            }
        }

        QQC2.SpinBox {
            id: hoursInterval
            value: root.hoursIntervalValue
            from: 0
            to: 24
            editable: true
            onValueChanged: root.cfg_SlideInterval = hoursInterval.value * 3600 + minutesInterval.value * 60 + secondsInterval.value

            textFromValue: (value, locale) => i18np("%1 hour", "%1 hours", value)
            valueFromText: (text, locale) => parseInt(text)
        }

        QQC2.SpinBox {
            id: minutesInterval
            value: root.minutesIntervalValue
            from: 0
            to: 60
            editable: true
            onValueChanged: root.cfg_SlideInterval = hoursInterval.value * 3600 + minutesInterval.value * 60 + secondsInterval.value

            textFromValue: (value, locale) => i18np("%1 minute", "%1 minutes", value)
            valueFromText: (text, locale) => parseInt(text)
        }

        QQC2.SpinBox {
            id: secondsInterval
            value: root.secondsIntervalValue
            from: root.hoursIntervalValue === 0 && root.minutesIntervalValue === 0 ? 1 : 0
            to: 60
            editable: true
            onValueChanged: root.cfg_SlideInterval = hoursInterval.value * 3600 + minutesInterval.value * 60 + secondsInterval.value

            textFromValue: (value, locale) => i18np("%1 second", "%1 seconds", value)
            valueFromText: (text, locale) => parseInt(text)
        }
    }
}
