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
        anchors.margins: 15
        anchors.topMargin: 6
        spacing: 16

        Rectangle {
            Layout.preferredHeight: 30
            Layout.preferredWidth: workspaceLayout.implicitWidth + 8
            
            color: "#333333"
            radius: 20
            clip: true 
            
            Rectangle {
                id: activeIndicator
                width: 30
                height: 30
                radius: 4
                color: Qt.rgba(231, 143, 255, 0.15)
                
                property int activeWorkspaceIndex: {
                    let activeId = Hyprland.focusedWorkspace?.id ?? 1;
                    if (activeId >= 1 && activeId <= 10) {
                        return activeId - 1;
                    }
                    return 0;
                }
                
                x: {
                    let baseX = (parent.width - workspaceLayout.implicitWidth) / 2; // Center offset
                    let itemWidth = 30;
                    let spacing = 4;
                    return baseX + (activeIndicator.activeWorkspaceIndex * (itemWidth + spacing));
                }
                
                y: (parent.height - height) / 2 
                
                Behavior on x {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.InOutCubic
                    }
                }
            }
            
            RowLayout {
                id: workspaceLayout
                anchors.centerIn: parent
                spacing: 4

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
                        border.width: 0

                        Text {
                            anchors.centerIn: parent
                            text: bar.toChineseNumber(workspaceId)
                            color: parent.isActive ? "#be95ff" : (parent.hasWindows ? "#cccccc" : "#666666")
                            font.pixelSize: 12
                            
                            scale: parent.isActive ? 1.1 : 1.0
                            
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutBack
                                }
                            }
                            
                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Hyprland.dispatch(`workspace ${workspaceId}`)
                            
                            onEntered: {
                                if (!parent.isActive) {
                                    parent.opacity = 0.7
                                }
                            }
                            onExited: {
                                parent.opacity = 1.0
                            }
                        }

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
                            }
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