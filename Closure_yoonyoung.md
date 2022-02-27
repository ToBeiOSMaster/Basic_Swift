정리 업로드에 앞서,,, 시간이 촉박해 이정도밖에 정리 못했네요,,, 주말까지 보완해서 같이 업데이트하겠습니다..!

# Closure
- 클로저란, 코드에서 주변에 전달과 사용할 수 있는 자체 포함된 기능 블럭
- 클로저는 정의된 컨텍스트에서 모든 상수와 변수에 대한 참조를 캡처하고 저장할 수 있다. 이러한 상수와 변수를 **closing over(폐쇄)**라고 한다

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
    //incrementBySeven과 incrementByTen은 상수이지만 이러한 상수가 참조하는 클로저는 캡처한 runningTotal 변수를 
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

## ⭐️클로저는 참조 타입(Closure Are Reference Types)

