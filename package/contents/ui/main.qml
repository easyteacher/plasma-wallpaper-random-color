/*
    SPDX-FileCopyrightText: 2013 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2022 Fushan Wen <qydwhotmail@gmail.com>

    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick

import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

WallpaperItem {
    id: root

    contextualActions: [
        PlasmaCore.Action {
            text: i18nc("@action:inmenu copy current color hex code", "Copy Current Color")
            icon.name: "edit-copy"
            onTriggered: generator.copyCurrentColor()
        },
        PlasmaCore.Action {
            text: i18nc("@action:inmenu switch to next random color", "Next Random Color")
            icon.name: "color-fill"
            onTriggered: generator.restart()
        }
    ]

    RandomColorGenerator {
        id: generator
    }

    Rectangle {
        anchors.fill: parent
        color: generator.currentColor

        Behavior on color {
            SequentialAnimation {
                ColorAnimation {
                    duration: Kirigami.Units.longDuration
                }

                ScriptAction {
                    script: root.accentColorChanged()
                }
            }
        }
    }
}
