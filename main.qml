import QtQuick 2.15
import QtQuick.Window 2.2
import QtQuick.Controls 2.15
import io.qt.graphdraw.logic 1.0

ApplicationWindow {
    id: window
    width: 320
    height: 260
    visible: true
    minimumHeight: 480
    minimumWidth: 720
    Logic {
        id: logic
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            Action {
                text: qsTr("&Export to file")
            }
            Action {
                text: qsTr("&Load from file")
            }
            MenuSeparator {}
            Action {
                text: qsTr("&Quit")
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: qsTr("&Edit")
            Action {
                text: qsTr("&Generate")
            }
            Action {
                text: qsTr("&Clear")
            }
        }
        Menu {
            title: qsTr("&Help")
            Action {
                text: qsTr("&About")
                onTriggered: showMessageBox('Created by Artem Siryk!')
            }
        }
    }

    Item {
        anchors.centerIn: parent
        width: msgDialog.width
        height: msgDialog.height
        MessageDialog {
            id: msgDialog
            title: qsTr("Information")
            visible: false
        }
    }
    Canvas {
        id: graph
        width: parent.width
        height: parent.height
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: {

                console.log("Parasha")
                logic.HandleClick(mouse.x, mouse.y)
                drawCircle(mouse.x, mouse.y)
                graph.requestPaint()
            }
            onReleased: {
                logic.HandleRelease(mouse.x, mouse.y)
            }
            onPressAndHold: {
                logic.HandleHold(mouse.x, mouse.y)
            }
            function drawCircle(x, y) {
                var ctx = graph.getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "black"
                ctx.lineWidth = parent.size / 20
                ctx.beginPath()
                var startAngle = Math.PI / 5 * 3
                var endAngle = startAngle + 10 * Math.PI / 5 * 9
                ctx.arc(x, y, width / 2 - ctx.lineWidth / 2 - 2,
                        startAngle, endAngle)
                ctx.stroke()
                graph.requestPaint()
            }
        }

        onPaint: {
            console.log(logic.adjacency_list.length)
            console.log("buba")
        }
        TapHandler {
            id: handler
            onTapped: {

                console.log("buba")
                graph.requestPaint()
            }
        }
    }

    function showMessageBox(message) {
        msgDialog.text = message
        msgDialog.visible = true
    }
}
