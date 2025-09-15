import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

Scope {
    id: overviewScope

    property int overviewRows: 2
    property int overviewColumns: 5
    property real overviewScale: 0.16

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: overviewWindow
            required property var modelData

            screen: modelData
            visible: bar.overviewOpen

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: "transparent"
            WlrLayershell.namespace: "quickshell:overview"
            WlrLayershell.layer: WlrLayer.Overlay

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    bar.overviewOpen = false;
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    onClicked: bar.overviewOpen = false
                }
            }

            OverviewGrid {
                    anchors {
        top: parent.top
        topMargin: 50  // Add some margin from the top
        horizontalCenter: parent.horizontalCenter  // Keep it centered horizontally
    }
                monitor: Hyprland.monitorFor(overviewWindow.screen)
                scale: overviewScope.overviewScale
                rows: overviewScope.overviewRows
                columns: overviewScope.overviewColumns

                onWorkspaceClicked: workspaceId => {
                    bar.overviewOpen = false;
                    Hyprland.dispatch(`workspace ${workspaceId}`);
                }
            }
        }
    }

    GlobalShortcut {
        name: "overviewToggle"
        description: "Toggle workspace overview"

        onPressed: {
            overviewScope.overviewOpen = !overviewScope.overviewOpen;
        }
    }
}
