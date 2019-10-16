import QtQuick 2.0
QtObject {
    id:root
    property string column:""
    property string title:column
    property int size:100
    property Component cell:null
    property int cellHeight:30
    property var cellMargin :4
    property bool ignored:false
    property string splitter:""
    property string prepend:""
    property string append:""
    property UValueMask mask :null
    property UValueConverters converters : null
}
