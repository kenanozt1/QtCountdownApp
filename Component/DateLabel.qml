import QtQuick 2.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.15
import "../"
Item {
    id:root
    width:parent.width
    height: 60
    property string text
    property string size : "38"
    Rectangle{
        id:rect
        width: parent.width*0.9
        height: 60
        color:GlobalObjects.backgroundColorTimeBox
        radius: GlobalObjects.boxSpace
        anchors.horizontalCenter: parent.horizontalCenter
        layer.enabled: true
        layer.effect: DropShadow {
            anchors.fill: rect
            horizontalOffset: 0
            verticalOffset: 4
            radius: GlobalObjects.boxSpace
            color: GlobalObjects.boxShadowColor
            samples: 16
        }
        Text {
            id: label
            text: qsTr(root.text)
            font.family: sevenSegmentFont.name
            color: GlobalObjects.labelColor
            font.pixelSize: root.size
            font.bold: true
            anchors.centerIn: parent
        }
    }
}
