/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Charts module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.9
import QtCharts 2.0

Rectangle {
    id: legend
    color: "white"

    property int seriesCount: 0
    property variant seriesNames: []
    property variant seriesColors: []
    signal entered(string seriesName)
    signal exited(string seriesName)
    signal selected(string seriesName)

    function addSeries(seriesName, color) {
        var names = seriesNames;
        names[seriesCount] = seriesName;
        seriesNames = names;

        var colors = seriesColors;
        colors[seriesCount] = color;
        seriesColors = colors;

        seriesCount++;
    }
    function removeSeries(seriesName) {
        var names = [];
        var colors = [];
        var j=0;
        for(var i = seriesCount; i>=0 ; i--) {
            if (seriesNames[i] === seriesName) {
                continue;
            }
            names[j] = seriesNames[i];
            colors[j] = seriesColors[i];
            j++;
        }
        seriesNames = names;
        seriesColors = colors;
        seriesCount--;
    }

    //![2]
    Component {
        id: legendDelegate
        Rectangle {
            id: rect
    //![2]
            property string name: seriesNames[index]
            property color markerColor: seriesColors[index]
            radius: 4

            implicitWidth: label.implicitWidth + marker.width + 15*app.dp
            implicitHeight: Math.max(label.implicitHeight + marker.implicitHeight)+ 5*app.dp

            Row {
                id: row
                spacing: 5*app.dp
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 4*app.dp
                Rectangle {
                    id: marker
                    anchors.verticalCenter: parent.verticalCenter
                    color: markerColor
//                    opacity: 0.3
                    radius: 4*app.dp
                    width: 12*app.dp
                    height: 10*app.dp
                }
                Text {
                    id: label
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    text: name
                }
            }
        }
    }

    //![1]
    Grid {
        id: legendRow
        anchors.centerIn: parent
        spacing: 5*app.dp
        columns: 7
        Repeater {
            id: legendRepeater
            model: seriesCount
            delegate: legendDelegate
        }
    }
    //![1]
}
