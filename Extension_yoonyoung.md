## Extension
Extension은 클래스, 구조체, 열거형, 프로토콜 타입에 새로운 기능을 추가한다.

#### Extension 기능
1) 계산된 인스턴스 프로퍼티와 계산된 타입 프로퍼티 추가
2) 인스턴스 메서드와 타입 메서드 정의
3) 새로운 초기화 구문 제공
4) 새로운 초기화 구문 제공
5) 서브 스크립트 정의
6) 새로운 중첩된 타입 정의와 사용
7) 기존 타입이 프로토콜을 준수하도록 함
8) **Providing default Implementations** : 해당 프로토콜의 모든 메서드 또는 계산된 프로퍼티 요구사항에 기본 구현을 제공하기 위해 프로토콜 확장을 사용할 수 있다.

#### Extension Syntex
1) 일반적인 확장 선언
```
extension SomeType {
    // new functionality to add to SomeType goes here
}
```

2) 프로토콜 채택을 통한 타입 확장
```
extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
```

#### Computed Properties
Extension은 기존 타입에 **computed instance property** 와 **computed type property** 를 추가할 수 있다
```
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
```
=> 이 프로퍼티는 읽기전용 계산된 프로퍼티 이므로 간결성을 위해 get 키워드 없이 표현된다.  
반환값은 Double 타입의 값이고 Double 이 허용되는 수학적 계산 내에서는 사용될 수 있다  
  
#### Initializers
확장은 기존 타입에 새로운 초기화 구문을 추가할 수 있다. 
이것은 초기화 구문 파라미터로 고유한 사용자 정의 타입을 받아들이기 위해 다른 타입을 확장하거나 타입의 기존 구현의 부분으로 포함되지 않는 추가 초기화 옵션을 제공할 수 있다.

```
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))
   
//특정 중심점과 크기를 가지는 초기화 구문을 제공하기 위해 Rect 구조체 확장
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
```

#### Methods
Extension은 기존 타입에 새로운 인스턴스 메서드를 추가할 수 있다
```
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.repetitions {
    print("Hello!")
}
// Hello!
// Hello!
// Hello!

someInt.square() //9
```

