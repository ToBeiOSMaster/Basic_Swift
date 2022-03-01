# Closure
- 클로저란, 코드에서 주변에 전달과 사용할 수 있는 자체 포함된 기능 블럭
- 클로저는 정의된 컨텍스트에서 모든 상수와 변수에 대한 참조를 캡처하고 저장할 수 있다. 이러한 상수와 변수를 **closing over(폐쇄)** 라고 한다

**클로저의 형태 3가지**
1) 전역 함수는 이름을 가지고 어떠한 값도 캡처하지 않는 클로저
2) 중첩 함수는 이름을 가지고 둘러싼 함수로부터 값을 캡처할 수 있는 클로저
3) 클로저 표현식은 주변 컨텍스트에서 값을 캡처할 수 있는 경량 구문으로 작성된 이름이 없는 클로저

**클로저의 표현식 스타일**
- 컨텍스트에서 파라미터와 반환값 타입 유추
- 단일 표현식 클로저의 암시적 반환
- 약식 인자 이름
- 후행 클로저 구문

## 클로저의 표현식
클로저 표현식은 간단하고 집중적인 구문으로 인라인 클로저로 작성하는 방법

**클로저를 제공하는 방법**
1) 올바른 타입의 일반 함수를 작성하고 클로저 메서드에 인자로 전달
```
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
```

2) 인라인 클로저 방식
```
//클로저의 표현구
{ (parameters) -> return type in
  statements
}

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

  2-1) 파라미터 타입과 반환 타입을 유추하는 인라인 클로저 방식
```
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
```

  2-2) `return` 키워드를 생략한 단일 표현 클로저의 암시적 반환(Implicit Returns from Single-Expression Closures)
```
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
```

  2-3) 짧은 인자 이름을 사용한 클로저 방식
Swift는 인라인 클로저에 `$0` , `$1` 등 클로저의 인자값으로 참조하는데 사용할 수 있는 짧은 인자를 제공한다.
```
reversedNames = names.sorted(by: { $0 > $1 } )
```

3) 후행 클로저
- 함수의 마지막 인자로 함수에 클로저 표현식을 전달해야하고 클로저 표현식이 긴 경우에 용이
```
//후행 클로저를 사용하지 않을 경우
func functionWithClosure2(closure: { })

//후행 클로저를 사용하는 경우 -> 메서드의 소괄호 바깥에 작성 가능
func functionWithClosure3() { }
```

## 캡처값(Capturing Values)
- 클로저는 정의된 둘러싸인 컨텍스트에서 상수와 변수를 캡처할 수 있다
- **캡처란?** 상수와 변수를 정의한 원래 범위가 더이상 존재하지 않더라도 바디 내에서 해당 상수와 변수의 값을 참조하고 수정할 수 있도록 하는 행위?
```
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    
    //incremeter 함수는 파라미터가 없으며 바디 내에 runningTotal과 amount를 참조
    //둘러싸인 함수에 runningTotal과 amount에 대한 참조를 캡처하고 함수 내에서 사용
    //참조를 캡처하는 것?: makeIncrementer 호출이 종료될 때 runningTotal과 amount가 사라지지 않고 다음에 incremeter 함수가 호출될 때 runningTotal을 사용할 수 있는 것
    //incrementBySeven과 incrementByTen은 상수이지만 이러한 상수가 참조하는 클로저는 캡처한 runningTotal 변수를 계속 증가시킬 수 있다.
    //그 이유는 함수와 클로저가 reference types이기 때문!(값타입이었다면 동일한 값을 복사해서 사용하는 개념이므로, 원하는 변수의 값을 증가시킬 수 없을 것)
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

## ⭐️클로저는 참조 타입(Closure Are Reference Types)
함수 또는 클로저를 상수 또는 변수에 할당할 때마다 실제로 **상수 또는 변수를 함수 또는 클로저에 대한 참조로 설정**한다.

## Escaping Closures
- **@escaping**이란, 클로저를 파라미터로 가지는 함수를 선언할 때 이 클로저는 탈출을 허락한다는 뜻

### 클로저가 탈출할 수 있는 방법
1) 함수 바깥에 정의된 변수에 저장되는 것  
ex) 비동기 작업을 시작하는 대부분의 함수는 완료 핸들러로 클로저 사용
```
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

* self를 참조하는 escape closure는 self가 클래스의 인스턴스를 참조하는 경우, escape closure에 self 캡처는 강한 참조 사이클이 생기기 쉽기 떄문에 주의해서 사용해야 한다
> 일반적으로 클로저는 클로저 내부에서 변수를 사용하여 암시적으로 변수를 캡처하지만 이 경우에는 명시적이어야 한다.   
self 를 캡처하려면 사용할 때 **명시적으로 self 를 작성하거나 클로저의 캡처 목록에 self 를 포함**합니다.   
self 를 명시적으로 작성하는데 의도를 표현하고 참조 사이클이 없음을 확인하도록 상기시켜 줘야 한다

```
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 } //명시적으로 self를 작성
        someFunctionWithNonescapingClosure { x = 200 } //암시적으로 self 참조
    }
}
```

### -> 그렇다면 escaping, non-escaping closure를 나눠서 사용하는 이유? = 컴파일러의 퍼포먼스와 최적화
 * non-escaping closure: 컴파일러가 클로저의 실행이 언제 종료되는지 알기 때문에 때에 따라 클로저에서 사용하는 특정 객체에 대한 retain, release 등의 처리를 생략해 객체의 라이프사이클을 효율적으로 관리한다  
   
 * escaping closure: 함수 밖에서 실행되기 때문에 클로저가 함수 밖에서도 적절히 실행되는 것을 보장하기 위해,
 클로저에서 사용하는 객체에 대한 추가적인 reference cycles 관리 등을 해줘야 한다

