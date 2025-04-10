import QtQuick 2.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.15
import "../"
Rectangle{
    property var action: function () {}
    property string text : "Example Text"
    property string textColor : "#fff"
    property string size : "26"
    property string buttonColor : "#88000000"
    property string widthButton : parent.width
    property string heightButton : "60"

    id:buttonRect
    width:buttonRect.widthButton
    height: buttonRect.heightButton
    color:buttonRect.buttonColor
    radius: GlobalObjects.boxSpace
    layer.enabled: true
    layer.effect: DropShadow {
        anchors.fill: buttonRect
        horizontalOffset: 0
        verticalOffset: 4
        radius: GlobalObjects.boxSpace
        color: GlobalObjects.boxShadowColor
        samples: 16
    }
    Text {
        id:buttonText
        text: buttonRect.text
        anchors.centerIn: parent
        font.pixelSize: buttonRect.size
        color:textColor
    }
    MouseArea{
        id:buttonClicked
        anchors.fill: parent
        onClicked: action()
    }
}
