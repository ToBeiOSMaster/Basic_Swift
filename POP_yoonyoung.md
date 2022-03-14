## Protocol Oriented Programming
> 프로토콜 지향 프로그래밍이니 프로토콜에 대해 알아보고, swift가 이러한 프로토콜 지향 프로그래밍을 추가하게 된 배경? 이유에 대해 정리해보겠습니다 :)
> 아직 적는 중임미다...


### Protocols
- 프로토콜은 메서드, 프로퍼티, 그리고 특정 작업이나 기능의 부분이 적합한 다른 요구사항의 청사진을 정의
- 프로토콜은 요구사항의 구현을 제공하기 위해 **클래스, 구조체, 또는 열거형**에 의해 채택될 수 있다.
- 준수하는 타입의 요구사항을 지정하는 것 이외에도 **요구사항의 일부를 구현하거나 준수하는 타입에 추가 기능을 구현하기 위해 프로토콜을 확장할 수 있다**  

### Protocols Property Requirements
- 프로토콜은 요구된 프로퍼티 이름과 타입만 지정하고 프로퍼티가 `Stored property`인지 `Computed property`인지에 대해 명시하지 않습니다.
- 프로토콜은 각 프로퍼티가 `gettable`인지 `gettable`+`settable`인지도 지정해줘야 한다.
- 프로퍼티 요구사항은 항상 `var` 키워드와 함께 변수 프로퍼티로 선언
```
protocol SomeProtocol {
  var mustBeSettable: Int { get set }
  var doesNotNeedToBeSettable: Int { get }
}
```

-> 실제 예시 적용  
```
protocol FullyNamed {
  var fullName: String { get }
}

struct Person: FullyNamed {
  var fullName: String
}

let john = Person(fullName: "John Appleseed")
```

### Method Requirements
- 프로토콜 내 메서드는 일반적인 인스턴스와 타입 메서드와 같은 방식으로 명시적으로 프로토콜의 정의의 부분으로 작성되지만 중괄호가 없거나 메서드 바디가 없다
```
protocol RandomNumberGenerator {
    func random() -> Double
}
```

### (⭐️)Mutating Method Requirements
메서드가 속한 인스턴스를 수정 또는 변경해야하는 경우가 있다. 이 때, 값 타입에 대한 인스턴스 메서드의 경우 메서드의 func 키워드 앞에 `mutating` 키워드를 추가한다.  

```
protocol Toggable {
  mutating func toggle() //해당 타입의 프로퍼티를 수정하여 모든 준수하는 타입의 상태를 전환하거나 반전하기 위한 것
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on
```

### Initializer Requirements
프로토콜을 준수하는 타입에 의해 지정된 구현된 초기화 구문을 요구할 수 있다
```
protocol SomeProtocol {
    init(someParameter: Int)
}
```

**프로토콜 초기화 구문 요구사항의 클래스 구현**  
`required` 수식어와 함께 초기화 구문 구현
```
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
```  
> 그런데 이거... 바로 전 시간에 정리한 OOP 원칙 SOLID 중에서 리스코프 치환 원칙을 위반하는 구현 아닌가요? 🙄😵‍💫  
리스코프 치환 원칙은 상위 타입(수퍼클래스)을 하위 타입(서브클래스)의 인스턴스로 바꿔도 프로그램의 동작을 해치지 않아야 한다는 원칙인데,  
부모를 강제 **override**한다는 점에서 자식이 부모의 동작을 제한하고 있는 모습인 것 같아요 흐음  

**final 클래스에는 required init이 함께 사용될 수 없는 이유?**  
`final` 표시를 통해 실수로 메서드, 프로퍼티, 또는 서브 스크립트를 **재정의하는 것을 방지**할 수 있다  
즉, 하위 클래스에서 final 메서드, 프로퍼티, 또는 서브 스크립트를 재정의하면 컴파일 시 에러가 발생한다.   
-> 따라서 final 클래스는 하위 클래스가 될 수 없기 때문에 `final` 수식어로 표시된 클래스에 `required` 수식어를 프로토콜 초기화 구문 구현에 표시할 필요가 없다.  

### (⭐️)Protocol as Types
