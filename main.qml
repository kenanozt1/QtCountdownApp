import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.15
import "./Component"
import "./dialogs"
ApplicationWindow{
    id:mainWindow
    width: 1024
    height: 600
    visible: true
    title: qsTr("Countdown App")

    property date nextDateTime : new Date(countdownController.getDatetime())

    FontLoader {
        id: sevenSegmentFont
        source: "qrc:/assets/Seven Segment.ttf"
    }
    Rectangle{
        id:backgroundColor
        anchors.fill: parent
        color: GlobalObjects.backgroundColor
    }
    Row{
        anchors.fill: parent
        anchors.margins: GlobalObjects.boxMargin*2
        spacing:GlobalObjects.boxSpace
        Rectangle{
            id:boxLeft
            width: (parent.width/2)-GlobalObjects.boxMargin
            height: parent.height
            color:GlobalObjects.backgroundColorBox
            radius:GlobalObjects.boxSpace
            smooth: true
            layer.enabled: true
            layer.effect: DropShadow {
                anchors.fill: boxLeft
                horizontalOffset: 0
                verticalOffset: 4
                radius: GlobalObjects.boxSpace
                color: GlobalObjects.boxShadowColor
                samples: 16
            }
            Column{
                anchors.fill: parent
                spacing:GlobalObjects.boxSpace*1.5
                Rectangle{
                    width: parent.width
                    height: 60
                    color:"transparent"
                    Text {
                        id:remainingTimeTitle
                        width:parent.width
                        text: qsTr("Remaining Time")
                        font.pixelSize: 36
                        color: GlobalObjects.remainingTimeTitleColor
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                DateLabel{
                    id:labelYear
                    text:"2 YEAR"
                }
                DateLabel{
                    id:labelMonth
                    text:"2 MONTH"
                }
                DateLabel{
                    id:labelDay
                    text:"2 DAY"
                }
                DateLabel{
                    id:labelHour
                    text:"2 HOUR"
                }
                DateLabel{
                    id:labelMinute
                    text:"2 MINUTE"
                }
                DateLabel{
                    id:labelSecond
                    text:"2 SECOND"
                }
            }
        }
        Rectangle{
            id:boxRight
            width: (parent.width/2)-GlobalObjects.boxMargin
            height: parent.height
            color:GlobalObjects.backgroundColorBox
            radius:GlobalObjects.boxSpace
            smooth: true
            layer.enabled: true
            layer.effect: DropShadow {
                anchors.fill: boxRight
                horizontalOffset: 0
                verticalOffset: 4
                radius: GlobalObjects.boxSpace
                color: GlobalObjects.boxShadowColor
                samples: 16
            }
            Button{
                id:screenModeButton
                width: parent.width*0.3
                height: 30
                buttonColor: GlobalObjects.backgroundColorReverse
                anchors.right:parent.right
                anchors.top:parent.top
                anchors.margins: GlobalObjects.boxMargin
                text: GlobalObjects.screenMode !== "dark" ? 'Dark Mode' : 'Light Mode'
                textColor: GlobalObjects.remainingTimeTitleColorReverse
                size: "24"
                action: function(){
                    GlobalObjects.screenMode = GlobalObjects.screenMode == "dark" ? "light" : "dark"
                    countdownController.setScreenMode(GlobalObjects.screenMode)
                    selectedDatetime.color = GlobalObjects.selectedDatetimeColor
                }
            }

            DateLabel{
                id:currentTime
                text:Qt.formatTime(new Date(),"hh:mm:ss")
                size:"56"
                height: 80
                anchors.top:parent.top
                anchors.topMargin: parent.height*0.2
            }
            Text {
                id: currentDate
                width:parent.width
                text:Qt.formatDate(new Date(),"dd/MM/yyyy")
                color:GlobalObjects.remainingTimeTitleColor
                font.pixelSize: 36
                font.family: sevenSegmentFont.name
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top:currentTime.bottom
                anchors.margins: GlobalObjects.boxMargin*4
            }
            Button{
                id:changeDatetimeRect
                width: parent.width*0.9
                height: 60
                anchors.top:currentDate.bottom
                anchors.margins: GlobalObjects.boxMargin*5
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Change Datetime"
                action: function(){
                    updateDialog.openPopup()

                }
            }

            Text {
                id: selectedDatetime
                width:parent.width
                text:"Selected Datetime : "+Qt.formatDateTime(nextDateTime,"dd/MM/yyyy hh:mm:ss")
                color:GlobalObjects.selectedDatetimeColor
                font.pixelSize: 24
                font.family: sevenSegmentFont.name
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.bottom: parent.bottom
            }
        }
    }
    DatetimeUpdateDialog{
        id:updateDialog
        onResult: {
            if(res === "changed"){
                nextDateTime = new Date(countdownController.getDatetime())
            }
        }
    }

    Component.onCompleted: {
        calculateRemainingTime();
    }
    Timer {
        interval: 1000;
        running: true;
        repeat: true
        onTriggered: {
            calculateRemainingTime();
            currentTime.text = Qt.formatTime(new Date(),"hh:mm:ss");
            currentDate.text = Qt.formatDate(new Date(),"dd/MM/yyyy");
        }
    }
    function calculateRemainingTime() {
        var current = new Date();

        var years = nextDateTime.getFullYear() - current.getFullYear();
        var months = nextDateTime.getMonth() - current.getMonth();
        var days = nextDateTime.getDate() - current.getDate();
        var hours = nextDateTime.getHours() - current.getHours();
        var minutes = nextDateTime.getMinutes() - current.getMinutes();
        var seconds = nextDateTime.getSeconds() - current.getSeconds();

        if (seconds < 0) {
            seconds += 60;
            minutes -= 1;
        }
        if (minutes < 0) {
            minutes += 60;
            hours -= 1;
        }
        if (hours < 0) {
            hours += 24;
            days -= 1;
        }
        if (days < 0) {
            var prevMonth = new Date(current.getFullYear(), current.getMonth(), 0);
            days += prevMonth.getDate();
            months -= 1;
        }
        if (months < 0) {
            months += 12;
            years -= 1;
        }

        labelYear.text = years + " year";
        labelMonth.text = months + " month";
        labelDay.text = days + " day";
        labelHour.text = hours + " hour";
        labelMinute.text = minutes + " minute";
        labelSecond.text = seconds + " second";
    }
}


































