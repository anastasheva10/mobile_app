import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.12


Page{
     id:page1MAL
        header : Rectangle {
        id: header
        color: "#000000"
        height: 100


        Image {
          id:avanture
          source:"volna.jpg"
          width: 110
          height: 90
          anchors.top:header.top
          anchors.topMargin: 10
          anchors.right: header.right
          anchors.rightMargin: 10
        }


        Label {
            color: "#ffffff"
           text: "Туристическое агенство  Avanture"
           anchors.verticalCenter: avanture.verticalCenter
           anchors.left: parent.left
           font.styleName: "Полужирный Курсив"
           font.weight: Font.Medium
           font.pointSize: 17
           font.family: "Times New Roman"
           anchors.leftMargin: 60

        }
    }

  GridLayout{
      id:gridLayout
      rows: 0
      columns: 0
      // @disable-check M16
      anchors.fill:parent
      // @disable-check M16
      anchors.bottomMargin: 0
      // @disable-check M16
      anchors.topMargin: 0
      // @disable-check M16
      anchors.leftMargin: 15
      // @disable-check M16
      anchors.rightMargin: 15


      Label {
          id: welcome
          Layout.column: 0
          Layout.row: 0
          text: "Добро пожаловать!"
          anchors.top: parent.top
          font.family: "Times New Roman"
          font.pointSize: 17
          font.weight: Font.Light //шрифт жирный
          anchors.topMargin: 20

          anchors.horizontalCenter: parent.horizontalCenter
      }

  }

   GridLayout{
       id: gridLayout1
       // @disable-check M16
       anchors.fill: parent
       // @disable-check M16
       anchors.bottomMargin: -6
       // @disable-check M16
       anchors.topMargin: 6
// @disable-check M16
       anchors.leftMargin: 15
       // @disable-check M16
       anchors.rightMargin: 15


       Label {
           id: tour
           Layout.row: 1
           Layout.column: 1
           anchors.left: parent.left
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignTop
           font.pointSize: 12
           font.family: "Times New Roman"
           anchors.right: control2.left
           anchors.top: welcome.bottom
            text: "Введите название тура"
       }


       TextArea {
           Layout.column: 2
           Layout.row: 1

           id: control2
           placeholderText: qsTr("Enter description")

           background: Rectangle {
               implicitWidth: 150
               implicitHeight: 40
               border.color: control2.enabled ? "#FF0000" : "transparent"
           }
       }

       Tumbler {
               Layout.column: 3
               Layout.row: 1
               anchors.right: parent.right
               font.pointSize: 12
               font.family: "Times New Roman"
               id: control
               model: 15
               anchors.topMargin: -50

               background: Item {
                   Rectangle {
                       opacity: control.enabled ? 0.2 : 0.1
                       border.color: "#FF0000"
                       width: parent.width
                       height: 1
                       anchors.top: parent.top
                   }

                   Rectangle {
                       opacity: control.enabled ? 0.2 : 0.1
                       border.color: "#FF0000"
                       width: parent.width
                       height: 1
                       anchors.bottom: parent.bottom
                   }
               }

               delegate: Text {
                   text: qsTr("День %1").arg(modelData + 1)
                   font: control.font
                   horizontalAlignment: Text.AlignHCenter
                   verticalAlignment: Text.AlignVCenter
                   opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
                   color: "#FFFFFF"
               }

               Rectangle {
                   anchors.horizontalCenter: control.horizontalCenter
                   y: control.height * 0.4
                   width: 40
                   height: 1
                   color: "#FF0000"

               }

               Rectangle {
                   anchors.horizontalCenter: control.horizontalCenter
                   y: control.height * 0.6
                   width: 40
                   height: 1
                   color: "#FF0000"
               }
           }

       Label {
           id: date
           Layout.row: 2
           Layout.column: 1
           anchors.left: parent.left
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignTop
           font.pointSize: 12
           font.family: "Times New Roman"
           anchors.right: control4.left
           anchors.top: tour.bottom
           anchors.topMargin: 50

            text: "Выберите дату"
       }


       RadioButton {
           Layout.row: 2
           Layout.column: 2
           anchors.top: control2.bottom
           font.pointSize: 12
           font.family: "Times New Roman"
           anchors.topMargin: 30
           id: control4
           text: qsTr("Да/Нет")
           checked: true

           indicator: Rectangle {
               implicitWidth: 26
               implicitHeight: 26
               x: control4.leftPadding
               y: parent.height / 2 - height / 2
               radius: 13
               border.color: control4.down ? "#17a81a" : "#FF0000"

               Rectangle {
                   width: 14
                   height: 14
                   x: 6
                   y: 6
                   radius: 7
                   color: control4.down ? "#17a81a" : "#FF0000"
                   visible: control4.checked
               }
           }

           contentItem: Text {
               text: control4.text
               font: control4.font
               opacity: enabled ? 1.0 : 0.3
               color: control4.down ? "#17a81a" : "#FF0000"
               verticalAlignment: Text.AlignVCenter
               leftPadding: control4.indicator.width + control4.spacing
           }
       }

       Label {
           id: app
           Layout.row: 3
           Layout.column: 1
           anchors.left: parent.left
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignTop
           font.pointSize: 12
           font.family: "Times New Roman"
           anchors.right: control4.left
           anchors.top: date.bottom
           anchors.topMargin: 50

            text: "Подтвердите заказ"
       }

       Button {
           Layout.row: 3
           Layout.column: 2
           anchors.top: control4.bottom
           id: control5
           text: qsTr("Заказать")
           font.pointSize: 15
           font.family: "Times New Roman"
           anchors.topMargin: 30


           contentItem: Text {
               text: control5.text
               font: control5.font
               opacity: enabled ? 1.0 : 0.3
               color: control5.down ? "#FF0000" : "#FF0000"
               horizontalAlignment: Text.AlignHCenter
               verticalAlignment: Text.AlignVCenter
               elide: Text.ElideRight
           }

           background: Rectangle {
               implicitWidth: 100
               implicitHeight: 40
               opacity: enabled ? 1 : 0.3
               border.color: control5.down ? "#FF0000" : "#FF0000"
               border.width: 1
               radius: 2
           }
       }




       BusyIndicator {

           id: control1
           Layout.row: 2
           Layout.column: 2
           anchors.left: control2.right
           anchors.top: control.bottom
          // anchors.topMargin: 50
            anchors.leftMargin: -20

           contentItem: Item {
               implicitWidth: 64
               implicitHeight: 64

               Item {
                   id: item1
                   x: parent.width / 2 - 32
                   y: parent.height / 2 - 32
                   width: 64
                   height: 64
                   opacity: control1.running ? 1 : 0

                   Behavior on opacity {
                       OpacityAnimator {
                           duration: 250
                       }
                   }

                   RotationAnimator {
                       target: item
                       running: control1.visible && control1.running
                       from: 0
                       to: 360
                       loops: Animation.Infinite
                       duration: 1250
                   }

                   Repeater {
                       id: repeater
                       model: 6

                       Rectangle {
                           x: item1.width / 2 - width / 2
                           y: item1.height / 2 - height / 2
                           implicitWidth: 10
                           implicitHeight: 10
                           radius: 5
                           color: "#FF0000"
                           transform: [
                               Translate {
                                   y: -Math.min(item1.width, item1.height) * 0.5 + 5
                               },
                               Rotation {
                                   angle: index / repeater.count * 360
                                   origin.x: 5
                                   origin.y: 5
                               }
                           ]
                       }
                   }
               }
           }
       }



















}
}


