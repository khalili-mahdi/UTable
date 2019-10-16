import QtQuick 2.0

UListObject {
    id:root

    QtObject{
        id:innerObj
        property var masks :["time","date","money"] //"ip","mac","card"

    }

    function mask(input,splitter,maskObj = null){
        if(maskObj!= null&& maskObj instanceof UValueMask){
            return maskObj.mask(input,splitter)
        }
        else{
            return input
        }

    }

}
