
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.Window 2.12
import QtQml 2.12
import QtWebView 1.1
import QtWebSockets 1.1


Page{ // лабараторная 10: мессенджер
    id: page8MAL

    Material.background: "#fffff"

    header:

         ToolBar{
         id: lab //Хедер
        height: 60
        Material.background: "#1e1e1e"                  //Тёмный цвет





        Label {
            x: 46
            anchors.verticalCenter: parent.verticalCenter
            opacity: 1
            text: "Простейший чат-сервер на WebSocket"
            font.pixelSize: 25
            anchors.verticalCenterOffset: 13
            padding: 60
            font.family: "Times New Roman"
            font.styleName: "Полужирный Курсив"
            font.weight: Font.Medium
        }

        Text {
                                                            Layout.row:0
                                                            Layout.column:3
                                                            id: showStatus
                                                            text: showStatus.text
                                                            color: "white"
                                                            Layout.alignment: Qt.AlignCenter
                                                            anchors.verticalCenter: lab.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                           // anchors.bottom: 15
                                                            font.weight: Font.Medium
                                                            font.pointSize: 15
                                                            font.family: "Times New Roman"
                                                            anchors.leftMargin: 200
                                                     }


    }

    ListModel{                  //массив
        id: list
    }

    Rectangle{
        color: "white"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: sendPanel.top
        width: parent.width
        height: parent.height*0.85

        ListView{                           //отображение сообщений
            anchors.fill: parent
            anchors.bottomMargin: 70
            anchors.topMargin: 10
            spacing: 4
            model: list
            delegate:             //задает, как выглядит собщение
                Item{
                width: parent.width
                height: messageImage.height

                BorderImage {             //это вид сообщения
                    id: messageImage

                    source: sendMessage ? "send.jpg" : "receive.jpg"
                    width: parent.width *0.8
                    height: textMessage.contentHeight + 25
                    anchors.left: sendMessage ? undefined : parent.left
                    anchors.right: sendMessage ? parent.right : undefined

                    Text {
                        id: textMessage
                        color: "black"
                        text: message
                        width: messageImage.width*0.8 //ширина картинки
                        font.pointSize: 12
                        anchors.top: messageImage.top
                        anchors.left: messageImage.left
                        anchors.leftMargin: 15
                        anchors.topMargin: 6
                        wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere  //обтекание текста
                    }

                    Text {
                        id: messageTime
                        color: "black"
                        text: Qt.formatDateTime(new Date(), "hh:mm") //дата(часы/минуты)
                        font.pointSize: 8
                        anchors.bottom: messageImage.bottom
                        anchors.right: messageImage.right
                        anchors.rightMargin: 15
                        anchors.bottomMargin: 5
                    }
                }
            }
        }
    }

    //поле ввода текста
    Rectangle{
        id: sendPanel
        color: "#3d3d3d"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height*0.1 //высота строки, где вводится текст

        RowLayout {
            anchors.bottom: parent.bottom
            width: parent.width

            Rectangle {
                            anchors.fill: parent
                            color: "#1e1e1e"

                            Rectangle {
                                anchors.fill: parent
                                anchors.leftMargin: 5
                                anchors.rightMargin: 60
                                anchors.topMargin: 8
                                anchors.bottomMargin: 8
                                color: "white"
                                radius: 15
                            }
                        }

                        TextArea {
                            id: write
                            Layout.fillWidth: true
                            Layout.margins: 6
                            font.pointSize: 10

                            color: "#1e1e1e"
                            placeholderTextColor: "#1e1e1e"
                            placeholderText: "Ваше сообщение..."
                            wrapMode: TextArea.WrapAtWordBoundaryOrAnywhere
                            background:
                                Item {
                                width: parent.width
                                height: parent.height
                            }
                        }

                        RoundButton {
                            Material.background: "purple"
                            text: "➤"
                            onClicked: {
                                if(write.text != ""){  //если поле вводе не пустое, то добавляем в массив
                                    list.append({
                                        "sendMessage": true, //мой текст
                                        "message": write.text,
                                        "date" : new Date().toLocaleString(Qt.locale("ru_RU"))
                                    });

                                    websocket.sendTextMessage(write.text); //отправляем сообщение в websocket
                                    write.clear();
                                }
                            }
                        }
                    }
                }

                WebSocket{
                    id: websocket
                    active: true
                    url: "ws://malysheva-websocket.herokuapp.com"
                    onTextMessageReceived: {                      //функция самого websocket
                        console.log("message: ", message);
                        list.append({
                            "sendMessage" : false,
                            "message" : message,
                            "date" : new Date().toLocaleString(Qt.locale("ru_RU"))
                        });
                    }


                    onStatusChanged: {
                                switch(status)
                                {
                                case WebSocket.Connecting:
                                    showStatus.text = "Socket is connecting"
                                    console.log("Socket is connecting");
                                    break;
                                case WebSocket.Open:
                                    showStatus.text = "Socket is open"
                                    console.log("Socket is open");
                                    break;
                                case WebSocket.Closing:
                                    showStatus.text = "Socket is closing"
                                    console.log("Socket is closing");
                                    break;
                                case WebSocket.Closed:
                                    showStatus.text = "Socket is closed"
                                    console.log("Socket is closed");
                                    break;
                                case WebSocket.Error:
                                    showStatus.text = "Socket is error"
                                    console.log("Socket is error");
                                    console.log("Error = ", errorString);
                                    break;
                                }
                            }

                }
            }

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
