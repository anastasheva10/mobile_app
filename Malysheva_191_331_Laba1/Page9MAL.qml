import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick 2.0
import QtQuick.Window 2.12
import QtQml 2.12
import QtWebView 1.1
import QtWebSockets 1.1

Page{

    id: page9MAL

    Connections {
                target: httpController // Указываем объект для соединения
                onTokenToQml: {                //вызов функции, которая показывает токен
                    tokenShow.text = token
                }
                onDataToQml: {                      //показ картинки
                    base64data.text = pageContent;
                }

                onTimeToQml: {
                                    timeShow.text = newdate;
                                }
            }

    GridLayout {
        id: mainLayout
        columns: 2

        rowSpacing: 5
        columnSpacing: 5

        anchors {
            top: parent.top;
            left: parent.left
            right: parent.right
        }

        Label {
            id: loginLabel

            anchors.left: parent.left
            anchors.leftMargin: 15
            font.pixelSize: 18
            text: "Логин"
        }

        TextField {
            id: login

            anchors.left: loginLabel.right
            anchors.leftMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: passwordLabel
            font.pixelSize: 18
            anchors.left: parent.left
            anchors.leftMargin: 15

            text: "Пароль"
        }

        TextField {
            id: password
            echoMode: TextInput.Password
            anchors.left: passwordLabel.right
            anchors.leftMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button{
            id: send

            anchors.left: parent.left
            anchors.leftMargin: 15

            text: "Получить токен"
            background: Rectangle {

            color: "#D2691E"
            border.color: control.down ? "#D2691E" : "#D2691E"
            border.width: 1
            radius: 5
            }

            onClicked:{
                httpController.logIN(login.text, password.text);  //передается логин и пароль
            }
        }

        TextArea{
            id: tokenShow

            anchors.left: send.right
            anchors.leftMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            readOnly: true
        }

        Button{
                    id: send1

                    anchors.left: parent.left
                    anchors.leftMargin: 15

                    text: "Получить данные"
                    background: Rectangle {

                    color: "#D2691E"
                    border.color: control.down ? "#D2691E" : "#D2691E"
                    border.width: 1
                    radius: 5
                    }

                    onClicked:{
                        httpController.getData(tokenShow.text);
                        httpController.time();
                    }
                }
    }



    ScrollView {
        anchors.top: mainLayout.bottom
        anchors.topMargin: 15

        anchors.left: parent.left
        anchors.leftMargin: 15

        anchors.right: parent.right
        anchors.rightMargin: 15

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        clip:  true

        TextArea{
            id: base64data
            textFormat: Text.RichText

            readOnly: true
            anchors.fill: parent

            color: "black"

            background: Rectangle {
                id: news
                color: "#ffffff"
                visible: true
            }
        }
    }
}
