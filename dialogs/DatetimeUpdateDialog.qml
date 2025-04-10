import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../Component"
import "../"
Popup{
    signal result(string res)
    id:updatePopup
    width:parent.width
    height: parent.height
    background: Rectangle{
        anchors.fill: parent
        color:"lightgray"
        opacity:0.4
        MouseArea{
            anchors.fill: parent
            onClicked: {
                closePopup()
            }
        }
    }
    Rectangle{
        id:dialogBox
        width:parent.width/2
        height: parent.height/2
        anchors.centerIn: parent
        color:GlobalObjects.backgroundColorBox
        radius: GlobalObjects.boxMargin
        layer.enabled: true
        layer.effect: DropShadow {
            anchors.fill: dialogBox
            horizontalOffset: 0
            verticalOffset: 4
            radius: GlobalObjects.boxSpace
            color: GlobalObjects.boxShadowColor
            samples: 16
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                //
            }
        }
        Rectangle{
            id:rectInputs
            width:parent.width
            height:parent.height*0.6
            color:"transparent"
            TextInput{
                id:date
                text: countdownController.getDatetime() ? Qt.formatDate(countdownController.getDatetime(),"dd/MM/yyyy") :  "28/06/"+Qt.formatDate(new Date(),"yyyy")
                mask: "00/00/0000"
                anchors.top:parent.top
                anchors.margins: 15
            }
            TextInput{
                id:time
                text: countdownController.getDatetime() ? Qt.formatTime(countdownController.getDatetime(),"HH:mm:ss") : "19:00:00"
                mask: "00:00:00"
                anchors.top:date.bottom
                anchors.margins: 15
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height-rectInputs.height
            anchors.top: rectInputs.bottom
            color:"transparent"
            Button{
                id:cancelButton
                text:"Cancel"
                widthButton: (parent.width/2)-(GlobalObjects.boxSpace*1.5)
                heightButton: parent.height*0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.margins: GlobalObjects.boxSpace
                action: function(){
                    closePopup()
                }
            }
            Button{
                id:acceptButton
                text:"Save"
                widthButton: (parent.width/2)-(GlobalObjects.boxSpace*1.5)
                heightButton: parent.height*0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.right:parent.right
                anchors.margins: GlobalObjects.boxSpace
                action: function(){
                    countdownController.setDatetime(date.text.split("/")[2]+"-"+date.text.split("/")[1]+"-"+date.text.split("/")[0]+" "+time.text)
                    closePopup("changed")
                }
            }
        }
    }
    function openPopup(){
        open()
    }
    function closePopup(status){
        result(status);
        close()
    }
}
