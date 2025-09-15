import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: root

    property int workspaceId: 1
    property var monitor
    property real scale: 0.18
    property bool isActive: false
    property bool hasWindows: false
    property bool hovered: false

    signal clicked

    color: isActive ? "#2d2d2d" : (hasWindows ? "#1e1e1e" : "#0f0f0f")
    radius: 8
    border.width: 2
    border.color: isActive ? "#be95ff" : (hovered ? "#555555" : "transparent")

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    Behavior on border.color {
        ColorAnimation {
            duration: 200
        }
    }

    Text {
        anchors.centerIn: parent
        text: workspaceId
        color: isActive ? "#be95ff" : (hasWindows ? "#ffffff" : "#666666")
        font.pixelSize: Math.min(parent.width, parent.height) * 0.15
        font.weight: Font.Bold
        z: 10

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    Item {
        id: windowsContainer
        anchors.fill: parent
        anchors.margins: 4

        Repeater {
            model: Math.min(6, getWindowCount())

            Rectangle {
                width: 4
                height: 4
                radius: 2
                color: "#888888"
                x: (index % 3) * 8 + 8
                y: Math.floor(index / 3) * 8 + 8
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: hovered ? 0.1 : 0
        radius: parent.radius

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.clicked()
    }

    function getWindowCount() {
        return Hyprland.workspaces.values.filter(ws => ws.id === workspaceId)[0]?.windows?.length || 0;
    }
}
