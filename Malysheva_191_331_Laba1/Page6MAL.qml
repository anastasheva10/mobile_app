
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
//import QtWinExtras 1.0
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
import QtWebView 1.1

Page{
    id: page4MAL
    header : Rectangle {
        id: header
        color: "#ffffff"
        height: 90



        Connections {
            target: httpController
            onSendToQml: {
                avatar.source = url // Устанавливаем аву
            }
        }

        Item {
            Image {
                id: avatar
                width: 80
                height: 80
                anchors.topMargin: 10
                anchors.leftMargin: 10
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: mask2
                    anchors.fill: avatar
                }
            }
            Rectangle {
                id: mask2
                width: 46
                height: 46
                radius: 24
                visible: false
            }
        }

        Image {
            id:movie
            source:"logotip_vk.jpg"
            width: 80
            height: 70
            anchors.top:header.top
            anchors.topMargin: 10
            anchors.right: header.right
            anchors.rightMargin: 10
        }


        Label {
            color: "#4682B4"
            text: "Аутентификация OAuth2 через VK"
            anchors.verticalCenter: movie.verticalCenter
            anchors.left: parent.left
            font.styleName: "Полужирный Курсив"
            font.weight: Font.Medium
            font.pointSize: 17
            font.family: "Times New Roman"
            anchors.leftMargin: 100
            leftPadding: movie.indicator.width + movie.spacing

        }
    }


    ColumnLayout{
        anchors.topMargin: 77
        anchors.fill: parent

        WebView{
            Layout.row: 3
            id: webView

            url:"https://oauth.vk.com/authorize?client_id=7833594&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52"
            Layout.fillWidth: true
            Layout.fillHeight: true
            onLoadingChanged: {       // в переменную final_ac записываем новую ссылку с токеном
                final_ac.text = webView.url
                console.info("*** "+ webView.url)

                success(webView.url)
                failed(webView.url)
                hashvd(webView.url)
                cancel(webView.url)

                var token = httpController.success(webView.url)  //передаем эту переменную в функцию
                var error = httpController.failed(webView.url)
                var annul = httpController.cancel(webView.url)

                if(token !== " "){

                    tokens.text = token
                    tokens.visible = token === " " ? false : true;
                    mailButton.visible = token === " " ? false : true;
                    webView.visible = token === " " ? true : false;
                    successtoken.visible = token === " " ? false : true;
                }
                else if (error === true){

                    webView.visible = error === false ? true : false;
                    failedlogin.visible = error === false ? false : true;
                    buttonreturn.visible = error === false ? false : true;
                }
                else
                {
                    webView.visible = annul === false ? true : false;
                    labelreturn.visible = annul === false ? false : true;
                    buttonreturn.visible = annul === false ? false : true;


                }
                getPhoto()
            }
        }
        Label{
            id:tokens
            visible: false
            font.pixelSize: 9
            Layout.alignment: Qt.AlignCenter


        }

        Label{
            text: "Вход в систему выполнен успешно"
            visible: false
            Layout.alignment: Qt.AlignCenter

            id:successtoken
            font.pixelSize: 27
            font.italic: true
            color: "#4682B4"
        }

        Button{
            visible: false
            id:mailButton
            font.pixelSize: 20
            text: "Просмотр фото друзей"
            Layout.row:3
            Layout.alignment: Qt.AlignCenter
            onClicked:{
                success(final_ac.text);
                webView.goBack();
                restRequest();
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 20
                opacity: enabled ? 1 : 0.3
                color: "#4682B4"
                radius: 13
            }

        }
        /*Label{
                visible: false
                Layout.row: 1

                id:successtoken
                font.pixelSize: 25
                font.italic: true
                color: "#ffab25"
               text: "Вы вошли в систему"

            }*/
        Button{
            visible: false
            id:buttonreturn
            text: "Повторить попытку"
            Layout.row:3
            Layout.alignment: Qt.AlignCenter
            onClicked:{
                webView.url = "https://oauth.vk.com/authorize?client_id=7833594&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52"
                buttonreturn.visible = false
                webView.visible = true
                labelreturn.visible = false
                failedlogin.visible = false
            }


        }
        Label{
            visible: false
            Layout.row: 4
            Layout.alignment: Qt.AlignCenter
            id:labelreturn
            font.pixelSize: 30
            text: "Вы отменили попытку"
        }
        Label{
            visible: false
            Layout.row: 4
            Layout.alignment: Qt.AlignCenter
            id:failedlogin
            font.pixelSize: 30
            text: "Ошибка"
        }



        Label{
            Layout.row: 1
            id: final_ac
            Layout.alignment: Qt.AlignCenter
            visible: false
            Layout.fillWidth: true
        }

    }
}
