import QtQuick
import QtQuick.Layouts
import Quickshell

import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.common.decorators

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        id: barBg

        anchors {
            fill: parent
            bottomMargin: (bar.cornerStyle === 0 && !bar.bottomBar) ? bar.screenRounding : 0
            topMargin: (bar.cornerStyle === 0 && bar.bottomBar) ? bar.screenRounding : 0
        }
        color: bar.showBarBackground ? "#161616" : "transparent"
    }

    RowLayout {
        anchors.fill: barBg
        anchors.margins: 8
        spacing: 16

        RowLayout {
            spacing: 4

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                z: -1 // Behind the workspace rectangles

                onPressed: event => {
                    if (event.button === Qt.RightButton) {
                        bar.overviewOpen = true;
                    }
                }
            }

            Repeater {
                model: 10

                Rectangle {
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    radius: 4

                    property int workspaceId: index + 1
                    property bool isActive: Hyprland.focusedWorkspace?.id === workspaceId
                    property bool hasWindows: Hyprland.workspaces.values.some(ws => ws.id === workspaceId)

                    color: "transparent"
                    border.color: "transparent"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: bar.toChineseNumber(workspaceId)
                        color: parent.isActive ? "#be95ff" : (parent.hasWindows ? "#cccccc" : "#666666")
                        font.pixelSize: 12
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch(`workspace ${workspaceId}`)
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Text {
            id: clockText
            color: "white"
            font.pixelSize: 14

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    clockText.text = Qt.formatDateTime(new Date(), "ddd MMM dd - hh:mm:ss");
                }
            }

            Component.onCompleted: {
                text = Qt.formatDateTime(new Date(), "ddd MMM dd - hh:mm:ss");
            }
        }
    }

    // Rounding
    Item {
        id: roundDecorators
        anchors {
            left: parent.left
            right: parent.right
            top: !bar.bottomBar ? barBg.bottom : undefined
            bottom: bar.bottomBar ? barBg.top : undefined
        }
        height: bar.screenRounding
        visible: bar.showBarBackground && bar.cornerStyle === 0

        RoundCorner {
            id: leftCorner
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }

            implicitSize: bar.screenRounding
            color: "#131313"

            corner: bar.bottomBar ? RoundCorner.CornerEnum.BottomLeft : RoundCorner.CornerEnum.TopLeft
        }

        RoundCorner {
            id: rightCorner
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            implicitSize: bar.screenRounding
            color: "#131313"

            corner: bar.bottomBar ? RoundCorner.CornerEnum.BottomRight : RoundCorner.CornerEnum.TopRight
        }
    }
}
