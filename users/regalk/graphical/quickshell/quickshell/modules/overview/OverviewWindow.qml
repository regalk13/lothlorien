import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland

Item {
    id: root

    property var toplevel
    property var windowData
    property var monitorData
    property real scale
    property real availableWorkspaceWidth
    property real availableWorkspaceHeight
    property real xOffset: 0
    property real yOffset: 0
    property int widgetMonitorId: 0

    property real initX: {
        if (!windowData?.at)
            return xOffset;
        let relX = Math.max((windowData.at[0] - (monitorData?.x || 0) - (monitorData?.reserved?.[0] || 0)) * scale, 0);
        return relX + xOffset;
    }

    property real initY: {
        if (!windowData?.at)
            return yOffset;
        let relY = Math.max((windowData.at[1] - (monitorData?.y || 0) - (monitorData?.reserved?.[1] || 0)) * scale, 0);
        return relY + yOffset;
    }

    x: initX
    y: initY
    width: (windowData?.size?.[0] || 200) * scale
    height: (windowData?.size?.[1] || 150) * scale
    opacity: windowData?.monitor === widgetMonitorId ? 1 : 0.4

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            width: root.width
            height: root.height
            radius: 4
        }
    }

    ScreencopyView {
        id: windowPreview
        anchors.fill: parent
        captureSource: overviewScope.overviewOpen ? root.toplevel : null
        live: true

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.width: 1
            border.color: "#555"
            radius: 4
        }
    }
}
