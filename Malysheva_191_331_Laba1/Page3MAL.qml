import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import QtMultimedia 5.4
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12

Page{
    id: page3MAL
    header : Rectangle {
    id: header
    color: "#1d2027"
    height: 90


    Image {
      id:movie
      source:"pogoda.png"
      width: 150
      height: 70
      anchors.top:header.top
      anchors.topMargin: 10
      anchors.right: header.right
      anchors.rightMargin: 10
    }


    Label {
        color: "#ffffff"
       text: "Прогноз погоды в Москве"
       anchors.verticalCenter: movie.verticalCenter
       anchors.left: parent.left
       font.styleName: "Полужирный Курсив"
       font.weight: Font.Medium
       font.pointSize: 17
       font.family: "Times New Roman"
       anchors.leftMargin: 50
       leftPadding: movie.indicator.width + movie.spacing

    }
}

    Rectangle {
        id: rectangle122
        color: "#4169E1"
        anchors.topMargin: 0
        anchors.fill: parent
    }
    GridLayout {
        anchors.topMargin: 30
        anchors.fill: parent
        columns: 2

        Button {
            id: sent
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2
            onClicked: {
                _send.getNetworkValue();
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Отправить")
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 20
                opacity: enabled ? 1 : 0.3
                color: "#CD5C5C"
                radius: 10
            }
        }


        ScrollView {
            Layout.fillHeight: true
            Layout.columnSpan: 2
            Layout.fillWidth: true

            clip:  true
            TextArea{
                id: textArea
                textFormat: Text.RichText
                objectName: "textArea"
                readOnly: true
                anchors.fill: parent
                background: Rectangle {

                    Image {
                        id: fon
                        source: "fon.jpg"
                    }
            }
        }
        }

        Label {
            Layout.alignment: Qt.AlignCenter
            //Layout.fillWidth: true
            Layout.columnSpan: 2
            text: "<b>Погода сейчас<b>"
            color: "#CD5C5C"
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignCenter

            TextField {
                id: textField

                objectName: "textField"
                color: "#CD5C5C"
                horizontalAlignment: Text.AlignHCenter
                readOnly: true
                Layout.alignment: Qt.AlignCenter
                Layout.columnSpan: 2
            }


            //TextField {
            //    id: textFieldDate
            //    objectName: "textFieldDate"
            //   readOnly: true
            //   Layout.alignment: Qt.AlignCenter
            //   Layout.columnSpan: 2

            // }


        }
    }
}
