import QtQuick
import QtQuick.Controls

Window {
    id: mainWindow
    width: 1600
    height: 980
    visible: true
    title: qsTr("DokDo-Chat")

    property FontLoader helveticaNeue: FontLoader { id: font; source: "/resources/fonts/Helvetica_Neue_Medium_Extended.ttf" }

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
            right: mainChatBox.left
            top: topRectangle.bottom
            bottom: mainWindow.bottom
        }
    }
}
