import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Universal 2.4
import QtGraphicalEffects 1.0
Item{
    property alias radius : morakhasiRect.radius
    property alias color : morakhasiRect.color
    property bool hoverEffect : false
    property string enterColor:""
    property string exitColor:""
    implicitWidth: 150
    implicitHeight: 150

    Rectangle{
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
        id:morakhasiRect
        width: parent.width
        height: parent.height
        color: {
            if(!enabled)
                return "#c8c8c8"
            return exitColor == "" ? "#f5f5f5" : exitColor
        }

    }
    DropShadow {
        width:parent.width
        height: parent.height
        radius: 9.0
        samples: 17
        color: "#80000000"
        source: morakhasiRect
    }
}
