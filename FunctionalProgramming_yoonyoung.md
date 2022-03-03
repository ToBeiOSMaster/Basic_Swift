# Functional Programming
> swift는 OOP(Object Oriented Programming), POP(Protocol Oriented Programming), FP(Functional Programming)을 지원하는 멀티 패러다임 언어  

- 이전에는 작성하는 코드의 양이 늘어남에 따라, 구조를 객체 단위로 나누고 **재사용성**에 중심을 둔 OOP에 주목했다면,  
- 현재에는 CPU 하나에 여러 가지 Core, 하나의 컴퓨터에 여러 개의 CPU, 하나의 프로세스에도 멀티 스레드가 들어감에 따라 높은 메모리 환경을 가지게 되었고,  
이에 따라 하나의 반복된 작업을 병렬적으로 수행함으로써 응답 속도를 줄이는 **퍼포먼스와 동시성**에 주목함에 따라 FP를 주목하게 되었다.
- FP는 동시성을 직관적으로 해결하게 도와주는데,  
1) 데이터를 조작하지 않고
2) 한 번 만들어진 데이터는 변경하지 않고,
3) 변경된 데이터가 필요할 때에는 새로운 데이터를 만들어 낸다  
=> 데이터를 조작하지 않으면 같은 작업을 수행해도 원본 데이터에 영향을 끼치지 않으므로 결과적으로 **side-effect**가 발생하지 않도록 도와준다.

## - FP란, [순수함수]를 이용해서 프로그래밍하는 것?
* 순수함수 = 특정 input에 대해서 항상 동일한 output을 반환하는 함수
- output은 input에 의해서만 결정되기 때문에, 함수의 외부의 값으로부터 영향받지 않아 side-effect가 없다.
+) 함수의 parameter로 input을 전달하는 것만이 순수함수일까? NO, 외부의 변수가 `let`이라면 불변의 immutable data를 사용하는 것이기 때문에 순수 함수를 만족한다.

**>1급 객체**  
1급 객체란, 프로그래밍 언어에서 **함수의 파라미터로 전달되거나 리턴값으로 사용**될 수 있는 객체를 뜻한다  
-> FP에서는 함수를 1급 객체로 취급한다. 

**>High-Order Function**  
고차함수란, 함수를 파라미터로 받거나 함수를 리턴하는 함수  
ex) `filter`,`map`,`reduce`

## - 🧐Currying이란?
= 여러 개의 파라미터를 받는 함수를 하나의 파라미터를 받는 여러 개의 함수로 쪼개는 것  
-> (목적): 함수의 합성을 원활하게 하기 위한 목적  
-> (필요한 이유?): 함수의 output이 다른 함수의 input으로 연결되면서 합성이 되는데,  
함수들이 서로 chain을 이루면서 연속적으로 연결이 되려면 output을 input의 타입과 갯수가 같아야 한다.    
그래서 함수의 output은 하나밖에 없으니 input도 모두 하나씩만 갖도록 한다면 합성하기 쉬워질 것이라는 논리 -> 무슨 소리?  
> 🤕가독성이 진짜 떨어지고,, 이해하는 과정에서 너무 오래걸리는데 계속 적용해보면서 공부해봐야 할 개념인 것 같아요

**1) 커링 전**
```
func multiply(_ s1: Int, _ s2: Int) -> Int {
  reutrn s1*s2
}
```

**2) 커링 후**
```
func f1(_ s1: Int) -> Int
func f2(_ s2: Int) -> Int

func multiply(_ s1: Int) -> (Int) -> Int {
  return { s2 in
    return s1 * s2
  }
}

//풀어서 다시 작성하면 이런 느낌?
func multiply(_ s1: Int) -> (Int) -> Int {
  return func something(s2: Int) -> Void {
    return s1 * s2
   }
}


let result = multiply(10)(20)
```

## Async Result
UI작업에서 시간이 오래 걸리는 작업의 경우 비동기 방식으로 함수를 구현
```
func loadResult(_ nums: [Int], _ completion: @escaping (Int) -> Void) { 
  DispatchQueue.main.async {
    sleep(1)
    let sum = nums.reduce(0, +)
    result(sum)
  }
}
```
-> 여기서 중요한 것은, 결과가 리턴값으로 전달되는 것이 아닌, 전달받은 이스케이프 클로저 함수 `completion`를 호출함으로써 전달된다는 점이다

ref) 
- https://hyunndyblog.tistory.com/163
- https://flexiple.com/ios/introduction-to-functional-programming-using-swift/  
