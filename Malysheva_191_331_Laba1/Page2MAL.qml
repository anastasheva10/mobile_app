import QtQuick 2.12
import QtQml.Models 2.2
import QtQml 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.12
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.15 //MediaPlayer

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
          leftPadding: movie.indicator.width + movie.spacing
       }
   }

       ColumnLayout{
               anchors.fill: parent

               RowLayout {
                   id: choose_buttons
                   anchors.top: parent.top
                   anchors.topMargin: 5
                   anchors.bottomMargin: 5
                   Layout.alignment: Qt.AlignCenter

                   RadioButton {
                       id: videoBtn
                       checked: true
                       text: "Movie"
                       Material.accent: "#76b947"
                   }

                   RadioButton {
                       id: photoBtn
                       text: "Photo"
                       Material.accent: "#76b947"
                   }
               }

               //выбор видео

               RowLayout {

                   Layout.alignment: Qt.AlignCenter

                   Button {
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
                           implicitWidth: 200
                          implicitHeight: 60

                           color: "#800080"
                           border.color: control.down ? "#800080" : "#800080"
                           border.width: 1
                           radius: 5
                       }

                   }
               }

               ColumnLayout{
                   id: page1

                   Rectangle {
                       id: videoArea
                       anchors.bottomMargin: 30
                       anchors.rightMargin: 10
                       anchors.leftMargin: 10
                       anchors.fill: page1
                       color: "#800080"

                       Item {
                           id: videoOutput
                           height: videoArea.height
                           width: videoArea.width

                           //Исчезновение панельки со слайдерами и паузой
                           Timer {
                               id: video_timer
                               interval: 5000
                               running: true
                               repeat: true
                               onTriggered: navigationPanel.visible = false
                           }

                           MediaPlayer {
                               id: mediaplayer
                               source: "sample.mp4"
                               volume: volumeSlider.volume
                               loops: MediaPlayer.Infinite // бесконечное повторение
                           }

                           VideoOutput {
                               anchors.fill: parent
                               source: mediaplayer
                               flushMode: VideoOutput.FirstFrame
                           }

                           //Пауза по нажатию на видео
                           MouseArea {
                               id: tap_on
                               anchors.fill: parent
                               onPressed: {
                                   mediaplayer.playbackState == MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()
                                   navigationPanel.visible = true
                                   video_timer.restart()
                               }
                           }

                           visible: {
                               if(videoBtn.checked == true) {
                                   navigationPanel.visible = true
                                   return true
                               }
                               else {
                                   mediaplayer.pause()
                                   navigationPanel.visible = false
                               }
                           }
                       }

                      Item {
                           id: page2
                           anchors.fill: parent
                           anchors.verticalCenter: parent.verticalCenter
                           Camera {
                               id: camera
                           }
                           VideoOutput {
                               source: camera
                               anchors.fill: parent
                               autoOrientation: true
                           }
                           visible: {
                               if(photoBtn.checked == true) {
                                   return true
                               }
                               else {
                                   return false
                               }
                           }
                       }
                   }
               }

                ColumnLayout {
                   id: navigationPanel
                   RowLayout {
                       Button {
                           id: start_stop
                           anchors.leftMargin: 10
                           anchors.left:parent.left
                           icon.source: {
                               if (MediaPlayer.PlayingState == mediaplayer.playbackState) {
                                   return "pause.png"
                               }
                               else {
                                   return "play.png"
                               }
                           }
                           onClicked: {
                               if (mediaplayer.playbackState == MediaPlayer.PlayingState) {
                                   return mediaplayer.pause();
                               }
                               else {
                                   return mediaplayer.play();
                               }
                       }
                   }
                       Slider {
                           id: video_slider
                           to: mediaplayer.duration //продолжительность видео
                           value: mediaplayer.position
                           Material.accent: "#76b947"
                           Layout.fillWidth: true
                           onPressedChanged: {
                           mediaplayer.seek(video_slider.value)
                           }
                       }

                       Text {
                           id: timer_video_num
                           anchors.right: parent.right
                           anchors.rightMargin: 10
                           font.pointSize: 10
                           color: "#800080"
                           text: Qt.formatTime(new Date(mediaplayer.position), "mm:ss")
                       }
                   }
                   RowLayout {
                       Layout.alignment: Qt.AlignCenter
                       anchors.bottomMargin: 20
                       Slider {
                           id: volumeSlider
                           Material.accent: "#76b947"
                           from: 0
                           to: 1
                           value: 0.3

                           Image {
                               width: 30
                               height: 30
                               anchors.right: volumeSlider.left
                           }
                           Layout.maximumWidth: 150
                           Layout.minimumWidth: 70
                           Layout.fillWidth: true

                           property real volume: QtMultimedia.convertVolume(volumeSlider.value,
                           QtMultimedia.LogarithmicVolumeScale, QtMultimedia.LinearVolumeScale)
                       }
                   }
                   visible: {
                     mediaplayer.pause()
                     if(videoBtn.checked == true) {
                        return true
                     }
                     else {
                         return false
                     }
                   }
                }

               ColumnLayout{
                   Layout.alignment: Qt.AlignCenter
                   RowLayout {
                       Button{
                           id: take_photo
                           onClicked: camera.imageCapture.capture();
                       }
                       Button{
                           id: start_stop_record_video
                           icon.source: {
                               if (camera.videoRecorder.recorderStatus == CameraRecorder.RecordingStatus)
                                       return "pause.png"

                                   else
                                       return "play.png"

                           }
                           onClicked: {
                               if (camera.videoRecorder.recorderState == CameraRecorder.StoppedState){
                                   camera.videoRecorder.outputLocation = "C:\\";
                                   camera.videoRecorder.record()
                               }
                               else {
                                   camera.videoRecorder.stop()
                               }
                           }
                       }
                   }

                   visible: {
                       if(photoBtn.checked == true)
                           return true
                       else
                           return false
                     }
               }
         }
}
