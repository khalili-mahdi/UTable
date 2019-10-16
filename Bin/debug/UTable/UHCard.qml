import QtQuick 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.Universal 2.4
import QtGraphicalEffects 1.0
Control{
    id:root
    padding: 10
    property int radius : 10
    property color color : Colors.background
    property bool hoverEffect : false
    property string enterColor: ""
    property string exitColor: ""
    property string caption : ""
    property bool hasFooter : false
    property int footerHeight : 50
    property alias footerStyle : footerRect.data
    property color backgroundColor : Colors.background
    property int headerHeight : caption.length > 0 ? 50:0
    property alias headerColor : cardHeader.color
    property color footerColor : Colors.silver
    property alias headerIcon : iconSection.text
    property alias headerLoading : iconSection.isLoading
    property alias headerIconFamily : iconSection.font.family
    property alias headerIconColor : iconSection.color
    property alias captionColor : captionlabel.color
    default property alias childData : childArea.data
    property alias headerStyle : headeritem.data
    property alias contentWidth : childArea.width
    property alias contentHeight : childArea.height
    property alias contentX : flickable.contentX
    property alias contentY : flickable.contentY
    property real captionWordSpacing : 0
    implicitWidth: 500
    implicitHeight: 150
    //    Component.onCompleted: {
    //        if(root.childData != null){
    //            for(var z = 0;z<root.childData.length;++z){
    //                root.childData[z].parent = childArea
    //            }
    //        }
    //    }


    Rectangle{
        id:baserect
        width: parent.width
        height: parent.height
        radius: root.radius
        color: !enabled ? "#c8c8c8" : root.backgroundColor
        clip: true
        Rectangle{
            id: cardHeader
            width: parent.width
            clip: true
            height: headerHeight
            radius: root.radius
            color:enabled? Colors.dark_blue:Colors.belize_hole
            Rectangle {
                id: squareRect

                color: parent.color
                height: cardHeader.radius
                anchors.bottom : cardHeader.bottom
                anchors.left : cardHeader.left
                anchors.right : cardHeader.right
                clip: true
            }
            Item{
                id:headeritem
                width: parent.width
                height: headerHeight
                visible: root.caption.length >0
                Text{
                    id:captionlabel
                    text: root.caption
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    font.family: 'arial'
                    font.wordSpacing: root.captionWordSpacing
                    font.pointSize: 12 * 1.5
                    color: Colors.white
                    visible: headerHeight > 0
                    width: parent.width - 18
                    horizontalAlignment: Text.AlignRight
                    elide: Qt.ElideLeft
                }


                Text{
                    property bool isLoading : false
                    id:iconSection
                    font.family: FontMaterialDesign.fontFamily
                    fontSizeMode: Text.Fit
                    anchors.left: parent.left
                    font.pixelSize: 72
                    anchors.leftMargin: 5
                    font.bold:true
                    anchors.verticalCenter: parent.verticalCenter
                    antialiasing: true
                    width: cardHeader.height>0 ? cardHeader.height - 10 :0
                    height: width
                    transformOrigin: Item.Center
                    color: Colors.white
                    RotationAnimation on rotation{
                        id:loadrotate
                        duration: 1000
                        from:0
                        to:360
                        running: iconSection.isLoading
                        onRunningChanged: {
                            if(!running){
                                iconSection.rotation = 0
                            }
                        }

                        loops: Animation.Infinite
                    }

                    states: [
                        State {
                            name: "loading"
                            when: iconSection.isLoading
                            PropertyChanges {
                                target: iconSection
                                text:FontMaterialDesign.loading
                            }
                        }
                    ]
                }
            }



        }
        Flickable{
            id:flickable
            width: parent.width
            anchors.bottom: footerRect.top
            anchors.bottomMargin: 0
            anchors.top: cardHeader.bottom
            anchors.topMargin: 0
            clip: true
            //contentWidth: width
            //contentHeight: height
            Item{
                id:childArea
                width: parent.width
                height: parent.height
                clip: true
            }
        }
        Rectangle{

            id:footerRect
            color: root.footerColor
            anchors.bottom: parent.bottom
            width: parent.width
            clip: true
            visible: root.hasFooter
            height: root.hasFooter? root.footerHeight:0
            radius: root.radius
            Rectangle {
                id: bottomSquare
                color: root.footerColor
                height: footerRect.radius
                anchors.top : footerRect.top
                anchors.left : footerRect.left
                anchors.right : footerRect.right
                clip: true
            }
        }

    }
    DropShadow {
        width:parent.width
        height: parent.height
        radius: 9.0
        cached: true
        fast: true
        spread: 0.05
        samples: 17
        color: "#99000000"
        source: baserect
    }
}
