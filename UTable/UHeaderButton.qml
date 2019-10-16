import QtQuick 2.4
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
Rectangle {
    signal clicked(var mouse)
    property alias font : icoText.font.family
    property alias icon : icoText.text
    property alias size : icoText.font.pixelSize
    property alias toolTip : tooltipText.text
    property string colorEnter :"#0481ff"
    property string colorExit :"#00171f"
    property string colorIcon : isTransparent? Colors.black: Colors.white
    property alias containsMouse : mouseArea.containsMouse
    property alias acceptedButtons : mouseArea.acceptedButtons
    property bool isTransparent : false
    property bool hoverEffect : true
    id: root
    implicitWidth: 50
    implicitHeight: 50
    //width: childrenRect.width
    radius: 0
    //height: childrenRect.height
    color: isTransparent?UColors.transparent: mouseArea.containsMouse?colorEnter: colorExit
    state: "default"
//    Glow {
//        id:shadow
//        anchors.fill: icoText
//        radius: 2
//        samples: 17
//        color: mouseArea.containsMouse ? Qt.darker(root.colorEnter,1.5):Qt.darker(root.colorExit,1.5)
//        source: icoText

//    }
    Text {
        id: icoText
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 25
        font.family: FontAwesome.fontFamily
        visible: text!= ""
        color:root.isTransparent && mouseArea.containsMouse ? root.colorEnter : root.colorIcon
    }
    ToolTip {
        id:tooltipText
        text: ""
        delay: 500
        timeout: 2000
        visible: mouseArea.containsMouse && text!=""
        font.family: 'arial'
        contentItem: Text {
            text: tooltipText.text
            font: tooltipText.font
            color: "white"
        }

        background: Rectangle {
            color: "#cc000000"
            border.color: "black"
        }
    }

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: root.hoverEffect
        onClicked: {
            root.clicked(mouse)
        }
    }
    states: [
        State{
            name:"pressed"
            when: mouseArea.pressed

            PropertyChanges {
                //pressed icon color
                target: icoText
                color : isTransparent ? Qt.darker(colorEnter,1.5): colorIcon
            }
            PropertyChanges {
                //pressed background color
                target: root
                color : !isTransparent ? Qt.darker(root.color,1.5) : UColors.transparent
            }
        },
        State{
            name:"disabled"
            when :!root.enabled
            PropertyChanges {
                //disabled icon color
                target: icoText
                color:Colors.gray
            }
        }

    ]
}
