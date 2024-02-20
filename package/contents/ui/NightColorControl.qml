/*
    SPDX-FileCopyrightText: 2022 Fushan Wen <qydwhotmail@gmail.com>

    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQml

import org.kde.plasma.private.brightnesscontrolplugin

QtObject {
    readonly property NightColorInhibitor inhibitor: NightColorInhibitor { }
    readonly property NightColorMonitor monitor: NightColorMonitor { }
}
