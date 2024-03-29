## Protocol Oriented Programming 2
> 이번 스터디에서는 프로토콜 활용에 있어 마이너한 부분에 대해 공부해보았습니다.  

### Conditionally Conforming to a Protocol

타입을 확장할 때, 제약조건을 나열하여 일반 타입이 프로토콜을 **조건적으로 준수**할 수 있도록 만들 수 있다.  
- 일반적인 `where`절을 작성하여 채택 중인 프로토콜의 이름 뒤에 제약조건을 작성  

```
// 배열 내 요소들이 TextRepresentable 프로토콜을 준수할 때만 textualDescription 변수 추가
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let myDice = [d6, d12]
print(myDice.textualDescription)
// Prints "[A 6-sided dice, A 12-sided dice]"
```

**Generic Where Clauses**
Type Constraints를 사용하면 제너릭 함수, 서브 스크립트, 또는 타입과 연관된 타입 파라미터에 대한 요구사항을 정의할 수 있다.

```
// == 연산자를 활용하고 있기 때문에 제너릭 where절을 활용하지 않을 경우 컴파일 에러 발생
// 왜? Stack의 정의는 항목이 동등한지 요구하지 않으므로, 제너릭 where절을 사용하여 확장에 새로운 요구사항을 추가해야 한다.
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

struct NotEquatable { }
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
notEquatableStack.isTop(notEquatableValue)  // Error
```

### Protocol Inheritance
프로토콜은 하나 또는 그 이상의 다른 프로토콜을 상속할 수 있고, 상속한 요구사항 위에 요구사항을 더 추가할 수 있다

```
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}
```

### Class-Only Protocols
프로토콜 채택을 프로토콜의 상속 목록에 `AnyObject` 프로토콜을 추구하여 구조체 또는 열거형이 아닌 클래스 타입으로 제한할 수 있다
```
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // class-only protocol definition goes here
}
```

### Optional Protocol Requirements
프로토콜에 대해 optional requirements을 정의할 수 있다. **이 요구사항은 프로토콜을 준수하는 타입으로 구현될 필요가 없다**   
- 옵셔널 요구사항은 프로토콜의 정의의 부분으로 `optional` 수식어를 앞에 붙인다
- 옵셔널 요구사항은 Objective-C와 상호운용되는 코드를 작성할 수 있다

### Providing Default Implementations
**해당 프로토콜의 모든 메서드 또는 계산된 프로퍼티 요구사항에 기본 구현을 위해 프로토콜 확장을 사용할 수 있다.**  
준수하는 타입이 필수 메서드 또는 프로퍼티 자체 구현을 제공하먄 해당 구현은 확장에 의해 제공되는 구현 대신 사용된다

> 확장에 의해 제공된 기본 구현을 가진 프로토콜 요구사항은 옵셔널 프로토콜 요구사항과 다르다.  
> 준수하는 타입이 자체 구현을 제공할 필요는 없지만 기본 구현을 가진 요구사항은 옵셔널 체이닝 없이 호출 가능  

```
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}
```
