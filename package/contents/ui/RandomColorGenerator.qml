/*
    SPDX-FileCopyrightText: 2022 Fushan Wen <qydwhotmail@gmail.com>

    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick

import org.kde.kquickcontrolsaddons as KQCAddons

QtObject {
    id: generator

    property color currentColor: "black"

    /**
     * Current color scheme based on the configuration, the system theme or Night Color status.
     */
    readonly property int colorScheme: {
        if (nightColorLoader.item?.monitor.running && root.configuration.FollowNightColor) {
            const nightModeEnabled = nightColorLoader.item.inhibitor.state === 3 && !nightColorLoader.item.monitor.daylight;
            return nightModeEnabled ? 1 : 2;
        }

        if (root.configuration.ColorScheme === 3) {
            const wColor = palette.window;
            // 192 is from kcm_colors
            if (255 * (wColor.r * 11 + wColor.g * 16 + wColor.b * 5) / 32 < 192) {
                return 1; // Dark
            } else {
                return 2; // Light
            }
        }

        return root.configuration.ColorScheme;
    }

    property QtObject __clipboard: KQCAddons.Clipboard { }

    function copyCurrentColor() {
        const r = Math.round(currentColor.r * 255);
        const g = Math.round(currentColor.g * 255);
        const b = Math.round(currentColor.b * 255);

        __clipboard.content = `#${((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)}`;
    }

    function nextColor() {
        let lower = 0, upper = 256;

        if (generator.colorScheme === 1) {
            upper = 128;
        } else if (generator.colorScheme === 2) {
            lower = 128;
            upper = 128;
        }

        let newColor = generator.currentColor;
        let count = 0;

        if (generator.colorScheme < 3) {
            let r, g, b;

            while (count < 10 && newColor === generator.currentColor) {
                r = Math.floor(lower + Math.random() * upper);
                g = Math.floor(lower + Math.random() * upper);
                b = Math.floor(lower + Math.random() * upper);

                newColor = Qt.rgba(r / 255, g / 255, b / 255);
                count += 1;
            }
        } else if (generator.colorScheme === 4) {
            // Vivid
            let h, s, v;

            while (count < 10 && newColor === generator.currentColor) {
                h = Math.floor(Math.random() * 361);
                s = Math.floor(80 + Math.random() * 21);
                v = Math.floor(80 + Math.random() * 21);

                newColor = Qt.hsva(h / 360, s / 100, v / 100);
                count += 1;
            }
        }

        generator.currentColor = newColor;
    }

    function restart() {
        timer.restart()
    }

    readonly property SystemPalette palette: SystemPalette {
        colorGroup: SystemPalette.Active
    }

    // Night Color Control may be unavailable, so put it in a loader
    readonly property Loader nightColorLoader: Loader {
        source: "NightColorControl.qml"
    }

    readonly property Timer timer: Timer {
        interval: root.configuration.SlideInterval * 1000
        repeat: true
        running: true
        triggeredOnStart: true

        onTriggered: generator.nextColor()
    }

    onColorSchemeChanged: if (colorScheme !== 0) {
        timer.restart()
    }
}
