import UIKit


var str = "Hello"
//[특정 문자열 길이 반환]
let strCnt = str.count

//[특정 문자 교체]
let changeStr = str.replacingOccurrences(of: "H", with: "C")

//[특정 문자 제거]
let deleteStr = str.replacingOccurrences(of: "l", with: "")
//특정 범위의 문자 제거
let range = str.index(str.startIndex, offsetBy: 0) ...
    str.index(str.startIndex, offsetBy:  2) // 삭제할 범위 지정
str.removeSubrange(range)

//[특정 문자에 접근]
//첫 번째 문자에 대한 접근
let firstWord = str[str.startIndex]
//마지막 문자에 대한 접근
let lastWord = str[str.index(before: str.endIndex)]
//x번째 문자에 대한 접근
let subStr = str[str.index(str.startIndex, offsetBy: 0)]
//특정 구간의 문자에 대한 접근
let range2 = str.index(str.startIndex, offsetBy: 0) ...
    str.index(str.endIndex, offsetBy:  -1) // -1이면 제일 마지막 문자에 접근한다
let range3 = str.index(str.startIndex, offsetBy: 0) ..<
    str.index(str.endIndex, offsetBy:  -1) // -1이면 제일 마지막 문자에 접근한다
let rangeStr = str[range2]
let rangeStr2 = str[s.index(s.startIndex, offsetBy: i)...str.index(after: 2)]

//[문자 대소문자 변경]
var testStr = "yoonyoung"
//소문자로 전환
let lowerStr = testStr.lowercased()
//대문자로 전환
let upperStr = testStr.uppercased()

//[특정 문자로 쪼개기]
let splitStr = "good,normal,bad"
let splitArr = splitStr.split(separator: ",")
splitArr.map { sp in
    return print(sp)
}

//[String -> Int]
let strText = "123"
let nIntVal: Int? = Int(strText)
if let nIntval2: Int = nIntVal {
    let cal = nIntval2 * 2
}
//[Int -> String
let n = 5
let strVal: String? = String(5)
if let strVal2 = strVal {
    strText.replacingOccurrences(of: "3", with: strVal2)
