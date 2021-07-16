import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")

    signal signalMakeRequest();
           signal success (string lab);
           signal failed(string lab);
            signal cancel (string lab);
            signal restRequest();
            signal hashvd(string lab);
    signal btnHTTPRequest()
        signal btnHTTPResponse()
    signal getPhoto();


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

        Page6MAL {
            id: page6MAL
        }

        Page5MAL {
            id: page5MAL
        }

        Page7MAL {
            id: page7MAL
        }

        Page8MAL {
            id: page8MAL
        }

        Page9MAL {
            id: page9MAL
        }


        Page10MAL {
            id: page10MAL
        }
}





    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
        TabButton {
            text: qsTr("Page 3")
        }
        TabButton {
            text: qsTr("Page 4")
        }
        TabButton {
            text: qsTr("Page 5")
        }
        TabButton {
            text: qsTr("Page 6")
        }
    }
}
