import QtQuick
import QtQuick.Controls

Window {
    id: mainWindow
    width: 1600
    height: 980
    visible: true
    title: qsTr("DokDo-Chat")

    property int fontSize: 14
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

        Button {
            id: addChannelBtn
            width: leftRetangle.width * 0.8
            height: 50
            hoverEnabled: false

            Text {
                id: name
                text: qsTr("채널 추가")
                color: "#c1b1c2"
                font.pixelSize: 25
                font.family: chatFont.font.family

                anchors {
                    centerIn: parent
                }
            }


            anchors {
                top: leftRetangle.top
                topMargin: 20
                horizontalCenter: leftRetangle.horizontalCenter
            }

            background: Rectangle {
                id: backgroundRect
                border.width: 2
                border.color: "#c1b1c2"
                radius: 15
                width: leftRetangle.width * 0.8
                height: 50
                color: "#3f0e40"
            }


            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    name.color = "white"
                    backgroundRect.border.color = "white"
                    backgroundRect.color = "#1164a3"
                }

                onExited: {
                    name.color = "#c1b1c2"
                    backgroundRect.border.color = "#c1b1c2"
                    backgroundRect.color = "#3f0e40"
                }
            }
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
                    id: chatTextRect
                    width: chatListViewRect.width
                    height: 60

                    color: (chatListView.currentIndex == index) ? "lightgray" : "white"

                    Image {
                        id: profileImage
                        width: 50
                        height: 50

                        source: "/resources/images/default_profile.png"
                        anchors {
                            left: chatTextRect.left
                        }
                    }

                    Text {
                        text: model.name + ": " + model.message
                        font.bold: true
                        font.pointSize: fontSize
                        wrapMode: Text.Wrap
                        elide: Text.ElideRight
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: model.name === "John" ? Text.AlignRight : Text.AlignLeft
                        color: "black"

                        anchors {
                            left: profileImage.right
                        }
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
        color: "#f8f8f8"
        border.color: "#e2e2e2"
        border.width: 2
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

            width: mainWindow.width - leftRetangle.width - 100 - 4
            height: mainChatBox.height * 0.4

            font.family: chatFont.font.family
            font.pixelSize: 20
            selectByMouse: true
            wrapMode: Text.WordWrap

            anchors {
                verticalCenter: mainChatBox.verticalCenter
                horizontalCenter: mainChatBox.horizontalCenter
            }

            background: Rectangle {
                border.width: 0
                width: mainWindow.width - leftRetangle.width - 100 - 4
                height: mainChatBox.height * 0.4
            }

            Keys.onPressed: (event)=> {
                if ( event.key === Qt.Key_Return && (event.modifiers & Qt.AltModifier) ) {
                    mainChatTextArea.insert(mainChatTextArea.cursorPosition, '\n')
                    mainChatTextArea.background.height += mainChatTextArea.font.pixelSize
                    mainChatTextArea.height += mainChatTextArea.font.pixelSize
                }
                else if( event.key === Qt.Key_Return )
                {
                    event.accepted = true
                    mainChatTextArea.sendMessage(mainChatTextArea.text)
                    mainChatTextArea.height = mainChatBox.height * 0.4
                    mainChatTextArea.background.height = mainChatBox.height * 0.4
                    mainChatTextArea.clear()
                }
            }
        }
    }
}
