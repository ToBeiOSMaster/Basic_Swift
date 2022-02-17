# [Primitive Types](https://bbiguduk.gitbook.io/swift/language-guide-1/strings-and-characters)

## String
```
let exString = "example String"
```
Swift의 String 타입은 Foundation의 NSString 클래스와 연결되어 있다. 
Foundation은 NSString에 의해 정의된 메서드를 노출시키기 위해 String을 확장하는 역할을 수행한다. (Extension?)
> 어떤 String 인스턴스든 type cast operator `as` 를 사용해서 NSString과 브릿지 관계를 형성할 수 있다.  
Objective-C에서 기원한 String 인스턴스는 NSString을 스토리지와 같이 사용할 수 있다.    
그 이유는 NSString 인스턴스의 임의의 서브클래스는 String의 인스턴스가 될 수 있기 때문이다.

> 변경할 수 없기 때문에 저장소가 복사본에 의해 공유된 것과 같다. 변경 작업 시퀀스의 첫 번쨰 작업은 요소를 공유하고 연속적인 저장소에 복사하도록 하며, 여기에 `O(n)`의 시간과 공간이 소요된다.
* 여기서 n은 문자열의 인코딩된 표현의 길이

=> Foundation을 import하면 캐스팅 없이 String에서 NSString 메서드를 접근할 수 있다.

### 1. Multiline String Literals
- `따옴표(""")`를 통해 표현
- 줄바꿈 또한 문자열의 값으로 표현되나, 줄바꿈이 문자열 값의 일부가 되는 것을 원치 않을 경우에는 줄 바꿈을 원하는 라인 끝에 `백슬래시(\)` 입력
- 들여쓰기의 경우에는 공백의 문자열로 계산하지 않는다.
```
let quotation = """
고양이는 야옹야옹
강아지는 멍멍
호랑이는 어흥
"""
```

### 2. Extended String Delimiters
- 문자를 `#`으로 둘러쌀 경우 특수문자를 출력할 수 있다.
```
let exString1 = "Line1 \n Line2"
print(exString1)
//출력 결과: 
Line1
Line2

let exString2 = #"Line1 \n Line2"#
print(exString2)
//출력 결과: Line1 \n Line2
```

### 3. Initializing an Empty String
방법 1) 빈 문자열 리터럴을 변수에 할당: `var emptyString = ""`
방법 2) 초기화: `var emptyString = String()`
=> emptyString.isEmpty == true

### 4. String Mutability 문자열 변경 가능성(⭐️)
특정 String은 변수`var` 또는 상수`let`에 할당되어 변경될 수 있는지 여부를 알 수 있다
- var: 값 할당 이후 변경 가능. 가장 최근에 할당한 값을 담는다.
- let: 값 할당 이후 변경 불가능.

### 5. String Are Value Types 문자열은 값 타입!(⭐️)
Swift의 String 타입은 값 타입 (value type)이다.
새로운 String 값을 생성한다면 String 값은 함수 또는 메서드에 전달될 때나 상수 또는 변수에 대입될 때 **복사**된다. 
각 경우에 존재하는 String 값의 새로운 복사본이 생성되고 **원본이 아닌 새로운 복사본**은 전달되거나 할당된다.
> 문자열, 구조체, 열거형은 모두 값타입

### 6. Working with Characters
#### - for-in 루프
```
for character in "Cat" { print(character) }
//C
//a
//t
```

### 7. Concatenating Strings and Characters
- `+`와 `appnd()`를 통한 문자열 연결
```
let string1 = "hello"
let string2 = "yoonyoung"
let exclamationMark: Character = "!"
var newString = string1 + string2
newString.append(exclamationMark)
print(newString) //hello yoonyoung!

```

### 8. String Interpolation
- `\()` 추가를 통해 문자열 리터럴에 값이 포함된 포현식을 혼합해 새로운 String값 생성
```
let name = "yoonyoung"
let state = "hungry"
let message = "\(name) is \(state)"
print(message) //yoonyoung is hungry
```

### 9. Counting Characters
- `count`
```
let alphabet = "abcdefg"
print(alphabet.count) //7
```

**이해하지 못한 구절 -> 같이 돌려보고 이해해봐요 :)**
* 확장된 문자소 클러스터는 여러 개의 유니코드 스칼라로 구성할 수 있다.   
=> **이것은 다른 문자와 같은 문자의 다른 표기법은 저장할 때 메모리 사용량이 다르게 요구될 수 있다는 의미이다.**  
이 때문에 Swift의 문자는 각각 문자열에서 동일한 양의 메모리를 차지하지 않습니다. 그 결과 문자열에 문자의 숫자는 확장된 문자소 클러스터의 경계를 결정하기 위해 그 문자열을 반복하지 않고는 계산할 수 없다. 특히 긴 문자열 값으로 작업하는 경우에 해당 문자열의 문자를 결정하려면 count 프로퍼티가 전체 문자열의 유니코드 스칼라를 반복해야 한다.  
`count` 프로퍼티로 반환된 문자의 갯수는 같은 문자여도 `NSString`의 `length` 프로퍼티와 항상 같지 않다. `NSString`의 길이는 문자열 내에 유니코드 확장된 문자소 클러스터 수가 아니라 문자열의 UTF-16 표현 내의 16-bit 코드 단위 수를 기반으로 한다.

### 10. Accessing and Modifying a String
```
let alphabet = "abcdefg"
alphabet[alphabet.startIndex] //a
alphabet[alphabet.index(after: alphabet.startIndexx)] //b
alphabet[alphabet.index(before: alphabet.endIndex)] //g

let range = alphabet.index(alphabet.startIndex, offsetBy: 3) 
alphabet[range] //d
```
이외 문자열 범위에 벗어나는 인덱스로 접근하거나 문자열 범위에서 벗어나는 인덱스의 Character를 접근하려고 하면 `런타임에러`가 발생한다

- indices
```
for index in alphabet.indices {
  print("\(alphabet[index]", terminator: " ")
}
// a b c d e f g
```
- `terminator`: 문자열이 한 줄로 출력되게 도와준다. terminator를 사용하지 않으면 출력 과정에서 줄바꿈이 발생한다.  
+) `seperator`: string을 연결시켜줄 때, 그것들을 특정 문자열을 통해 나누어주는 역할을 수행한다

```
print("my", "name", "is", "yoonyoung", seperator: "...")
///my...name...is...yoonyoung
```

### 11. Inserting and Removing
- `insert(_:at:)`와 `insert(contentsOf:at:)`를 이용한 문자열 삽입
```
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
//hello!

welcome.insert(contentsOf: " there", at: welcome.indeX(before: welcome.endIndex))

- `remove(at:)`와 `removeSubrange(_:)`를 이용한 문자열 삭제
```
welcome.remove(at: welcome.index(before: welcome.endIndexx))
//하나의 문자열 삭제 //hello there

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrage(range) //hello
```
