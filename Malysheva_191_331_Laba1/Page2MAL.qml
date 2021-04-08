import QtQuick 2.12
import QtQml.Models 2.2
import QtQml 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.12
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

Page {

    id:page2MAL
       header : Rectangle {
       id: header
       color: "#1d2027"
       height: 100


       Image {
         id:movie
         source:"video.jpg"
         width: 110
         height: 80
         anchors.top:header.top
         anchors.topMargin: 10
         anchors.right: header.right
         anchors.rightMargin: 10
       }


       Label {
           color: "#ffffff"
          text: "Запись и воспроизведение
фото и видео"
          anchors.verticalCenter: movie.verticalCenter
          anchors.left: parent.left
          font.styleName: "Полужирный Курсив"
          font.weight: Font.Medium
          font.pointSize: 17
          font.family: "Times New Roman"
          //anchors.leftMargin: 30
          leftPadding: movie.indicator.width + movie.spacing

       }
   }


    GridLayout{ //расположение сетки по краям
        // @disable-check M16
        y: 299
        // @disable-check M16
        height: 2
        // @disable-check M16
        anchors.bottom: parent.bottom
        // @disable-check M16
        anchors.bottomMargin: 0
        // @disable-check M16
        anchors.top: parent.top
        // @disable-check M16
        anchors.topMargin: 0
        // @disable-check M16
        anchors.right: parent.right
        // @disable-check M16
        anchors.rightMargin: 0
        // @disable-check M16
        anchors.left: parent.left
        // @disable-check M16
        anchors.leftMargin: 0

        columns: 3
        rows: 4
        Rectangle {
            id: rectangle11
            color: "#002137"
            anchors.topMargin: 0
            anchors.fill: parent


        }
        RowLayout{
            //Layout.topMargin: 90
            Layout.columnSpan:3
            Layout.row:0
            Layout.alignment: Qt.AlignCenter



            RadioButton {
                id: control
                text: qsTr("Movie")
                checked: true



                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control.down ? "#4682B4" : "#4682B4"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: control.indicator.width + control.spacing
                }
                onClicked: { //переключение на видео
                    columnlay1.visible = true     //оотображение видео
                    mediaplayer.playbackState === mediaplayer.play()
                    columnlay2.visible=false
                    button.visible=true
                    videoSlider.visible =true
                    volumeSlider.visible=true
                    positionLabel.visible=true
                    camera.stop()
                    buttoncamera.visible=false
                    openButton.visible=true

                }
            }
            RadioButton { //переключение на камеру
                id: control1
                text: qsTr("Camera")
                checked: false
                contentItem: Text {
                    text: control1.text
                    font: control1.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control1.down ? "#4682B4" : "#4682B4"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: control1.indicator.width + control1.spacing
                }
                onClicked: {
                    columnlay1.visible = false
                    mediaplayer.playbackState === mediaplayer.pause()
                    columnlay2.visible=true
                    camera.start()
                    button.visible=false
                    videoSlider.visible =false
                    volumeSlider.visible=false
                    positionLabel.visible=false
                    buttoncamera.visible=true
                    openButton.visible=false
                }
            }


        }
        ColumnLayout{
            id:columnlay1
            Layout.topMargin: 30
            Layout.columnSpan: 3
            Layout.row: 1
           // anchors.horizontalCenter: avanture.horizontalCenter
            Layout.alignment: Qt.AlignCenter



            MediaPlayer {  //видео
                id: mediaplayer

                source: "sample.mp4"
                volume: volumeSlider.volume
            }

            VideoOutput { //вывод видео
                Layout.fillWidth: true
                source: mediaplayer
                id:videooutput

            }

            MouseArea {
                id: playArea
                anchors.fill: parent
                onPressed: mediaplayer.play();
            }

        }
        ColumnLayout{
            id:columnlay2
            // @disable-check M16
            visible: false
            Layout.columnSpan: 3
            Layout.row: 1

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight:  true



                Camera {
                    id:  camera
                    captureMode: stop()
                    imageCapture {
                        onImageCaptured: {
                            // показывает превью скрина
                            photoPreview1.source = preview
                        }
                    }
                }

                VideoOutput {     //фото
                    id: videoCam
                    autoOrientation: true
                    source:  camera
                    focus :  visible
                    anchors.fill: parent
                }



                Image {
                    Layout.column: 1
                    Layout.row: 0
                    id:  photoPreview1
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 150
                    width: 200
                }
                MouseArea{

                }

            }
        }
        RowLayout{ //вывод фотографии в папку
            Layout.alignment: Qt.AlignCenter

            Layout.columnSpan: 3
            Layout.row: 3
            Button{
                visible: false
                id:buttoncamera
                onClicked: camera.imageCapture.capture()
                text: "Photo"
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    color: "#4682B4"
                    border.color: control.down ? "#4682B4" : "#4682B4"
                    border.width: 1
                    radius: 5
                }
            }


        }





        //бегунок
        Slider{
            Layout.columnSpan: 3
            Layout.row: 2
            Layout.fillWidth: true
            id:videoSlider
            to: mediaplayer.duration
            property bool sync: false
            onValueChanged: {
                if (!sync)
                    mediaplayer.seek(value)
            }
            Connections{
                target: mediaplayer
                onPositionChanged: {
                    videoSlider.sync = true
                    videoSlider.value = mediaplayer.position
                    videoSlider.sync = false
                }
            }

        }
        // кнопки старта и паузы
        Button{

            Layout.margins: 10
            Layout.column: 0
            Layout.row: 3
            id:button
            enabled: mediaplayer.hasVideo
            Layout.preferredWidth: button.implicitHeight
            text: mediaplayer.playbackState === MediaPlayer.PlayingState ? "❙❙" : "►"
            onClicked: mediaplayer.playbackState === MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()


            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 60
                color: "#800080"
                border.color: control.down ? "#800080" : "#800080"
                border.width: 1
                radius: 5
            }
        }
        //слайдер звука
        Slider{
            Layout.column: 1
            Layout.row: 3
            id: volumeSlider
            property real volume: QtMultimedia.convertVolume(volumeSlider.value,
                                                             QtMultimedia.LogarithmicVolumeScale,
                                                             QtMultimedia.LinearVolumeScale)
        }


        RowLayout{
            Layout.column: 2
            Layout.row: 3
            Button{


                id: openButton

                text: qsTr("Open")
                Layout.preferredWidth: openButton.implicitHeight
                onClicked: fileDialog.open()

                FileDialog {
                    id: fileDialog

                    folder : videoUrl
                    title: qsTr("Open")
                    nameFilters: [qsTr("MP4 files (*.mp4)"), qsTr("All files (*.*)")]
                    onAccepted: mediaplayer.source = fileDialog.fileUrl
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 60
                    color: "#800080"
                    border.color: control.down ? "#800080" : "#800080"
                    border.width: 1
                    radius: 5
                }

            }

            Label{  //кнопка фото, расположение скриншота сверху
                id:positionLabel
                readonly property int minutes: Math.floor(mediaplayer.position / 60000)
                readonly property int seconds: Math.round((mediaplayer.position % 60000) / 1000)
                text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
            }
        }


    }

}
