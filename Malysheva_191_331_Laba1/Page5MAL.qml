
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12 // без него не будет работать механизм layout
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.12 // для 2 лабы: воспроизведение и запись видео
import QtQuick.Dialogs 1.2 // для "открыть видео" во 2 лабе, пока не реализовано
import QtQuick.Controls.Styles 1.4 // можно менять стили кнопки, но в итоге пока не используется
import QtGraphicalEffects 1.0

import QtQuick.Window 2.12
import QtQml 2.12
import QtWebView 1.1
import QtWebSockets 1.1


Page{
    id: page5MAL
    header : Rectangle {
    id: header
    color: "#1e1e1e"
    height: 70


    Image {
      id:avatar
      source:"avatar.jpg"
      width: 80
      height: 60
      anchors.left: parent.left
      anchors.leftMargin: 10
      anchors.verticalCenter: parent.verticalCenter
      layer.enabled: true
      layer.effect: OpacityMask {
                      maskSource: mask2
                  }
    }

    Rectangle {                                     //Закругление авы
                id: mask2
                width: 36
                height: 36
                radius: 18
                visible: false
            }

    Label {

        color: "#4682B4"
       text: "ЛР 5 - Запросы по REST API"
       anchors.verticalCenter: parent.verticalCenter
       anchors.left: parent.left
       font.styleName: "Полужирный Курсив"
       font.weight: Font.Medium
       font.pointSize: 17
       font.family: "Times New Roman"
       anchors.leftMargin: 180
       leftPadding: avatar.indicator.width + avatar.spacing

    }
  }


    ScrollView{
            anchors.fill: parent
            Image{
                id: background
                width: parent.width
                height: parent.height*2
                sourceSize.width: -1
                fillMode: Image.TileHorizontally
                y: -grid.contentY / 3 | -list.contentY / 3
            }


            ColumnLayout{
                      anchors.fill: parent
                      Layout.alignment: Qt.AlignHCenter

                      RowLayout{
                          Layout.alignment: Qt.AlignHCenter

                          RadioButton {
                              id: col_button
                              text: qsTr("Столбцы")
                              checked: true

                              onCheckedChanged: // если сменен выбор
                                                if(col_button.checked)
                                                {
                                                  grid.cellWidth = grid.width/(Math.round(grid.width/300))
                                                }
                          else{
                              grid.cellWidth = grid.width
                          }

                              indicator: Rectangle {
                                  implicitWidth: 26
                                  implicitHeight: 26
                                  x: col_button.leftPadding
                                  y: parent.height / 2 - height / 2
                                  radius: 13
                                  border.color: col_button.down ? "#83bbde" : "#83bbde"

                                  Rectangle {
                                      width: 14
                                      height: 14
                                      x: 6
                                      y: 6
                                      radius: 7
                                      color: col_button.down ? "#83bbde" : "#83bbde"
                                      visible: col_button.checked
                                  }
                              }

                              contentItem: Text {
                                  text: col_button.text
                                  font: col_button.font
                                  opacity: enabled ? 1.0 : 0.3
                                  color: col_button.down ? "#83bbde" : "#83bbde"
                                  verticalAlignment: Text.AlignVCenter
                                  leftPadding: col_button.indicator.width + col_button.spacing
                              }
                          }

                          RadioButton {
                              id: row_button
                              text: qsTr("Строки")
                              //checked: false


                              indicator: Rectangle {
                                  implicitWidth: 26
                                  implicitHeight: 26
                                  x: row_button.leftPadding
                                  y: parent.height / 2 - height / 2
                                  radius: 13
                                  border.color: row_button.down ? "#83bbde" : "#83bbde"

                                  Rectangle {
                                      width: 14
                                      height: 14
                                      x: 6
                                      y: 6
                                      radius: 7
                                      color: row_button.down ? "#83bbde" : "#83bbde"
                                      visible: row_button.checked
                                  }
                              }

                              contentItem: Text {
                                  text: row_button.text
                                  font: row_button.font
                                  opacity: enabled ? 1.0 : 0.3
                                  color: row_button.down ? "#83bbde" : "#83bbde"
                                  verticalAlignment: Text.AlignVCenter
                                  leftPadding: row_button.indicator.width + row_button.spacing
                              }
                          }


                      }



            GridView{

                onWidthChanged: {
                                              if (col_button.checked)
                                              {
                                                  grid.cellWidth = grid.width/(Math.round(grid.width/300))
                                              }
                                              else{
                                                  grid.cellWidth = grid.width
                                              }
                                          }

                                          clip: true

                id: grid
                cellWidth: width/(Math.round(width/300))
                                           cellHeight: 100
                                           Layout.fillWidth: true
                                           Layout.fillHeight: true
                                           Layout.leftMargin: 5
                                           Layout.rightMargin: 5
                                           model: app_model


                //spacing: 10

                delegate: Rectangle{
                    color: "#FAEBD7"
                    width: grid.cellWidth
                    height: grid.cellHeight
                    border.color: "black"

                       radius: 5




                   GridLayout{

                       MouseArea {
                                                     anchors.fill: grid
                                                     width: grid.cellWidth
                                                     height: grid.cellHeight
                                                     onClicked: {
                                                         popup.open()

                                                     }
                                                 }
                                              Popup {
                                                      id: popup
                                                      x: 100
                                                      y: 100
                                                      width: 200
                                                      height: 300
                                                      modal: true
                                                      focus: true
                                                      closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                                                      Button{
                                                      text: "close"
                                                      onClicked: {
                                                          popup.close()

                                                      }
                                                      }



                                                  }


                       anchors.fill: parent
                        columns: 3
                        rows: 3
                        //Layout.margins: 20

                        Image{
                            id:img
                            source: pict
                            Layout.column: 0
                            Layout.row: 0
                            Layout.rowSpan: 3
                            Layout.preferredHeight: 90
                            Layout.preferredWidth: 90
                            Layout.margins: 5
                            fillMode: Image.PreserveAspectFit


                            property bool rounded: true
                                                      property bool adapt: true

                                                      layer.enabled: rounded
                                                      layer.effect: OpacityMask {
                                                          maskSource: Item {
                                                              width: img.width
                                                              height: img.height
                                                              Rectangle {
                                                                  anchors.centerIn: parent
                                                                  width: img.adapt ? img.width : Math.min(img.width, img.height)
                                                                  height: img.adapt ? img.height : width
                                                                  radius: Math.min(width, height)
                                                              }
                                                          }
                                                      }
                                                  }


                        Rectangle{
                                                    id: lBorder
                                                    Layout.row: 0
                                                    Layout.column: 1
                                                    Layout.rowSpan: 3

                                                    Layout.topMargin: 10
                                                    Layout.bottomMargin: 10
                                                    //Layout.leftMargin: 10

                                                    anchors.left: img.right
                                                    anchors.leftMargin: 5

                                                    color: "#191970"
                                                    width: 2
                                                    Layout.fillHeight: true
                                                }
                        Label {
                                                   color: "#4682B4"
                                                   text: "Домен. имя: " + user_id
                                                   Layout.topMargin: 10
                                                   Layout.column: 2
                                                   Layout.row: 0
                                                   Layout.fillHeight: true
                                                   Layout.preferredWidth: 150

                                                   font.family: "Times New Roman"
                                                   font.pointSize: 8

                                                   anchors.left: lBorder.right
                                                   anchors.leftMargin: 15
                                               }

                        Label{ // name
                                                  color: "#4682B4"
                                                  text: "Имя: " + name
                                                  Layout.column: 2
                                                  Layout.row: 1
                                                  Layout.fillHeight: true
                                                  Layout.preferredWidth: 150

                                                  font.family: "Times New Roman"
                                                  font.pointSize: 8

                                                  anchors.left: lBorder.right
                                                  anchors.leftMargin: 15
                                              }

                        Label{ // Surname
                                                   color: "#4682B4"
                                                   text: "Фамилия: " + surname
                                                   Layout.column: 2
                                                   Layout.row: 2
                                                   Layout.fillHeight: true
                                                   Layout.preferredWidth: 150

                                                   font.family: "Times New Roman"
                                                   font.pointSize: 8

                                                   anchors.left: lBorder.right
                                                   anchors.leftMargin: 15
                                               }
                    }
                }
            }

     }
    }
}
            /*ListView{
                id: list
                visible: false
                Layout.fillHeight: true
                Layout.fillWidth: true
                enabled: true
                model: app_model
                spacing: 15

                Layout.leftMargin: 25
                Layout.rightMargin: 25

            delegate: Rectangle{
                            color: "#FAEBD7"
                             width: parent.width
                            height: 150
                            border.color: "black"

                            radius: 15

                            GridLayout{
                                anchors.fill: parent
                                columns: 3
                                rows: 3

                                Image{
                                    id: img
                                                                source: pict
                                                                Layout.column: 0
                                                                Layout.row: 0
                                                                Layout.rowSpan: 3

                                                                Layout.preferredHeight: 130
                                                                Layout.preferredWidth: 130
                                                                Layout.margins: 5
                                                                fillMode: Image.PreserveAspectFit

                                                                property bool rounded: true
                                                                property bool adapt: true

                                                                layer.enabled: rounded
                                                                layer.effect: OpacityMask {
                                                                    maskSource: Item {
                                                                        width: img.width
                                                                        height: img.height
                                                                        Rectangle {
                                                                            anchors.centerIn: parent
                                                                            width: img.adapt ? img.width : Math.min(img.width, img.height)
                                                                            height: img.adapt ? img.height : width
                                                                            radius: Math.min(width, height)
                                                                        }
                                                                    }
                                                                }
                                }

                                Rectangle{
                                                            id: lBorder2
                                                            Layout.row: 0
                                                            Layout.column: 1
                                                            Layout.rowSpan: 3

                                                            Layout.topMargin: 20
                                                            Layout.bottomMargin: 20
                                                            Layout.leftMargin: 20

                                                            anchors.left: img.right
                                                            anchors.leftMargin: 25

                                                            color: "#191970"
                                                            width: 2
                                                            Layout.fillHeight: true
                                                        }

                                Label {
                                                            color: "#4682B4"
                                                            text: "Домен. имя: " + user_id
                                                            Layout.topMargin: 20
                                                            Layout.column: 2
                                                            Layout.row: 0
                                                            Layout.fillHeight: true
                                                            Layout.preferredWidth: 150

                                                            font.family: "Times New Roman"
                                                            font.pointSize: 11

                                                            anchors.left: lBorder2.right
                                                            anchors.leftMargin: 15
                                                        }

                                                        Label{ // name
                                                            color: "#4682B4"
                                                            text: "Имя: " + name
                                                            Layout.column: 2
                                                            Layout.row: 1
                                                            Layout.fillHeight: true
                                                            Layout.preferredWidth: 150

                                                            font.family: "Times New Roman"
                                                            font.pointSize: 11

                                                            anchors.left: lBorder2.right
                                                            anchors.leftMargin: 15
                                                        }

                                                        Label{ // ID
                                                            color: "#4682B4"
                                                            text: "Фамилия: " + surname
                                                            Layout.column: 2
                                                            Layout.row: 2
                                                            Layout.fillHeight: true
                                                            Layout.preferredWidth: 150

                                                            font.family: "Times New Roman"
                                                            font.pointSize: 11

                                                            anchors.left: lBorder2.right
                                                            anchors.leftMargin: 15
                                                        }
                            }
                        }
                    }
                }
                }
}*/
