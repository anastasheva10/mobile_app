import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12 // без него не будет работать механизм layout
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.12 // для 2 лабы: воспроизведение и запись видео
import QtQuick.Dialogs 1.2 // для "открыть видео" во 2 лабе, пока не реализовано
import QtQuick.Controls.Styles 1.4 // можно менять стили кнопки, но в итоге пока не используется
import QtGraphicalEffects 1.0 // графические эффекты для 3 лабы
import QtQuick.Window 2.12
import QtQml 2.12
import QtWebView 1.1
import QtWebSockets 1.1


Page{
//    id: page7MAL
//    header:   Rectangle {

//        Connections {
//                        target: crypt // Указываем целевой объект для соединения

//                        onSendToQml: {
//                            area.text = codetext // Устанавливаем счётчик в текстовый лейбл
//                        }
//                    }


//        Label {
//            x: 16
//            y: 0
//            text: qsTr("Шифрование данных на стороне клиента")
//            font.pixelSize: 23
//            font.styleName: "Полужирный Курсив"
//            font.weight: Font.Medium
//            font.pointSize: 20
//            font.family: "Times New Roman"
//            styleColor: "#000000"
//             anchors.leftMargin: 180
//            padding: 20

//        }
//        id: rectangleHeader
//        x: 0
//        y: 0
//        width: 600
//        height: 60
//        anchors.right: parent.right
//        gradient: Gradient {
//            GradientStop {
//                position: 0
//                color: "#FFA07A"
//            }

//            GradientStop {
//                position: 1
//                color: "#CD5C5C"
//            }
//        }


//        anchors.left: parent.left
//    }




//    GridLayout{
//        id: gridLayout
//        anchors.bottom: parent.bottom
//        anchors.topMargin: -112
//        anchors.bottomMargin: -36
//        anchors.right: parent.right
//        anchors.rightMargin: 0
//        anchors.left: parent.left
//        anchors.leftMargin: 0
//        anchors.top: parent.top
//        rows: 2
//        columns: 3

//        TextField{
//            id: key
//            placeholderText: qsTr("Введите ключ сюда")

//            anchors.left: parent.left
//            anchors.right: parent.right
//            width: 320
//            font.family: "Times New Roman"
//            font.pixelSize: 20
//            maximumLength: 32
//            Layout.row: 0
//            Layout.column: 0
//            Layout.columnSpan: 3
//            Material.accent: "#ecbe82"
//            visible: {
//                if(otherB.checked == true){
//                    return true
//                }
//                else
//                    return false
//            }
//        }
//    ScrollView
//    {
//        id:scroll
//        //    anchors.bottom: dialog.top
//            anchors.left: parent.left
//            anchors.right: parent.right

//            Layout.row: 0
//            Layout.column: 0
//            height: 200
////            objectName: "cryptoArea"
//            anchors.top: key.bottom
//             Material.accent: "#282828"

//        visible: {
//            if(textareaB.checked == true){
//                return true
//            }
//            else
//                return false
//        }
//    }
//        Button{
//            id: cryptBtn

//            anchors.bottom: parent.bottom
//            anchors.top: key.bottom
//            text: "Зашифровать"
//            font.family: "Times New Roman"
//            font.pixelSize: 20
//            anchors.left: parent.left
//            Layout.row: 1
//            Layout.column: 0

//            Material.background: "#282828"
//            Material.foreground: "white"
//            flat: true
//            onClicked: {crypt.encriptFile(key.text, fileDialoglab7.fileUrls)
//                        if (crypt.encriptFile(key.text, fileDialoglab7.fileUrls) === true){
//                        }
//            }
//            visible: {
//                if(otherB.checked == true){
//                    return true
//                }
//                else
//                    return false
//            }

//        }

//        Button {
//            id: dialog
//            visible: true
//            font.pixelSize: 20
//            layer.enabled: false
//            layer.smooth: false
//            anchors.left: cryptBtn.right
//            anchors.right: decrypt.left
//            anchors.top: key.bottom
//            anchors.bottom: parent.bottom
//            Layout.row: 1
//            Layout.column: 1

//            flat: true
//            text: "Выбрать файл"
//            font.family: "Times New Roman"
//            onClicked: fileDialoglab7.open()
//            Material.background: "#282828"
//            Material.foreground: "white"
//            FileDialog {
//                id: fileDialoglab7
//                folder: "D:\\"
//            }
//        }

//        Button{
//            id: decrypt
//             anchors.top: key.bottom
//             anchors.right: parent.right
//             anchors.bottom: parent.bottom
//            Layout.row: 1
//            Layout.column: 2

//            text: "Расшифровать"
//            font.family: "Times New Roman"
//            Material.background: "#282828"
//            Material.foreground: "white"
//            font.pixelSize: 18
//            flat: true
//            visible: {
//                if(otherB.checked == true){
//                    return true
//                }
//                else
//                    return false
//            }

//            onClicked: {crypt.decriptFile(key.text, fileDialoglab7.fileUrls)
//                        if (crypt.decriptFile(key.text, fileDialoglab7.fileUrls) === true){
//                        }
//        }


//}
//}
}



