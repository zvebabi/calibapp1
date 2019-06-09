import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtCharts 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

RowLayout {
    id: ctrlPane
    spacing: 10*app.dp
    property int itemWidth: 250*app.dp
    Connections {
        target: reciever
        onMakeSeries: {
            createSeries()
        }
    }
    Button {
        id: enableFlyModeBTN
        enabled: true
//                height: 2.3*24*app.dp
        width: 250*app.dp
        contentItem: ButtonLabel {text: qsTr("Fly mode")}
//                ToolTip.visible: hovered
//                    ToolTip.text: qsTr("Enable fly mode")
        onClicked: {
            //debug
//            createSeries()
//            reciever.readData()
            reciever.prepareCommandToSend("duty\r")
            reciever.setFlyMode(true)
        }
    }
    Button {
        id: setZeroLevelBTN
//                height: 2.3*48*app.dp
        width: 250*app.dp
//                ToolTip.visible: hovered
//                    ToolTip.text: qsTr("Set zero level")
        contentItem: ButtonLabel {text: qsTr("Set zero level")}
        onClicked: {
            reciever.prepareCommandToSend("zero\r")
        }
    }
    Switch {
        id: debugModeSwitcher
        text: qsTr("Debug mode")
        onClicked: {
            //TODO: send a signal to reciever to switch between DEBUG/WORK mode
            console.log("position: " + position)
            if (position == 1) {
                reciever.prepareCommandToSend("debug\r")
                reciever.setFlyMode(false)
            }
            else {
                reciever.prepareCommandToSend("work\r")
                reciever.setFlyMode(true)
            }
        }
    }
    function createSeries() {
        var colorList = [
                    "#F44336", "#673AB7", "#03A9F4", "#4CAF50", "#FFEB3B", "#FF5722",
                    "#E91E63", "#3F51B5", "#00BCD4", "#8BC34A", "#FFC107",
                    "#9C27B0", "#2196F3", "#009688", "#CDDC39", "#FF9800"
                ]
        //Umeas
        graph_Umeas.numSeries++;
        var seriesName = qsTr("series_" + graph_Umeas.numSeries)
        graph_Umeas.createSeries(ChartView.SeriesTypeLine,
                            seriesName,
                            axisX_Umeas, axisY_Umeas);
        graph_Umeas.series(seriesName).color = /*colorList[
                    Math.random()*100*( graph_Umeas.numSeries - 1) % colorList.length ]*/"#B71C1C"
        reciever.sendSeriesPointer(graph_Umeas.series(seriesName),graph_Umeas.axisX(seriesName));
        //U_ref
        graph_Uref.numSeries++;
        seriesName = qsTr("series_" + graph_Uref.numSeries)
        graph_Uref.createSeries(ChartView.SeriesTypeLine,
                            seriesName,
                            axisX_Uref, axisY_Uref);
        graph_Uref.series(seriesName).color = /*colorList[
                    Math.random()*100*( graph_Uref.numSeries - 1) % colorList.length ]*/"#B71C1C"
        reciever.sendSeriesPointer(graph_Uref.series(seriesName),graph_Uref.axisX(seriesName));
        //U_pn
        graph_Upn.numSeries++;
        seriesName = qsTr("series_" + graph_Upn.numSeries)
        graph_Upn.createSeries(ChartView.SeriesTypeLine,
                            seriesName,
                            axisX_Upn, axisY_Upn);
        graph_Upn.series(seriesName).color = /*colorList[
                    Math.random()*100*( graph_Upn.numSeries - 1) % colorList.length ]*/"#B71C1C"
        reciever.sendSeriesPointer(graph_Upn.series(seriesName),graph_Upn.axisX(seriesName));
        //Conc
        graph_C.numSeries++;
        seriesName = qsTr("series_" + graph_C.numSeries)
        graph_C.createSeries(ChartView.SeriesTypeLine,
                            seriesName,
                            axisX_C, axisY_C);
        graph_C.series(seriesName).color = /*colorList[
                    Math.random()*100*( graph_C.numSeries - 1) % colorList.length ]*/"#B71C1C"
        reciever.sendSeriesPointer(graph_C.series(seriesName),graph_C.axisX(seriesName));

    }
}
