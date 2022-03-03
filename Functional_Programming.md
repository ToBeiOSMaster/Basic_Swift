# Functional Programming

-----------------

저는 야곰님책으로 공부하고 있는데 함수형프로그래밍 내용에 이 세가지가 나와서 이것들을 정리했어요!

## Optional Chaining

### Optional Chaning 이란

* optional 속에 **nil일지도 모르는** 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 떄 사용하는 과정
* 옵셔널을 **<u>*반복 사용하여*</u>** 옵셔널이 자전거 체인처럼 서로 꼬리를 물고 있는 모양
* 값이 하나라도 존재하지 않으면 결과적으로 반환
* `?` 를 붙여 표현한다
* `!` 를 사용할 수도 있다 :: <u>강제 추출</u>하는 효과
  * `!` 사용시 값이 없다면 **런타임 오류 발생**
  * 강제 추출이므로 반환 값이 옵셔널이 아니다

```swift
class Room {
  var number: Int
  
  init(number: Int){
    self.number = number
  }
}

class Building {
  var name: String
  var room: Room?
  init(name: String){
    self.name = name
  }
}

struct Address{
  var province: String
  var city: String
  var street: String
  var building: Building?
  var detailAddress: String?
}

class Person{
  var name: String
  var address: Adress?
  
  init(name: String){
		self.name = name
  }
}

let yeoni: Person = Person(name: "yeoni")

let yeoniRoomViaOptionalChaining: Int? = yeoni.address?.building?.room?.number // nil
let yeoniRoomViaOptionalUnwraping: Int = yeoni.address!.building!.room!.number // 런타임에러

if let number: Int = yeoni.address?.building?.room?.number {
  print(number)
}else {
  print("no number")
}

yeoni.address?.building?.room?.number = 505 // 할당불가!! address가 존재하지 않음

yeoni.address = Address(province: "전라북도", city: "전주시", street: "덕진구", building: nil, detailAddress: nil)
yeoni.address?.building = Building(name: "여니상가")
yeoni.address?.building?.room = Room(number: 0)
yeoni.address?.building?.room?.number = 505

print(yeoni?.address?.building?.room?.number) // Optional(505)
```

### Early Exit

* 핵심 키워드는 `guard` 이다
* if 구문과 유사하게 Bool 타입으로 동작하는 기능
* return, break, continue, throw등의 제어문 전환 명령 사용
* optional chaining을 조금 더 발전시킨 코드로 짤 수 있다



------------

## Map, Filter, Reduce

### Map

* 자신을 호출할 때 매개변수로 전달 된 함수를 실행하여 결과를 반환해주는 함수
* 배열, 딕셔너리, 세트, 옵셔널 등에서 사용
  * Swift의 Sequence와 Coleection 프로토콜을 따르는 타입과 옵셔널은 모두 맵 사용 가능
* 각각의 매개변수를 함수를 적용한 후 컨테이너에 포장하여 반환
* 새로운 컨테이너가 생성되어 반환
* for-in 구문과 별다를게 없다?
  * 코드의 재사용과 컴파일러 최적화
  * https://stackoverflow.com/questions/33750636/swift-performance-map-and-reduce-vs-for-loops
  * 시간나면 읽어보고 생각하기

```swift
let numbers: [Int] = [0, 1, 2, 3, 4,]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

for number in numbers{
    doubledNumbers.append(number*2)
    strings.append("\(number)")
}

doubledNumbers = numbers.map({(number: Int) -> Int in
    return number*2
})

strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

// 더 간략하게
doubledNumbers = numbers.map({ $0*2 })
strings = numbers.map({ "\($0)" })

```

### Filter

* 컨테이너 내부의 값을 걸러서 추출
* 새로운 컨테이너에 담아서 반환
* 특정 조건에 맞게 걸러내는 역할
* 반환 값은 Bool

```swift
let numbers: [Int] = [0, 1, 2, 3, 4, 5]
let evenNumbers: [Int] = numbers.filter{ $0%2 == 0 }
```

### Reduce

* 결합
* 컨테이너 내부의 콘텐츠를 하나로 합하는 기능

```swift
public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
```

* 클로저가 각 요소를 전달 받아 연산한 후 다음 클로저 실행을 위하여 반환하여 컨테이너를 순환하는 형태

```swift
public func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result
```

* 컨테이너를 순환하며 클로저가 실행되지만 클로저가 따로 결과값을 반환하지 않는 형태

---------------

## Monad

### 모나드란?

* 연산을 처리할 때 자주 활용하는 디자인 패턴
* 모나딕 : 모나드의 성질을 완벽히 갖추지는 못하였지만 대부분의 성질을 갖추었을때 
* 조건
  * 타입을 인자로 받는 타입(특정 타입을 포장) -> 제너릭으로 구현
  * 특정 타입의 값을 포장한 것을 반환하는 함수(메서드)가 존재
  * 포장된 값을 변환하여 같은 형태로 포장하는 함수(메서드)가 존재
* 옵셔널은 가장 기본적인 스위프트의 모나드이다

### Context (컨텍스트)

*  **컨텐츠를 담은 그 무언가**, **어떤 위치에 값이 존재할 수 있는 맥락** 
* 정의 : 맥락, 전후 사정
* 2라는 숫자를 옵셔널로 둘러싸면, 컨텍스트 안에 2라는 콘텐츠가 들어가는 모양
  - 컨텍스트는 2라는 값을 가지고 있다
  - 만약 값이 없는 옵셔널 상태라면 ‘컨텍스트는 존재하지만 내부에 값이 없다’고 할 수 있다
    - 이처럼 값(콘텐츠)과 컨텍스트의 관계를 이해하는 것이 컨텍스트를 공부하는 것의 출발점
* 컨텍스트는 무언가를 담고있는 것을 의미
* Container
  * 옵셔널도 컨텍스트의 일종
  *  옵셔널도 컨테이너의 한 종류로 그 컨테이너 안에는 값이 존재할 수도 존재하지 않을 수도 있다
  * 

### Functor (함수객체)

* **고차 함수인 map 을 적용할 수 있는 컨테이너 타입**
* 값에 변형을 매핑할 수 있는 모든 것들을 **Functor**라고 함
* **매핑으로 변형된 값은 다시 Functor로 감싼 후 반환된다는 것**
* swift에서 매핑의 대표적인 메소드가 바로 `map`