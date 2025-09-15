import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    id: root

    property var monitor
    property real scale: 0.18
    property int rows: 2
    property int columns: 5
    property int workspaceSpacing: 10

    signal workspaceClicked(int workspaceId)

    readonly property int totalWorkspaces: rows * columns
    readonly property real workspaceWidth: (monitor?.width || 1920) * scale
    readonly property real workspaceHeight: (monitor?.height || 1080) * scale

    implicitWidth: (workspaceWidth * columns) + (workspaceSpacing * (columns - 1)) + 40
    implicitHeight: (workspaceHeight * rows) + (workspaceSpacing * (rows - 1)) + 40

    Rectangle {
        anchors.fill: parent
        color: "#1a1a1a"
        radius: 12
        border.width: 1
        border.color: "#333333"

        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            color: "transparent"
            border.width: 2
            border.color: "#80000000"
            radius: parent.radius + 2
            z: -1
        }
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

            WorkspacePreview {
                id: workspacePreview

                Layout.preferredWidth: root.workspaceWidth
                Layout.preferredHeight: root.workspaceHeight

                workspaceId: index + 1
                monitor: root.monitor
                scale: root.scale

                isActive: root.monitor?.activeWorkspace?.id === workspaceId

                hasWindows: Hyprland.workspaces.values.some(ws => ws.id === workspaceId)

                onClicked: root.workspaceClicked(workspaceId)
            }
        }
    }
}
