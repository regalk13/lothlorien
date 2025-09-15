import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

Scope {
    id: overviewScope

    property int overviewRows: 2
    property int overviewColumns: 5
    property real overviewScale: 0.18

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
                color: "#80000000"

                MouseArea {
                    anchors.fill: parent
                    onClicked: bar.overviewOpen = false
                }
            }

            OverviewGrid {
                anchors.centerIn: parent
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
