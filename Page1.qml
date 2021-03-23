import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    id: page1
    header : Label {
        text: "ЛР1"}
    font.pixelSize: Qt.application.font.pixelSize * 2
    padding: 10
    Label{ text: "Привет!"
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
    }

}
