import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCharts 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import "QMLs"

Item {
    //save names here
    property variant allSeriesName
    property alias editBar_a: editBar
    Connections {
        target: reciever
        onAdjustAxis: {
            axisY_Umeas.min = axisYRange_Umeas.x
            axisY_Umeas.max = axisYRange_Umeas.y

            axisY_Uref.min = axisYRange_Uref.x
            axisY_Uref.max = axisYRange_Uref.y

            axisY_Upn.min = axisYRange_Upn.x
            axisY_Upn.max = axisYRange_Upn.y

            axisY_C.min = axisYRange_C.x
            axisY_C.max = axisYRange_C.y
        }
        onSendDebugInfo: {
            showPopupTips(qsTr(data), time)
        }
        onSendDataToUI: {
            uMeasMean.text = Math.round(_mean.x*10000)/10000
            uMeasSD.text   = Math.round(_mean.y*10000)/10000
            uRefMean.text  = Math.round(_ref.x *10000)/10000
            uRefSD.text    = Math.round(_ref.y *10000)/10000
            uPnMean.text   = Math.round(_pn.x  *10000)/10000
            uPnSD.text     = Math.round(_pn.y  *10000)/10000
        }
    }
    RowLayout{
        spacing: 10*app.dp
        anchors.top: menuBar.bottom
        anchors.fill: parent
//        anchors.margins: 10*app.dp
        anchors.topMargin: menuBar.height//+10*app.dp
        ColumnLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop// | Qt.AlignBottom
//            Layout.preferredHeight: app.height - menuBar.height
            Layout.leftMargin: 10*app.dp
            spacing: 10*app.dp
//            anchors.top: menuBar.bottom
//            anchors.fill: parent
//            anchors.margins: 10*app.dp
//            anchors.topMargin: menuBar.height+10*app.dp
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: colForSnap
                spacing:0
                Rectangle {
                    color: "transparent"
                    Layout.preferredHeight: (app.height - menuBar.height) / 4
                    Layout.preferredWidth: app.width/2
                    ChartView {
                        id: graph_Umeas
                        visible: true
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        property int numSeries : 0 //current number of graphs
                        property real minRngX: 0.0
                        property real maxRngX: 0.0
                        property real minRngY: 0.0
                        property real maxRngY: 0.0
                        ValueAxis {
                            id: axisX_Umeas
                            visible:false
                            objectName: "axisX_Umeas"
                            titleText: qsTr("Time")
                            min: 410
                            max: 500
                            tickCount: 13
                            minorTickCount: 3
                            labelFormat: "%.1f"
                        }
                        ValueAxis {
                            id: axisY_Umeas
                            objectName: "axisY_Umeas"
    //                        titleText: app.yAxisName
                            min: 0.9
                            max:1.1
                            tickCount: 5
                            minorTickCount: 4
                        }
                        MouseArea {
                            anchors.fill: parent
                            property int lastX: 0
                            property int lastY: 0
                            onPressed: {
                                lastX = mouse.x
                                lastY = mouse.y
                            }
                            onReleased: {
            //                    view.interactive : true
                            }
                            onPositionChanged: {
                                if (lastX !== mouse.x) {
                                    graphs.scrollRight(lastX - mouse.x)
                                    lastX = mouse.x
                                }
                                if (lastY !== mouse.y) {
                                    graphs.scrollDown(lastY - mouse.y)
                                    lastY = mouse.y
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    color: "transparent"
                    Layout.preferredHeight: (app.height - menuBar.height) / 4
                    Layout.preferredWidth: app.width/2
                    ChartView {
                        id: graph_Uref
                        visible: true
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        property int numSeries : 0 //current number of graphs
                        property real minRngX: 0.0
                        property real maxRngX: 0.0
                        property real minRngY: 0.0
                        property real maxRngY: 0.0
                        ValueAxis {
                            id: axisX_Uref
                            visible:false
                            objectName: "axisX_Uref"
                            titleText: qsTr("Time")
                            min: 410
                            max: 500
                            tickCount: 13
                            minorTickCount: 3
                            labelFormat: "%.1f"
                        }
                        ValueAxis {
                            id: axisY_Uref
                            objectName: "axisY_Uref"
    //                        titleText: app.yAxisName
                            min: 0.9
                            max:1.1
                            tickCount: 5
                            minorTickCount: 4
                        }
                        MouseArea {
                            anchors.fill: parent
                            property int lastX: 0
                            property int lastY: 0
                            onPressed: {
                                lastX = mouse.x
                                lastY = mouse.y
                            }
                            onReleased: {
            //                    view.interactive : true
                            }
                            onPositionChanged: {
                                if (lastX !== mouse.x) {
                                    graphs.scrollRight(lastX - mouse.x)
                                    lastX = mouse.x
                                }
                                if (lastY !== mouse.y) {
                                    graphs.scrollDown(lastY - mouse.y)
                                    lastY = mouse.y
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    color: "transparent"
                    Layout.preferredHeight: (app.height - menuBar.height) / 4
                    Layout.preferredWidth: app.width/2
                    ChartView {
                        id: graph_Upn
                        visible: true
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        property int numSeries : 0 //current number of graphs
                        property real minRngX: 0.0
                        property real maxRngX: 0.0
                        property real minRngY: 0.0
                        property real maxRngY: 0.0
                        ValueAxis {
                            id: axisX_Upn
                            visible: false
                            objectName: "axisX_Upn"
                            titleText: qsTr("Time")
                            min: 410
                            max: 500
                            tickCount: 13
                            minorTickCount: 3
                            labelFormat: "%.1f"
                        }
                        ValueAxis {
                            id: axisY_Upn
                            objectName: "axisY_Upn"
    //                        titleText: app.yAxisName
                            min: 0.9
                            max:1.1
                            tickCount: 5
                            minorTickCount: 4
                        }
                        MouseArea {
                            anchors.fill: parent
                            property int lastX: 0
                            property int lastY: 0
                            onPressed: {
                                lastX = mouse.x
                                lastY = mouse.y
                            }
                            onReleased: {
            //                    view.interactive : true
                            }
                            onPositionChanged: {
                                if (lastX !== mouse.x) {
                                    graphs.scrollRight(lastX - mouse.x)
                                    lastX = mouse.x
                                }
                                if (lastY !== mouse.y) {
                                    graphs.scrollDown(lastY - mouse.y)
                                    lastY = mouse.y
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    color: "transparent"
                    Layout.preferredHeight: (app.height - menuBar.height) / 4
                    Layout.preferredWidth: app.width/2
                    ChartView {
                        id: graph_C
                        visible: true
                        anchors.fill: parent
                        antialiasing: true
                        legend.visible: false
                        property int numSeries : 0 //current number of graphs
                        property real minRngX: 0.0
                        property real maxRngX: 0.0
                        property real minRngY: 0.0
                        property real maxRngY: 0.0
                        ValueAxis {
                            id: axisX_C
                            objectName: "axisX_C"
                            titleText: qsTr("Time")
                            min: 410
                            max: 500
                            tickCount: 13
                            minorTickCount: 3
                            labelFormat: "%.1f"
                        }
                        ValueAxis {
                            id: axisY_C
                            objectName: "axisY_C"
    //                        titleText: app.yAxisName
                            min: 0.025
                            max: 0.035
                            tickCount: 5
                            minorTickCount: 4
                        }
                        MouseArea {
                            anchors.fill: parent
                            property int lastX: 0
                            property int lastY: 0
                            onPressed: {
                                lastX = mouse.x
                                lastY = mouse.y
                            }
                            onReleased: {
            //                    view.interactive : true
                            }
                            onPositionChanged: {
                                if (lastX !== mouse.x) {
                                    graphs.scrollRight(lastX - mouse.x)
                                    lastX = mouse.x
                                }
                                if (lastY !== mouse.y) {
                                    graphs.scrollDown(lastY - mouse.y)
                                    lastY = mouse.y
                                }
                            }
                        }
                    }
                }
    //            Rectangle {
    //                color: "transparent"
    //                Layout.height: app.height/5
    //                Layout.width: app.width/3
    //            ListView {
    //                    z:1
    //                    id: textData
    //                    anchors.bottom: parent.bottom
    //                    anchors.left: parent.left
    //                    anchors.margins: 100*app.dp
    //                    height: app.fontPixelSize * 1.5 * count
    //                    width: parent.width - 20*app.dp
    //                    model: availableData
    //                    delegate: Text {
    //                        text: data_
    //                        color: palette.darkPrimary
    //                        opacity: 0.7
    //                        font.pixelSize: app.fontPixelSize
    //                    }
    //                    ListModel {
    //                        id: availableData
    ////                        ListElement { data_: qsTr("testElement0")}
    ////                        ListElement { data_: qsTr("testElement1")}
    ////                        ListElement { data_: qsTr("testElement2")}
    ////                        ListElement { data_: qsTr("testElement3")}
    //                    }
    //                }
    //            }
            }
            ChartViewEditBar {
                id: editBar
                visible: false
                Layout.alignment: Qt.AlignHCenter |Qt.AlignBottom

            }
        }
        ColumnLayout {
            id: controlPanelLayout
            Layout.alignment:  Qt.AlignTop
            Layout.rightMargin: 10*app.dp
            RowLayout{
            ColumnLayout{
                RowLayout {
                    Button {
                        id: startMeasureAverage
                        enabled: true
                        contentItem: ButtonLabel {text: qsTr("StartMeasureAverage")}
                        onClicked: {
                            reciever.prepareCommandToSend("duty\r")
                            reciever.setFlyMode(true,sampleSize.text)
                        }
                    }
                    Button {
                        id: writeToFile1
                        enabled: true
                        contentItem: ButtonLabel {text: qsTr("WriteToFile#1")}
                        onClicked: {
                            if(serialNumber_tf.text.length < 2)
                            {
                                showPopupTips(qsTr("Enter serial number(minimum2 character)"), 1500)
                            } else {
                            reciever.writeToFileOne(true
                                    ,currentTemperature_tf.text
                                    ,gasConc_tf.text
                                    ,serialNumber_tf.text)
                            }
                        }
                    }
                }
                TextField {
                    id: sampleSize
                    validator: IntValidator {bottom: 1; top: 300;}
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Sample Size")
                    text:qsTr("20")
                    placeholderText: "Sample Size"
                }
                GridLayout {
                    columns: 2
    //                height: 3
                    TextField {
                        id: uMeasMean
                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("Measured value")
                        placeholderText: "uMeasMean"
                    }
                    TextField {
                        id: uMeasSD
                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("StDev")
                        placeholderText: "uMeasSD"
                    }
                    TextField {
                        id: uRefMean
                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("Reference")
                        placeholderText: "uRefMean"
                    }
                    TextField {
                        id: uRefSD
                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("StDev")
                        placeholderText: "uRefSD"
                    }
                    TextField {
                        id: uPnMean
                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("Pn")
                        placeholderText: "uPnMean"
                    }
                    TextField {
                        id: uPnSD
                        ToolTip.visible: hovered
                        ToolTip.text: qsTr("StDev")
                        placeholderText: "uPnSD"
                    }
                }
            }
            ColumnLayout{
                TextField {
                    id: currentTemperature_tf
                    validator: IntValidator {bottom: -100; top: 400;}
                    text:qsTr("23")
                    placeholderText: "Temp"
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Temperature")
                }
                TextField {
                    id: gasConc_tf
                    text:qsTr("0")
                    placeholderText: "Conc"
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Gas conc.")
                    validator: DoubleValidator {
                        bottom: 0;
                        top: 99999;
                        decimals: 10;
                        notation: "StandardNotation"

                    }
                }

            }
            }
            RowLayout{
                TextField {
                    id: serialNumber_tf
                    visible: true
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Serial Number")
                    placeholderText: "Serial Number"
//                    text:reciever.getDataPath()
                    font.family: "DejaVu Sans Mono"
                    font.pixelSize: app.fontPixelSize
                    readOnly: false
                    selectByMouse: true
                }
            }
            RowLayout{
                TextField {
                    id: sampleSize2_tf
                    text:"100"
                    validator: IntValidator {bottom: 1; top: 300;}
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Sample Size#2")
                    placeholderText: "Sample Size 2"
                }
                TextField {
                    id: writeDelay_tf
                    text:"5"
                    validator: IntValidator {bottom: 1; top: 120;}
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Write delay, min")
                    placeholderText: "Write Delay"
                }
            }
            RowLayout {
                Switch {
                    id: writeToFileSwitcher
                    text: qsTr("WriteModeOff")
                    onClicked: {
                        //TODO: send a signal to reciever to switch between DEBUG/WORK mode
                        console.log("position: " + position)
                        if (position == 1) {
                            if(serialNumber_tf.text.length < 2) {
                                showPopupTips(qsTr("Enter serial number(minimum2 character)"), 1500)
                            } else {
                                writeToFileSwitcher.text = qsTr("WriteModeOn")
                                reciever.enableLogging(sampleSize2_tf.text, writeDelay_tf.text)
                            }
                        }
                        else {
                            writeToFileSwitcher.text = qsTr("WriteModeOff")
                            reciever.disableLogging();
                        }
                    }
                }
                Button {
                    id: purifatorBtn
                    enabled: true
                    contentItem: ButtonLabel {text: qsTr("Reset graphs")}
                    onClicked: {
                        reciever.clearAllData()
                    }
                }
            }
            RowLayout {
                TextField {
                    id: setHistoryViewTf
                    validator: DoubleValidator {
                        bottom: 1
                        top: 196
                        decimals: 2
                        notation: "StandardNotation"
                    }
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("Time axis width, max 196 hours")
                    text:qsTr("3")
                }
                Button {
                    id: setHistoryViewBtn
                    enabled: true
                    contentItem: ButtonLabel {text: qsTr("Set Time Axis")}
                    onClicked: {
                        reciever.setHistoryView(setHistoryViewTf.text)
                    }
                }

            }
        }
    }
    Timer {
        id: timer1
    }
    Timer {
        id: timer2
    }
    function delay(delayTime, cb) {
        timer1.interval = delayTime;
        timer1.repeat = false;
        timer1.triggered.connect(cb);
        timer1.start();
    }
    function createAxis(min, max) {
        // The following creates a ValueAxis object that can be then
        //set as a x or y axis for a series
        return Qt.createQmlObject("import QtQuick 2.7;
                                   import QtCharts 2.7;
                                   ValueAxis { min: "
                                  + min + "; max: " + max + " }", graphs);
    }
    function showPopupTips(text, dTime) {
        tipsWithPath.showedText = qsTr(text)
        tipsWithPath.open()
        delay(dTime !== undefined ? dTime : 300, tipsWithPath.close)
    }
}

