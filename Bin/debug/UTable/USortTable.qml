import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import SortFilterProxyModel 0.2
/*
    K.Sortable{
        id:mysortable
        anchors.verticalCenter: parent.verticalCenter
        height: 300
        anchors.left: parent.left
        anchors.leftMargin: 0
        sortColumn : "firstName"
        sortOrder: Qt.AscendingOrder
        onCurrentIndexChanged: {
            console.log(currentItem.firstName)
        }
        columns: K.Columns{

            K.Column{
                column:"lastName"
                title:"نام خانوادگی"
                size:150
            }
            K.Column{
                column:"firstName"
                title:"نام"
                size:100
            }
            K.Column{
                column:"favorite"
                title:"محبوبیت"
                size:70
                ignored:true
            }
        }
        sourceModel : personModel
    }

    ListModel {
        id: personModel
        ListElement {
            firstName: "علی"
            lastName: "محمودی"
            favorite: true
        }
        ListElement{
            firstName:"مهدی"
            lastName:"خلیلی"
            favorite:true
        }
        ListElement{
            firstName:"شیوا"
            lastName:"پونه"
            favorite:true
        }
    }
  */
//RowLayout{
//    id:root
//    implicitWidth: 300
//    implicitHeight: 300
//    property UColumns columns
//    property alias sourceModel : sortmodel.sourceModel
//    property string sortColumn : ""
//    property var sortOrder : Qt.AscendingOrder
//    readonly property var currentItem : getCurrentItem()
//    property var currentIndex : sorttable.currentIndex
//    //contentWidth: sorttable.headerItem.width
//    function getCurrentItem(){
//        return sorttable.getModelValues(sorttable.currentIndex)
//    }

    ListView{
        id:sorttable
        clip: true
        height: parent.height
        implicitWidth: headerItem.width
        implicitHeight: 300
        headerPositioning: ListView.OverlayHeader
        property UColumns columns
        property alias sourceModel : sortmodel.sourceModel
        onSourceModelChanged: {
            console.log(sourceModel.columnCount())
        }
        property var sortColumn
        property var sortOrder : Qt.AscendingOrder
        readonly property var currentItem : getCurrentItem()
        contentX: headerItem.width - width
        contentWidth: sorttable.headerItem.width
        function getCurrentItem(){
            return model.get(currentIndex)
        }
        function getMaskedValue(input,column){
            //if there is a problem with not updating view aftering editing , check this method
            var maskObj = column.mask
            var splitter = column.splitter
            var converter = column.converters
            var res =  sortmasks.mask(input,splitter,maskObj)
            if(converter!= null){
                var arr = Array.from(converter.childNodes).filter(x=>x.from==input)
                if(arr != null && arr.length >0)
                    res = arr[0].to
            }
            return res;
        }
        USortMasks{
            id:sortmasks
        }

        Layout.alignment: Qt.AlignRight
        flickableDirection: Flickable.AutoFlickIfNeeded
        //TODO : this may produce problems later maybe changing dynamic Columns will pop the problem
        readonly property var columnsArray : Array.from(sorttable.columns.dataChild)
        width:columnsArray.map(x=>x.size).reduce((x,y)=>x+y)

        //property var _ignoredColumns:columnsArray.filter(y=>y.ignored).map(x=>x.column)
        function getModelKeys(){
            if( sorttable.sourceModel instanceof ListModel){
                var firstelement = sorttable.sourceModel.get(0)
                var keys = sorttable.columnsArray.filter(y=>!y.ignored).map(x=>x.column)
                //var keys = Object.keys(firstelement).filter(x=>!(_ignoredColumns.indexOf(x)>=0)).reverse()
                return keys
            }
        }
        function getModelValues(index){
            if(index === -1){
                return null;
            }

            if(sorttable.sourceModel instanceof ListModel){
                var element = sortmodel.get(index)
                return element
            }
            return null;
        }
        spacing: 0


        header: RowLayout{
            id:headerDelegate
            z:2
            property var _temp : sorttable.getModelKeys()
            layoutDirection: Qt.RightToLeft
            spacing: 0
            Repeater{
                model: headerDelegate._temp

                Rectangle{
                    id:cellrect
                    color: Colors.blue
                    width: sorttable.columnsArray.find(a=>a.column==modelData).size //root.columns.dataChild[index].size
                    height: 40
                    RowLayout{
                        clip: true
                        width: parent.width
                        anchors.centerIn: parent
                        spacing: 0
                        layoutDirection: Qt.RightToLeft
                        Text {
                            Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.rightMargin: 5
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignRight
                            text: sorttable.columnsArray.find(a=>a.column==modelData).title //root.columns.dataChild[index].title
                            font.family: 'arial'
                            font.pointSize: 12
                            font.bold: true
                            color: "white"
                        }
                        HeaderButton{
                            id:sortbtn
                            Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                            icon: sorttable.sortColumn == modelData? (sorttable.sortOrder==Qt.AscendingOrder? UFontMaterialDesign.arrow_down:UFontMaterialDesign.arrow_up):UFontMaterialDesign.sort
                            font: UFontMaterialDesign.fontFamily
                            isTransparent : true
                            Layout.preferredWidth: 20
                            Layout.preferredHeight: 20
                            Layout.leftMargin: 5
                            //color: Universal.color(Universal.Cobalt)
                            colorEnter: Colors.black
                            colorExit: sorttable.sortColumn == modelData? Colors.emerald:Colors.dark_blue
                            onClicked: {
                                if(sorttable.sortColumn == modelData){
                                    if(sorttable.sortOrder == Qt.AscendingOrder){
                                        sorttable.sortOrder = Qt.DescendingOrder
                                    }
                                    else{
                                        sorttable.sortOrder = Qt.AscendingOrder
                                    }
                                }
                                else{
                                    sorttable.sortOrder = Qt.AscendingOrder
                                    sorttable.sortColumn = modelData
                                }
                            }
                        }
                        Rectangle{
                            Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                            Layout.preferredHeight: 35
                            width: 1
                            opacity: 0.5
                            color: UColors.light_blue

                        }
                    }
//                    Rectangle{
//                        anchors.left: parent.left
//                        color: Colors.whiteBlue
//                        width: 1
//                        height: parent.width
//                        MouseArea{
//                            anchors.fill: parent
//                            cursorShape: Qt.SizeHorCursor
//                            hoverEnabled: true
//                            drag{
//                                target:parent
//                                axis: Drag.XAxis
//                            }

//                            onMouseXChanged: {
//                                if(drag.active){
//                                    cellrect.width = cellrect.width + mouseX
//                                    if(cellrect.width<50){
//                                        cellrect.width = 50
//                                    }
//                                }
//                            }
//                        }
//                    }
                }
            }
        }
        currentIndex: -1
        delegate: RowLayout{
            id:rowDelegate
            z:1
            property var _temp : sorttable.getModelKeys()
            property var _model : model
            MouseArea{
                id:rowmousearea
                width: parent.width
                height: parent.height

                hoverEnabled: true
                onClicked: {
                    sorttable.currentIndex = index
                }
            }
            Rectangle{
                id:rowrect
                width: _row.width
                height: _row.height
                RowLayout{
                    id:_row
                    spacing: 0
                    layoutDirection: Qt.RightToLeft
                    Repeater{
                        model:rowDelegate._temp
                        Item{
                            property var currentItem :sorttable.columnsArray.find(a=>a.column==modelData)
                            id:cellitem
                            width: currentItem.size //root.columns.dataChild[index].size
                            onWidthChanged: {
                                if(width ==0 || width == null){
                                    console.log("column with name "+modelData+" is not defined!")
                                }
                            }
                            height: currentItem.cellHeight
                            Loader{
                                id:cellloader
                                clip: true
                                anchors.fill: parent
                                anchors.margins: currentItem.cellMargin
                                sourceComponent: currentItem.cell==null? defaultcomponent:currentItem.cell
                                onSourceComponentChanged: {
                                    //define dynamic properties to loader default property 'loader.item' - runtime properties to existing object
                                    Object.defineProperty(cellloader.item,'rowIndex',{get(){return _model.index}});
                                    Object.defineProperty(cellloader.item,'modelData',{get(){return _model}});

                                }
                            }
                            Rectangle{
                                width: 1
                                anchors.right: parent.right
                                height: parent.height
                                color: UColors.light_blue
                                visible: index==0
                                opacity: 0.1
                            }
                            Rectangle{
                                width: parent.width
                                height: 1
                                anchors.bottom: parent.bottom
                                color: UColors.light_blue
                                opacity: 0.1
                            }

                            Rectangle{
                                width: 1
                                anchors.left: parent.left
                                height: parent.height
                                color: UColors.light_blue
                                opacity: 0.1
                            }

                            Component{
                                id:defaultcomponent

                                Text {
                                    width: parent.width
                                    font.family: 'arial'
                                    font.pointSize: 11
                                    horizontalAlignment: Text.AlignRight
                                    verticalAlignment: Text.AlignVCenter
                                    id:cellcompo
                                    elide: Text.ElideRight
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
//                                    text:currentItem.prepend+ sorttable.getMaskedValue(rowDelegate._model[modelData],currentItem)+currentItem.append
                                    Binding{
                                        id: bindtext
                                        target: cellcompo
                                        property: "text"
                                        value: currentItem.prepend+ sorttable.getMaskedValue(rowDelegate._model[modelData],currentItem)+currentItem.append
                                    }
                                }
                            }
                        }
                    }

                }
            }
            states:[
                State{
                    name:"current"
                    when:sorttable.currentIndex == _model.index
                    PropertyChanges {
                        target: rowrect
                        color:Colors.brightBlue
                    }
                },

                State {
                    name: "mousein"
                    when: rowmousearea.containsMouse
                    PropertyChanges {
                        target: rowrect
                        color:Colors.whiteBlue
                    }
                }
            ]

        }

        model:SortFilterProxyModel {
            id: sortmodel
            sourceModel: srcmdl

            sorters: StringSorter {
                enabled:sorttable.sortColumn !== undefined
                roleName: sorttable.sortColumn
                sortOrder:sorttable.sortOrder
                ignorePunctation: true
                caseSensitivity: Qt.CaseInsensitive

            }
        }
        ListModel{
            id:srcmdl
        }
    }

//}
