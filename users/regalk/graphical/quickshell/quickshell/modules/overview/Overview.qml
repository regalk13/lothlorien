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
    property bool overviewOpen: false

    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: overviewWindow
            required property var modelData

            screen: modelData
            visible: overviewScope.overviewOpen

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            color: "transparent"
            WlrLayershell.namespace: "quickshell:overview"
            WlrLayershell.layer: WlrLayer.Overlay

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    onClicked: overviewScope.overviewOpen = false
                }
            }

            OverviewGrid {
                anchors {
                    top: parent.top
                    topMargin: 50
                    horizontalCenter: parent.horizontalCenter
                }
                monitor: Hyprland.monitorFor(overviewWindow.screen)
                scale: overviewScope.overviewScale
                rows: overviewScope.overviewRows
                columns: overviewScope.overviewColumns

                onWorkspaceClicked: workspaceId => {
                    overviewScope.overviewOpen = false;
                    Hyprland.dispatch(`workspace ${workspaceId}`);
                }
            }
        }
    }

    GlobalShortcut {
        name: "toggle_overview"
        onPressed: {
            overviewScope.overviewOpen = !overviewScope.overviewOpen;
        }
    }
}
