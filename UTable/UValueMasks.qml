pragma Singleton
import QtQuick 2.0

UListObject {
    property UValueMask timeMask :UValueMask{
        id:timemask
        name: "time"
        function mask(input,splitter){
            return innerObj.convertIntToTime(input,splitter)
        }

    }
    property UValueMask dateMask: UValueMask{
        id:datemask
        name:"date"
        function mask(input,splitter){
            return innerObj.convertIntToDate(input,splitter)
        }
    }

    property UValueMask moneyMask:UValueMask{
        id:moneymask
        name:"money"
        function mask(input,splitter){
            return innerObj.convertIntToCurrency(input)
        }
    }
    QtObject{
        id:innerObj
        function formatNumber(num) {
            if(num!= null){
                var array = num.toString().split('');
                var index = -3;
                while (array.length + index > 0) {
                    array.splice(index, 0, ',');
                    // Decrement by 4 since we just added another unit to the array.
                    index -= 4;
                }
                return array.join('');
            }
            else{
                return "خالی"
            }
        }
        function convertIntToCurrency(stringint){
            var res = formatNumber(stringint)
            return res
        }
        function convertIntToDate(stringint,splitter){
            if(stringint!= null){
                var _temp = stringint.toString()
                if(_temp.length === 8){
                    var arr = _temp.split("");
                    arr.splice(4,0,splitter);
                    arr.splice(7,0,splitter);
                    return arr.join("");
                }
                else return _temp;
            }
            else{
                return "خالی"
            }
        }
        function convertIntToTime(stringint,splitter){
            if(stringint!= null){
                var _temp = stringint.toString()
                if(_temp.length === 4){
                    var arr = _temp.split("");
                    arr.splice(2,0,splitter);
                    return arr.join("")
                }
                return _temp;
            }
            else{
                return "خالی"
            }
        }
    }
}
