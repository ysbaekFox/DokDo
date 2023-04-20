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
        height: 80

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
        id: chatListViewRect
        width: mainWindow.width - leftRetangle.width
        height: mainWindow.height - topRectangle.height - mainChatBox.height - 60

        anchors {
            top: topRectangle.bottom
            left: leftRetangle.right
        }

        ListView {
            id: chatListView

            width: mainWindow.width - leftRetangle.width
            height: mainWindow.height - topRectangle.height - mainChatBox.height - 60

            boundsBehavior: Flickable.StopAtBounds

            ScrollBar.vertical: ScrollBar {
                active: true
            }

            clip: true

            model: ListModel {
            }

            delegate: Rectangle {
                    width: chatListViewRect.width
                    height: 60

                    color: (chatListView.currentIndex == index) ? "lightgray" : "white"

                    Text {
                        text: model.name + ": " + model.message
                        font.bold: true
                        font.pointSize: 14
                        wrapMode: Text.Wrap
                        elide: Text.ElideRight
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: model.name === "John" ? Text.AlignRight : Text.AlignLeft
                        color: "black"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        chatListView.currentIndex = index;
                    }
                }
            }

            Component.onCompleted: {
                chatListView.currentIndex = -1;
            }

            Connections {
                target: mainChatTextArea

                function onSendMessage(msg) {
                    chatListView.model.append({"name": "ysbaek", "message": msg})
                }
            }
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

        TextArea {
            id: mainChatTextArea

            signal sendMessage(string msg)

            width: mainWindow.width - leftRetangle.width - 100 - 20
            height: mainChatBox.height * 0.4

            font.family: chatFont.font.family
            font.pixelSize: 35
            selectByMouse: true
            wrapMode: Text.WordWrap

            anchors {
                verticalCenter: mainChatBox.verticalCenter
                horizontalCenter: mainChatBox.horizontalCenter
            }

            background: Rectangle {
                border.color: "black"
                width: mainWindow.width - leftRetangle.width - 100 - 20
                height: mainChatBox.height * 0.4
            }

            Keys.onPressed: (event)=> {
                if ( event.key === Qt.Key_Return && (event.modifiers & Qt.AltModifier) ) {
                    mainChatTextField.insert(mainChatTextField.cursorPosition, '\n')
                    console.log("go new line")
                }
                else if( event.key === Qt.Key_Return )
                {
                    mainChatTextField.sendMessage(mainChatTextField.text)
                    mainChatTextField.clear()
                }
            }
        }
    }
}
