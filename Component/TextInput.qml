import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../"
Rectangle{
    id:rect

    property string text
    property string mask

    width:parent.width*0.9
    height:parent.height*0.4
    anchors.horizontalCenter: parent.horizontalCenter

    radius:15
    TextInput{
        id:textInputID
        anchors.fill: parent
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter
        text:rect.text
        font.pixelSize: 32
        inputMask:rect.mask
        onTextChanged: {
            if(rect.text !== textInputID.text){
                rect.text = textInputID.text
            }
        }
    }
    layer.enabled: true
    layer.effect: DropShadow {
        anchors.fill: rect
        horizontalOffset: 0
        verticalOffset: 4
        radius: GlobalObjects.boxSpace
        color: GlobalObjects.boxShadowColor
        samples: 16
    }
}
