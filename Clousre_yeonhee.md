# Closure

>  클로저란? 일정 기능을 하는 코드를 하나의 블록을 모아 놓은 것
>
> * **코드 안에서 전달되어 사용할 수 있는 로직**을 가진 중괄호로 구분된 코드 블럭, **일급 객체**의 역할을 할 수 있다
> * 일급객체는 전달 인자로 보낼 수 있고, 변수/상수 등으로 저장하거나 전달할 수 있으며, 함수의 반환 값이 될 수도 있다.
> * **참조 타입**
> * 함수는 클로저의 한 형태, 이름이 있는 클로저

### Clousre의 종류

![image-20220224135204909](/Users/yeoni/Library/Application Support/typora-user-images/image-20220224135204909.png)

* Named Closure와 Unnamed Clousred로 나뉜다
* 함수는 Named Closure의 한 종류
* 흔히 Clousre라고 부르는 것은 Unnaed Clousre

```swift
let closure = { print("Somaker") }
```



### Clousre의 형태

* 이름이 있으면서 어떤 값도 획득하지 않는 전역함수의 형태
* 이름이 있으면서 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태
* 이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성한 형태



### Clousre 표현방식

```swift
{ (parameters) -> returnType in
	로직구현
}
```



### 전달인자로 함수를 보낸다?

![image-20220224141342705](/Users/yeoni/Library/Application Support/typora-user-images/image-20220224141342705.png)

* Sorted 메소드는 배열의 타입과 같은 두 개의 매개변수를 가지며 Bool타입을 반환하는 클로저를 전달 인자로 받을 수 있다.

```swift
let names: [String]  = ["wizplan", "eric", "yagom", "jenny"]

func backwards(first: String, second:String) -> Bool {
  return first > second
}

let reversed: [String]  = names.sorted(by: backwards)
```

* **단축인자**를 통해서 매개변수 이름을 쓰지 않아도 된다
  * $0, $1, $2로 전달인자 표현 가능 
  * `in`키워드도 필요 없음

```swift
let reversed: [String] = names.sorted{
  return $0 > $1
}
```



### 후행 Clousre

* 함수나 메서드의 **마지막 전달인자로 위치하는 클로저**는 함수나 메서드의 **소괄호를 닫은 후 작성해도 된다**
* 가독성이 조금 떨어진다 싶으면 사용하면 좋다
* 매개변수에 클로저가 여러개 있는 경우, **다중 후행 클로저 문법**을 사용할 수 있다
  * 중괄호를 열고 닫음으로써 클로저를 표기

```swift
// 후행 클로저의 사용
let reversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
	return first > second  
}

// 소괄호 생략 가능
let reversed: [String] = names.sorted {(first: String, second: String) -> Bool in
	return first > second  
}

//다중 후행 클로져
func doSomething(do: (String) -> Void,
                onSuccess: (Any) -> Void,
                onFailure: (Error) -> Void){
  // 실행 로직
}

doSomthing { (someString: String) in
  // 로직
} onSuccess: { (result: Any) in
  // 로직
} onFailure: { (error: Error) in
	// 로직
}
```



### Capturing Value

* 클로저는 특정 문맥의 상수나 변수의 값을 캡쳐할 수 있다.
* 원본 값이 사라져도 클로저 안의 body안에서 그 값을 활용할 수 있다.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let plusTen = makeIncrementer(forIncrement: 10)
let plusSeven = makeIncrementer(forIncrement: 7)

// 함수가 각기 실행되어도 실제로는 변수 runnigTotal과 amount가 캡쳐되서 그 변수를 공유하기 때문에 누적된 결과를 가진다.
let plusedTen = plusTen() // 10
let plusedTen2 = plusTen() // 20
// 다른 클로저이기 때문에 고유의 저장소에 runningTotal과 amount를 캡쳐해서 사용한다.
let plusedSeven = plusSeven() // 7
let plusedSeven2 = plusSeven() // 14
```

- plusTen, plusSeven이 상수이지만 runningTotal을 증가시킬 수 있었던 이유는 **클로저가 참조타입이기 때문**

> 함수와 클로저를 상수나 변수에 할당할 때 실제로는 상수와 변수에 해당 함수나 클로저의 참조가 할당된다. 만약 **한 클로저를 두 상수나 변수에 할당하면 그 두 상수나 변수는 같은 클로저를 참조하고 있게되는 것**

- 최적화를 이유로 Swift는 그 **값이 클로저에 의해 변경되지 않고, 클로저가 생성된 후 값이 변경되지 않는 경우 값의 복사본을 캡쳐하여 저장한다.**
- 또한 Swift는 변수를 더 이상 필요하지 않을 때 처리하는 모든 메모리 관리를 처리한다.

> 만약 **클로저를 어떤 클래스 인스턴스의 프로퍼티로 할당하고 그 클로저가 그 인스턴스를 캡쳐하면 강한 순환 참조에 빠지게 된다.** 즉. 인스턴스의 사용이 끝나도 메모리를 해제하지 못하는 것이다. 그래서 swift는 이 문제를 다루기 위해 **캡쳐 리스트를 사용**한다.



### 🥲 메모리 관련해서 공부를 해야할것같다... 아직 멀고도 험한 swift의 길,,,,

### Escaping Clousre

* 함수의 전달인자로 전달한 클로저가 **함수 종료 후에 호출될 때** 클로저가 함수를 **탈출한다**고 표현한다 
* `@escaping` 키쿼드를 사용하여 명시
* 함수 외부에 정의된 변수나 상수에 저장되어 함수가 종료된 후에 사용할 경우
  * Ex) 비동기 작업을 하기 위해 컴플리션 핸들러를 전달인자를 이용해 클로저 형태로 받는 함수들
* ***하나의 함수가 마무리된 상태에서만 다른 함수가 실행되도록 함수를 작성할 수 있다 (함수 사이의 실행순서를 정할 수 있다)***

```swift
var completionHandlers: [ () -> Void ] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void){
  completionHandlers.append(completionHandler)
}
```

* @escaping을 사용하는 클로저에서는 **self**를 명시적으로 언급해줘야한다



### AutoClousre

* 인자 값이 없으며 특정 표현을 감싸서 다른 함수에 전달 인자로 사용할 수 있는 클로저
* 실행하기 전까지 실행되지 않는다
* 계산이 복잡한 연산을 할때 유용하다

😢 ***자동클로저는 명확히 이해가 가지 않는다.... 다음번까지 깃에서 예제를 좀 뒤져보고 추가해야 할 것 같다!***



