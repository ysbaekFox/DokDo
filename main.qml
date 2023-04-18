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
        border.color: "red"

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
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
                ListElement {
                    name: "John"
                    message: "Hello"
                }
                ListElement {
                    name: "Alice"
                    message: "Hi"
                }
                ListElement {
                    name: "Bob"
                    message: "Hello"
                }
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
            wrapMode: Text.Wrap

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
