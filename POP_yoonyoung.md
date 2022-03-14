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
