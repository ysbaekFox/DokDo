import QtQuick
import QtQuick.Controls

Window {
    id: mainWindow
    width: 1600
    height: 980
    visible: true
    title: qsTr("DokDo-Chat")

    property FontLoader chatFont: FontLoader { id: font; source: "/resources/fonts/AppleSDGothicNeoR.ttf" }

    Rectangle {
        id: topRectangle
        color: "#350d36"
        width: mainWindow.width
        height: 50

        anchors {
            top: mainWindow.top
            horizontalCenter: mainWindow.horizontalCenter
        }
    }

    Rectangle {
        id: leftRetangle
        color: "#3f0e40"
        width: 300
        height: mainWindow.height - topRectangle.height

        anchors {
            left: mainWindow.left
            top: topRectangle.bottom
            bottom: mainWindow.bottom
        }
    }

    Rectangle {
        id: mainChatBox
        width: mainWindow.width - leftRetangle.width - 100
        height: 219
        border.color: "black"
        radius: 20

        anchors {
            left: leftRetangle.right
            leftMargin: 50
            bottom: leftRetangle.bottom
            bottomMargin: 20
        }

        TextField {
            id: mainChatTextField
            width: mainWindow.width - leftRetangle.width - 100 - 20
            height: mainChatBox.height * 0.4

            font.family: chatFont.font.family
            font.pixelSize: 35
            selectByMouse: true

            anchors {
                verticalCenter: mainChatBox.verticalCenter
                horizontalCenter: mainChatBox.horizontalCenter
            }

            background: Rectangle {
                border.color: "black"
                width: mainWindow.width - leftRetangle.width - 100 - 20
                height: mainChatBox.height * 0.4
            }
        }
    }
}
