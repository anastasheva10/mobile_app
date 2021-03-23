import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 750
    visible: true
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1MAL {
            id: page1MAL
        }

        Page2MAL {
            id: page2MAL
        }



        Page3MAL {
            id: page3MAL
        }


        Page4MAL {
            id: page4MAL
        }

}





    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Lab_1")
        }
        TabButton {
            text: qsTr("Lab_2")
        }
        TabButton {
            text: qsTr("Lab_3")
        }
        TabButton {
            text: qsTr("Lab_4")
        }
    }
}
