import UIKit

struct obj{
    var a:Int = 1
}

func copy(object:obj){
    return obj
}

let temp = obj()

let temp2 = copy(temp)

temp2.a = 2;

print(temp)
print(temp2)
