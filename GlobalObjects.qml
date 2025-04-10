pragma Singleton
import QtQuick 2.15

QtObject {
    property string boxMargin : "7.5"
    property string boxSpace : "15"

    property string screenMode : countdownController.getScreenMode() ?? "dark";

    property string backgroundColorReverse : screenMode != "dark" ? "#151515" : "#f0efef"
    property string backgroundColor : screenMode == "dark" ? "#151515" : "#f0efef"
    property string backgroundColorBox : screenMode == "dark" ? "#1c1d1d" : "#f3f4f3"
    property string borderShadowColor : screenMode == "dark" ? "#101010" :  "#f3f4f3"
    property string backgroundColorTimeBox : screenMode == "dark" ? "#171716" : "#354047"
    property string boxShadowColor : screenMode == "dark" ? "#88000000": "#88000000"
    property string labelColor : screenMode == "dark" ? "#60f9c1" : "#60f9c1"
    property string remainingTimeTitleColor : screenMode == "dark" ? "#fff" : "#000"
    property string remainingTimeTitleColorReverse : screenMode != "dark" ? "#fff" : "#000"
    property string selectedDatetimeColor : screenMode == "dark" ? "#f3f4f3" : "#cc000000"
}
