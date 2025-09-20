import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.services

Item {
    id: root

    property var monitor
    property real scale: 0.35
    property int rows: 2
    property int columns: 5
    property int workspaceSpacing: 10

    signal workspaceClicked(int workspaceId)

    readonly property var toplevels: ToplevelManager.toplevels
    readonly property int totalWorkspaces: rows * columns
    readonly property int workspaceGroup: Math.floor(((monitor?.activeWorkspace?.id || 1) - 1) / totalWorkspaces)

    readonly property real workspaceWidth: (monitor?.width || 1920) * scale
    readonly property real workspaceHeight: (monitor?.height || 1080) * scale

    property var windows: HyprlandData.windowList
    property var windowByAddress: HyprlandData.windowByAddress
    property var monitorData: HyprlandData.monitors.find(m => m.id === monitor?.id)

    implicitWidth: (workspaceWidth * columns) + (workspaceSpacing * (columns - 1)) + 40
    implicitHeight: (workspaceHeight * rows) + (workspaceSpacing * (rows - 1)) + 40

    Rectangle {
        anchors.fill: parent
        color: "#1a1a1a"
        radius: 12
        border.width: 1
        border.color: "#333333"
    }

    GridLayout {
        id: workspaceGrid
        anchors.centerIn: parent
        rows: root.rows
        columns: root.columns
        rowSpacing: root.workspaceSpacing
        columnSpacing: root.workspaceSpacing
        Repeater {
            model: root.totalWorkspaces

            Rectangle {
                id: workspace
                property int workspaceValue: root.workspaceGroup * root.totalWorkspaces + index + 1

                Layout.preferredWidth: root.workspaceWidth
                Layout.preferredHeight: root.workspaceHeight

                color: monitor?.activeWorkspace?.id === workspaceValue ? "#2d2d2d" : "#0f0f0f"
                radius: 8
                border.width: 2
                border.color: monitor?.activeWorkspace?.id === workspaceValue ? "#be95ff" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: workspaceValue
                    color: "#666666"
                    font.pixelSize: Math.min(parent.width, parent.height) * 0.15
                    font.weight: Font.Bold
                    opacity: 0.7
                    z: 100
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.workspaceClicked(workspaceValue)
                }
            }
        }
    }

    Item {
        id: windowSpace
        anchors.centerIn: parent
        width: workspaceGrid.implicitWidth
        height: workspaceGrid.implicitHeight

        Repeater {
            model: {
                if (!ToplevelManager.toplevels?.values)
                    return [];

                return ToplevelManager.toplevels.values.filter(toplevel => {
                    const address = `0x${toplevel.HyprlandToplevel.address}`;
                    var win = root.windowByAddress[address];
                    if (!win)
                        return false;

                    const inWorkspaceGroup = (root.workspaceGroup * root.totalWorkspaces < win.workspace?.id && win.workspace?.id <= (root.workspaceGroup + 1) * root.totalWorkspaces);
                    return inWorkspaceGroup;
                });
            }

            delegate: OverviewWindow {
                required property var modelData

                property var address: `0x${modelData.HyprlandToplevel.address}`
                property var winData: root.windowByAddress[address]
                property int workspaceIndex: ((winData?.workspace?.id || 1) - 1) - (root.workspaceGroup * root.totalWorkspaces)
                property int workspaceRow: Math.floor(workspaceIndex / root.columns)
                property int workspaceCol: workspaceIndex % root.columns

                toplevel: modelData
                windowData: winData
                monitorData: root.monitorData
                scale: root.scale

                xOffset: (root.workspaceWidth + root.workspaceSpacing) * workspaceCol
                yOffset: (root.workspaceHeight + root.workspaceSpacing) * workspaceRow
                availableWorkspaceWidth: root.workspaceWidth
                availableWorkspaceHeight: root.workspaceHeight
                widgetMonitorId: root.monitor?.id || 0
            }
        }
    }
}
