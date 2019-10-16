import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import UTable 1.0
import QtQuick.Controls 2.12
Window {
    visible: true
    width: 850
    height: 650
    title: qsTr("Hello World")
    FontLoader{
        id:fontmaterialdesignicons
        name:"Material Design Icons"
        source:"qrc:/Fonts/materialdesignicons-webfont.ttf"
    }
    color: "black"
    HCard{
        anchors.centerIn: parent
        height: 360
        width: 800
        caption:"Form Title"
        padding: 5
        TextField{
            id:sometxt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 15
            anchors.top: parent.top
            enabled: false
        }

        Sortable {
            anchors.top: parent.top
            anchors.topMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            id: tableView
            sourceModel: mymodel
            ListModel{
                id:mymodel
                ListElement{
                    name:"mahdi"
                    fmly:"khalili"
                    select:0
                }
                ListElement{
                    name:"tomas"
                    fmly:"edison"
                    select:1
                }
            }
            columns: Columns{
                Column{
                    title: "Name"
                    column: "name"
                    size: 250
                }
                Column{
                    title: "Family"
                    column: "fmly"
                    size: 150
                }

                Column{
                    title: "Select"
                    column: "select"
                    size: 80
                    cellMargin: 0
                    cell: HeaderButton{
                        width: 30
                        height: 30
                        isTransparent: true
                        icon:FontMaterialDesign.select
                        font: FontMaterialDesign.fontFamily
                        colorEnter: Colors.dark_blue
                        colorIcon: Colors.black
                        onClicked: {
                            sometxt.text = modelData.name + " "+ modelData.fmly
                        }
                    }
                }

            }
        }
    }
}
