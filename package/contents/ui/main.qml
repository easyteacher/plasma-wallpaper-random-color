/*
    SPDX-FileCopyrightText: 2013 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2022 Fushan Wen <qydwhotmail@gmail.com>

    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore

Rectangle {
    id: root

    color: generator.currentColor

    function action_copy() {
        generator.copyCurrentColor();
    }

    function action_next() {
        generator.restart();
    }

    RandomColorGenerator {
        id: generator
    }

    Behavior on color {
        ColorAnimation {
            duration: PlasmaCore.Units.longDuration
        }
    }

    Component.onCompleted: {
        wallpaper.setAction("copy", i18nc("@action:inmenu copy current color hex code", "Copy Current Color"), "edit-copy");
        wallpaper.setAction("next", i18nc("@action:inmenu switch to next random color", "Next Random Color"), "color-fill");
    }
}
