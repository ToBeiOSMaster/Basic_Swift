# Protocol

-------------------

### 프로토콜이란

- 특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진
- 특정 기능을 실행하기 위한 프로토콜의 요구사항을 실제로 구현할 수 있다
- 정의하고 제시를 할 뿐이지 스스로 기능을 구현하지는 안흔다



### 프로토콜 사용

* `protocol` 키워드 사용

```swift
protocol 프로토콜 이름 {
  프로토콜 정의
}
```

* 프로토콜을 채택하기 위해서는 타입 이름 뒤에 콜론 (:)을 붙여준다

```swift
struct SomeStrut: AProtocol, AnotherProtocol{
  // 구조체 정의
}

class SomeClass: AProtocol, AnotherProtocol{
  // 클래스 정의
}

enum SomeEnum: AProtocol, AnotherProtocol{
  // 열거형 정의
}
```



### 프로토콜 요구사항

* 프로토콜을 채탁한 타입은 <u>**프로토콜이 요구하는 프로퍼티의 이름과 타입만 맞도록 구현해주면된다**</u>

* `var` 키워드를 사용한 변수 프로퍼티로 정의한다

* 읽기와 쓰기가 가능한 프로퍼티는 정의 뒤에 `{ get set }`이라고 명시한다

* 읽기 전용은 `{ get }` 만 명시

   ```swift
   protocol SomeProtocol{
     var settableProperty: String { get set }
     var notNeedToBeSettableProperty: String { get }
   }
   
   protocol Another{
     static var someTypeProperty: Int { get set }
     static var anotherTypeProperty: Int { get}
   }
   ```

* 타입 프로퍼티를 요구하려면 `static`키워드를 사용한다

   * 상속가능한 타입 프로퍼티 `class`
   * 상속불가능한 타입 프로퍼티 `static`

<u>🤔 상속 가능 프로퍼티 class / 상속 불가능 프로퍼티 static 예시를 다음번에 꼭 찾아보기</u>



### 메서드 요구

* 특정 인스턴스타 타입 메서드를 요구할 수도 있다
* 구현 부분을 제외하고 메서드 이름, 매개변수, 반환 타입 등만 작성하며 가변 매개변수도 허용한다
* 프로토콜의 메서드 요구에서는 기본값을 지정할 수 없다
* `static` 키워드를 명시해야한다 (?)

```swift
protocol Receiveable{
  func received(data: Any, from: Sendable)
}

protocol Sendable{
  var from: Sendable { get }
  var to: Receiveable? { get }
  
  func send(data: Any)
  
  static func isSendableInstance(_ instace: Any) -> Bool
}
```

### 타입으로서의 프로토콜

* 함수, 메서드, 이니셜라이저에서 매개변수 타입이나 반환 타입으로 사용
* 프로퍼티, 변수, 상수 등의 타입으로 사용
* 배열, 딕셔너리 등 컨테이너 요소의 타입으로 사용



### 가변 메서드의 요구

* 메서드가 인스턴스 내부의 값을 변경할 필요가 있다
* `mutating` 키워드를 통해 내부 값을 변경한다는 것을 확실히 해준다
* 참조 타입인 클래스의 메서드 앞에는 `mutating` 키워드를 명시하지 않아도 인스턴스 내부의 값을 바꾸는데 문제가 없다
* <u>**값타입인 구조체와 열거형의 메서드**</u> 앞에는 `mutating` 키워드를 붙인 가변 메서드의 요구가 필요하다

```swift
protocol Resettable{
  mutating func reset()
}

class Person: Resettable{
  var name: String?
  var age: Int?
  
  func reset(){
    self.name = nil
    self.age = nil
  }
}

struct Point: Resettable{
  var x: Int = 0
  var y: Int = 0
  mutating func reset(){
    self.x = 0
    self.y =0
  }
}

enum Direction: Resettable{
  case east, west, south, north, unknown
  
  mutating func reset()P{
    self = Direction.unknown
  }
}
```

* Resettable 프로토콜은 reset()이라는 가변 메서드를 요구한다
* 만약 Resettable프로토콜에서 가변 메서드를 요구하지 않는다면, 값 타입의 인스턴스 내부 값을 변경하는 mutating 메서드는 구현 불가능



### 이니셜라이저 요구

```swift
protocol Named{
  var name: String { get }
  
  init(name: String)
}

struct Pet: Name{
  var name: String
  
  init(name: string){
    self.name = name
  }
}
```

* `required` 식별자를 붙이면 요구 이니셜라이저로 구현해야한다
   * 상속받는 모든 클래스는 Named 프로토콜을 준수해야하며, 해당 이니셜 라이저를 모두 구현해야한다

```swift
class Person: Named{
  var name: String
  
  required init(name: String){
    self.name = name
  }
}
```

* 만약 클래스 자체가 상속 받을 수 없는 final 클래스라면 requried 식별자를 붙여줄 필요가 없다