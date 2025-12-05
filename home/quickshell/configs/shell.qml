import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects

PanelWindow {
    property var modelData
    screen: modelData

    exclusionMode: ExclusionMode.Ignore
    aboveWindows: false
    color: "transparent"
    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    Text {
        id: timetxt
        height: 200
        x: parent.width - 417
        y: 37
        font.family: "GoMono"
        font.pointSize: 100
        color: "#fbf1c7"

        Process {
            id: dateProc
            command: ["date", "+%H %M"]
            running: true
            stdout: SplitParser {
                onRead: data => timetxt.text = data
            }
        }
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: dateProc.running = true
        }
    }
}
