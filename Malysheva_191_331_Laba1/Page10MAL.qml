import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Page {
    visible: true
    id: page10MAL
    header : Rectangle {
    id: header
    color: "#1e1e1e"
    height: 70


    Label {

        color: "#ffab25"
       text: "Графические эффекты"
       anchors.verticalCenter: parent.verticalCenter
       anchors.horizontalCenter: parent.horizontalCenter
       font.styleName: "Полужирный Курсив"
       font.weight: Font.Medium
       font.pointSize: 17
       font.family: "Times New Roman"
       leftPadding: avatar.indicator.width + avatar.spacing

    }
  }

Rectangle {
    id: rectangle12
    color: "#1d2027"
    anchors.topMargin: 0
    anchors.fill: parent
}


GridLayout{
    anchors.topMargin: 5
    anchors.fill: parent


    Item {
        Layout.column: 0
        Layout.row: 0
        Layout.rowSpan: 3
        width: 230
        height: 150
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

        Image {
            id: bug
            source: "leo.jpg"
            width: 230
            height:150
            smooth: true
            visible: false
        }


        Image {
            id: mask
            source: "MaskedBlur_mask.png"
            width: 230
            height: 150
            smooth: true
            visible: false
        }


         MaskedBlur {
            anchors.fill: bug
            source: bug
            maskSource: mask
           radius: slider1.value
          samples: slider2.value
        }
    }

    Rectangle {
        Layout.column: 1
        Layout.row: 0
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        id: rectangle33
        width: 170
        height: 25
        color: "#ffab25"
        radius: 12
        Layout.fillWidth: false

        Label {
            id: label13
            width: 74
            height: 13
            color: "#000000"
            text: qsTr("MaskedBlur")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -2
            anchors.horizontalCenterOffset: -6
        }
    }
    Slider {
        id: slider1
        Layout.column: 1
        Layout.row: 1
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        Text {
            y: -7
            width: 35
            height: 16

            color: "#affb25"

            text: qsTr("radius")
            anchors.horizontalCenterOffset: -3
            anchors.horizontalCenter: parent.horizontalCenter
        }
        from: 0
        to: 20
        stepSize: 1
    }


    Slider{
        Layout.column: 1
        Layout.row: 2
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        id: slider2
        Text {
            y: -9

            color: "#ffab25"

            text: qsTr("samples")
            anchors.horizontalCenterOffset: -2
            anchors.horizontalCenter: parent.horizontalCenter
        }
        from: 0
        to: 20
        stepSize: 1

    }

    Rectangle{
                Layout.row: 3
                Layout.columnSpan: 2
                color: "#ffab25"

                height: 2
                Layout.fillWidth: true
                radius: 0

            }
    Item {
        Layout.column: 0
        Layout.row: 4
        Layout.rowSpan: 2
        width: 230
        height: 150
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter


        Rectangle {
            anchors.fill: parent
        }

        Image {
            id: bug2
            source: "leo.jpg"
            width: 230
            height: 150
            smooth: true
            visible: false

        }

       Desaturate {
            anchors.fill: bug2
            source: bug2
          desaturation: slider4.value

        }
    }

    Rectangle {
        Layout.column: 1
        Layout.row: 4
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        id: rectangle34
        width: 130
        height: 25
        color: "#ffab25"
        radius: 12
        Layout.fillWidth: false
        Label {
            id: label34
            width: 84
            height: 13
            color: "#000000"
            text: qsTr("Desaturate")
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: -2
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

    }
    Slider {
        Layout.column: 1
        Layout.row: 5
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        id: slider4
        Text {
            y: -16

            color: "#ffab25"

            text: qsTr("desaturation")
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }
        from: 0.0
        to: 1.0
        stepSize: 0.1

    }

    Rectangle{
        Layout.row: 6
        Layout.columnSpan: 2
        color: "#ffab25"

        height: 2
        Layout.fillWidth: true
        radius: 0


    }
    Item {
        Layout.column: 0
        Layout.row: 7
        Layout.rowSpan: 2
        width: 230
        height: 150
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter


        Rectangle {
            anchors.fill: parent
        }

        Image {
            id: bug1
            source: "leo.jpg"
            width: 230
            height: 150
            smooth: true
            visible: false

        }

        Image {
            id: mask1
            source: "mask1.png"
            width: 230
            height: 150
            smooth: true
            visible: false
        }

        OpacityMask {
            anchors.fill: bug1
            source: bug1
            maskSource: mask1
            invert: invert.checked

        }
    }

    Rectangle {

                    id: rectangle35
                    width: 130
                    height: 25
                    color: "#ffab25"
                    radius: 12
                    Layout.fillWidth: false
                    Layout.column: 1
                    Layout.row: 7
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                    Label {
                        id: label35
                        width: 62
                        height: 13
                        color: "#000000"
                        text: qsTr("OpacityMask")
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenterOffset: -2
                        anchors.horizontalCenterOffset: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                    }

                }


    SwitchDelegate {
        id:invert
        Layout.column: 1
        Layout.row: 8
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        checked: false



        indicator: Rectangle {
            implicitWidth: 48
            implicitHeight: 26
            x: invert.width - width - invert.rightPadding
            y: parent.height / 2 - height / 2
            radius: 13
            color: invert.checked ? "#ffab25" : "transparent"
            border.color: invert.checked ? "#ffab25" : "#cccccc"

            Rectangle {
                x: invert.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: invert.down ? "#cccccc" : "#ffffff"
                border.color: "#ffab25"
            }
        }

    }


}
}
