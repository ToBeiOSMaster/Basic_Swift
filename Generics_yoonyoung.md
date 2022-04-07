## Generics
> 내일까지 보충해서 다시 업로드하겠습니다..!!!

Generic은 swift의 강력한 특징 중 하나이고, Swift 표준 라이브러리 대부분은 제너릭 코드로 되어 있다.  
ex) `Array`, `Dictionary`

Generic Code는  
- 정의한 요구사항에 따라 모든 타입에서 동작할 수 있는 유연하고 재사용 가능한 함수와 타입을 작성할 수 있다
- 중복을 피하고 명확하고 추상적인 방식으로 의도를 표현하는 코드를 작성할 수 있다

아래 3개의 함수는 a와 b의 타입이 모두 같아야 하는데,  
Swift는 타입 안정성 언어이고 String 타입의 변수와 Double 타입의 변수가 서로 값을 바꾸도록 허락하지 않기 때문이다.  
이러한 시도는 컴파일 에러가 발생한다.   
  
```
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//=> Generic verison
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
```

### Naming Type Parameters
대부분의 경우 타입 파라미터는 제너릭 타입 간의 관계나 함수간의 관계를 나타내기 위해 
- `DictionaryMKey, Value>` : Key와 Value  
- `Array<Element>` : Element  
와 같이 설명이 포함된 이름이지만, 의미있는 관계가 없을 때에는 `T`,`U`,`V`와 같은 단일 문자를 사용하여 이름을 지정하는 것이 일반적이다.  

### Generic Types
```
//Int값만을 수행하는 stack
struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//Generic을 사용하여 모든 타입의 값을 스택으로 관리할 수 있는 stack
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings
```

### Associated Types

아래 예시는 Item이 어떤 타입인지 정의하지 않고, 해당 정보는 모든 준수하는 타입이 제공할 수 있도록 남겨진다.
```
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//Element가 특정 Container에 대해 Item으로 사용되는 적절한 타입으로 유추 
struct Stack<Element>: Container {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
```
