import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    Column {
        id: aboutLines
        spacing: 5*app.dp
//        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 100*app.dp
        anchors.top: parent.top
        anchors.rightMargin: 50*app.dp
        property int itemsWidth: 250*app.dp
        Label { text: qsTr(app.title)
        }
        Label { text: qsTr("Software version: "
                         + app.appVersion)
        }
        Label { text: qsTr("Developer web-site: "
                         + "<a href='http://www.lmsnt.com'>"
                         + "www.lmsnt.com"
                         + "</a>")
                onLinkActivated: Qt.openUrlExternally(link)
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
                    cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
        }
        Label { text: qsTr("Copyright © "
                         + "LED Microsensor NT & "
                         + "Microsensor Technology, "
                         + "2018 ")
        }
    }
//    Software version: xxx
//    Copyright  LED Microsensor NT & Microsensor Technology, 2018
//    Developer web-site: www.lmsnt.com
}
