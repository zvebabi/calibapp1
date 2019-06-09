import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtQuick.Window 2.3
import Qt.labs.platform 1.0
//import QtCharts 2.2
import "QMLs"
import mydevice 1.0

ApplicationWindow {
    id:app
    property string appTitle: "CalibApp"
    property string appVersion: "0.1"
    property alias dp: device.dp
    property real fontPixelSize: 22*app.dp
    visible: true
    width: 960
    height: 540
    minimumWidth: 960
    minimumHeight: 540
    title: appTitle

    Material.theme: Material.Light
    Material.primary: Material.BlueGrey
    Material.accent: Material.Teal

    MyDevice { id: device }

    QtObject {
            id: palette
            //http://www.materialpalette.com/indigo/yellow
            property color darkPrimary: "#303F9F"
            property color primary: "#3F51B5"
            property color lightPrimary: "#C5CAE9"
            property color text: "#FFFFFF"
            property color accent: "#FFEB3B"
            property color primaryText: "#212121"
            property color secondaryText: "#727272"
            property color divider: "#B6B6B6"

            property color currentHighlightItem: "#dcdcdc"
    }
//    property alias currentPage: loader.source
    property int menuWidth : 250*app.dp// width/4
    property int menuBarHeight: 50*app.dp
    property int widthOfSeizure: 15*app.dp
    property real menuProgressOpening
    property bool menuIsShown:
    Math.abs(menuView.x) < (menuWidth*0.5) ? true : false

    Rectangle {
    id: menuBar
    z: 5
    anchors.top: parent.top
    anchors.topMargin: 0
    width: parent.width
    height: app.menuBarHeight
    color:palette.darkPrimary // Material.color(Material.BlueGrey)
    Rectangle {
        id: menuButton
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 1.2*height
        height: parent.height
        scale: maMenuBar.pressed ? 1.2 : 1
        color: "transparent"
        MenuIconLive {
          id: menuBackIcon
          scale: (parent.height/height)*0.65
          anchors.centerIn: parent
          value: menuProgressOpening
        }
        MouseArea {
          id: maMenuBar
          anchors.fill: parent
          onClicked: onMenu()
        }
        clip: true
      }
      Label {
        id: titleText
        anchors.left: menuButton.right
        anchors.verticalCenter: parent.verticalCenter
        text: app.title
        font.pixelSize: 0.35*parent.height
        color: "#FFFFFF"
      }
    } //menuBar

    Rectangle {
        id: menuView
        anchors.top: menuBar.bottom
        height: parent.height - menuBar.height
        width: menuWidth
        z: 3
        MainMenu {
            id: mainMenu
            anchors.fill: parent
            onMenuItemClicked: {
                onMenu()
//                loader.source = page
            }
        }
        x: -menuWidth

//        color: Material.color(Material.Grey)
        Behavior on x {
            NumberAnimation { duration: 500; easing.type: Easing.OutQuad } }
        onXChanged: {
            menuProgressOpening = (1-Math.abs(menuView.x/menuWidth))
        }

        MouseArea {
            anchors.right: parent.right
            anchors.rightMargin: app.menuIsShown ?
                                     (menuWidth - app.width) : -widthOfSeizure
            anchors.top: parent.top
            width: app.menuIsShown ? (app.width - menuWidth) : widthOfSeizure
            height: parent.height
            drag {
                target: menuView
                axis: Drag.XAxis
                minimumX: -menuView.width
                maximumX: 0
            }
            onClicked: {
                if(app.menuIsShown) app.onMenu()
            }
            onReleased: {
                if( Math.abs(menuView.x) > 0.5*menuWidth ) {
                    menuView.x = -menuWidth //close the menu
                } else {
                    menuView.x = 0 //fully opened
                }
            }
        }
    }
    Loader {
        id: loader
        anchors.top: menuBar.bottom;
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        //asynchronous: true
        onStatusChanged: {
            if( status == Loader.Loading ) {
                curtainLoading.visible = true
                titleText.text = appTitle
            } else if( status == Loader.Ready ) {
                curtainLoading.visible = false
            } else if( status == Loader.Error ) {
                curtainLoading.visible = false
            }
        }
        onLoaded: {
            titleText.text = item.title
        }
        Rectangle {
            id: curtainLoading
            anchors.fill: parent
            visible: false
            color: "white"
            opacity: 0.8
            BusyIndicator {
                anchors.centerIn: parent
            }
        }
    }
    function onMenu() {
        menuView.x = app.menuIsShown ? -menuWidth : 0
    }

    Component.onCompleted: {
//        currentPage = "Settings.qml"
        mainMenu.currentItem = 0
    }
    SwipeView {
        id: view
        interactive: false
        ///index fix because line and histigram viewer on same page,
        ///and nmenu numering is different.
        //indexes: 0 - line      - ChartView.qml
        //         1 - settings  - Settings.qml
        //         2 - about     - empty item
                currentIndex: mainMenu.currentItem// < 2 ? 0 : mainMenu.currentItem - 1
        //        currentIndex: mainMenu.currentItem > 0 && mainMenu.currentItem < 3 ?
        //                          1 : mainMenu.currentItem == 0 ? 0 : mainMenu.currentItem - 1
        anchors.fill: parent
        anchors.top: menuBar.Bottom
//        ChartView {
//            id: chV
//        }
        Settings {
        }
        About {
        }
    }
    Label {
        id: statusBar
        text: tipsWithPath.showedText
        color: "steelblue"
        anchors.bottom: parent.bottom
    }

    Popup {
        id: tipsWithPath
        x: app.width/2 - width/2
        y: app.height/2 - height/2
//        width: 200
//        height: 300
//        modal: true
        focus: true
        dim: true
        property string showedText: qsTr("")
        Text {
            id: textInPopup
            anchors.centerIn: tipsWithPath.Center
            text: tipsWithPath.showedText
        }
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    }
//    onClosing: {
//        mainMenu.quitDialogCustom.setVisible(true)
//    }

}
