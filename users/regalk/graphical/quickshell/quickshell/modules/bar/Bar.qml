import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.modules.common.decorators
import qs.modules.overview

Scope {
    id: bar

    property bool showBarBackground: true
    property bool bottomBar: false  // false = top bar, true = bottom bar
    property int cornerStyle: 0     // 0 = hug, 1 = float, 2 = plain
    property int screenRounding: 15

    PanelWindow {
        id: barRoot
        anchors {
            top: !bar.bottomBar
            bottom: bar.bottomBar
            left: true
            right: true
        }

        implicitHeight: 40 + (bar.cornerStyle === 0 ? bar.screenRounding : 0)
        color: "transparent"
        WlrLayershell.namespace: "quickshell:bar"

        BarComponent {}
    }

    Overview {
        id: overview
    }
}
