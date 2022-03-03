import UIKit
import Foundation

let numbers: [Int] = [0, 1, 2, 3, 4,]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

for number in numbers{
    doubledNumbers.append(number*2)
    strings.append("\(number)")
}

print(doubledNumbers)
print(strings)

doubledNumbers = numbers.map({(number: Int) -> Int in
    return number*2
})

strings = numbers.map({ "\($0)"})
print(strings)

doubledNumbers.red
