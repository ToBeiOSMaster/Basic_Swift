# Closure 활용

## Completion Handler

* 후행 클로저가 completion Handler로 많이 쓰인다

### 후행클로저 (다시 짚고 넘어가기)

- 함수의 마지막 인자로 클로저 표현식을 함수에 전달하거나 클로저 표현식이 긴 경우 사용한다

  ```swift
  func travel (action: () -> Void){
    print("hihihihi1")
    action()
    print("hihihihi2")
  }
  ```

- travel 함수는 인자로 action이라는 함수를 채택하고 있다

```swift
travel() {
  print("action closure")
}

travel{
  print("action clousre")
}
```

* 이렇게 travel이라는 함수의 후행 클로저를 실행 시킬 수 있다

### completion handler란?

* 어떠한 일이 끝났을때 진행하는 것
* 클로저의 수행 역할 중 하나가 동작 실행 순서를 보장하는 것 이었는데 이에 관련된게 completion handler인것 같다

```swift
let firstVC = UIViewController()
let nextVC = UIViewController()

firstVC.present(nextVC, animated: true, completion: nil)
```

* completion 파라미터에는 () -> ()  or () -> Void 클로저 적용가능

```swift
firstVC.present(nextVC, animated: true) { print("화면 바꿈!!!")}
```

* nextVC가 popup되면서 콘솔에 문자열이 출력됨

### completion을 통한 데이터 전달

```swift
Alamofire.request("https://www.google.com").responseJSON{ response in 
  print(response)
}
```

* 메서드의 request가 서버로 전달되면서 response 인자에 담겨 이를 클로저 내부에서 사용할 수 있게된다



# AutoClosure

* AutoClosure는 저번에도 왜 사용할까,,,?라는 의문점이 들었다. 굳이? 아직 간결한 코드 밖에 보지 않아서 그런가 AutoClosure의 명확한 사용 이유가 와닿지는 않는다!



### AutoClosure 사용 의문점!

* 중괄호를 생략하고 일반 표현식처럼 보이게 하는 일종의 클로저
* 내부적으로는 여전히 폐쇄 상태 -> 이걸 이해하면 되는데,,,흠,,,,functional programming 공부를 해본적이 없어서 그런지 나에게 아직 와닿지 않는 개념이다!



### AutoClosure란

*  @autoclosure는 함수에 전달된 인수에서 자동으로 클로저를 생성
* 인수를 클로저로 바꾸면 인수의 실제 요청을 지연시킬 수 있다

```swift
struct Person: CustomStringConvertible {
     let name: String
     
     var description: String {
         print("Asking for Person description.")
         return "Person name is \(name)"
     }
 }

 let isDebuggingEnabled: Bool = false
 
 func debugLog(_ message: String) {
     if isDebuggingEnabled {
         print("[DEBUG] \(message)")
     }
 }

 let person = Person(name: "Bernie")
 debugLog(person.description)
```



```swift
let isDebuggingEnabled: Bool = false

 func debugLog(_ message: () -> String) {
     /// You could replace this in projects with #if DEBUG
     if isDebuggingEnabled {
         print("[DEBUG] \(message())")
     }
 }

 let person = Person(name: "Bernie")
```

* 클로저 호출은 디버깅이 활성화 된 `message()`경우에만 호출된다
*  @autoClosure로 brace를 제거하고 보기 좋은 코드 입력가능

```swift
 let isDebuggingEnabled: Bool = false
 
 func debugLog(_ message: @autoclosure () -> String) {
     /// You could replace this in projects with #if DEBUG
     if isDebuggingEnabled {
         print("[DEBUG] \(message())")
     }
 }

 let person = Person(name: "Bernie")
 debugLog(person.description)
```



### autoClosure

```swift
public func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line)
```

* 실제 swift에서 assert 함수를 타고 올라가면 보이는 정의이다
* @autoclousre 선언을 통해서 사람들은 assert 함수의 첫 파라미터에 `{ }` brace 없이 간결한 코드 입력이 가능해졌다
* 저번부터 생각해봤지만 이게 autoClosure의 활용이 끝인가,,,,? 아직 프로젝트를 안해봐서그런지 와닿지가 않는당,,,!