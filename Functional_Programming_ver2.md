# Functional Programming

### Functional Programming이란

* `순수 함수(pure function)`를 조합하고 공유 상태(shared state), 변경 가능한 데이터(mutable data) 및 부작용(side-effects) 을 피하는 기본 원칙에 따라 소프트웨어를 구성하는 프로그래밍 패러다임

> 객체지향은 동작하는 부분을 캡슐화해서 이해할 수 있게 하고, 함수형 프로그래밍은 **동작하는 부분을 최소화**해서 코드 이해를 돕는다. 

* 명령형이 아닌 <u>*선언적 방식*</u>으로 구현되며 흐름 제어를 명시적으로 기술하지 않고 프로그램 로직이 표현된다는 것
  * **명령형 프로그래밍**: 무엇(What)을 할 것인지 나타내기보다 <u>어떻게(How)</u> 할 건지를 설명하는 방식
    - 절차지향 프로그래밍: 수행되어야 할 순차적인 처리 과정을 포함하는 방식 (C, C++)
    - 객체지향 프로그래밍: 객체들의 집합으로 프로그램의 상호작용을 표현 (C++, Java, C#)
  * **선언형 프로그래밍**: 어떻게 할건지(How)를 나타내기보다 <u>무엇(What)</u>을 할 건지를 설명하는 방식
    - 함수형 프로그래밍: 순수 함수를 조합하고 소프트웨어를 만드는 방식 (클로저, 하스켈, 리스프)

* 특징
  * 불변 데이터(Immutable Data)
  * 1급 함수(First-Class Function)
  * 순수 함수(Pure Function)
* 알아야할 개념
  * 순수 함수(Pure functions)
  * 합성 함수(Function composition)
  * 공유 상태 피하기(Avoid shared state)
  * 상태 변경 피하기(Avoid mutating state)
  * side effects 피하기(Avoid side effects)



### Pure functions

* 주어진 입력으로 계산하는 것 이외의 <u>프로그램의 실행에 영향을 미치는 부수 효과(Side Effect)가 없는 함수</u>
* 똑같은 파라미터가 주어졌을 때 항시 같은 값이 반환되어야 한다
* 같은 입력 값이라면, 항상 같은 결과 값을 반환한다 + side-effects를 가지지 않는다

```swift
func pureAdd(a: Int, b:Int){
    return a+b
}

print(pureAdd(a: 5, b: 5)) // 10

let c = 2

func notPure(a: Int){
  	c+=2
    return a*2
}

print(notPure(a: 2)) // 4
print(notPure(a: 2)) // 8

```

### 그렇다면  전역변수를 최대한 함수안에서 조작하는 일이 없고 파라미터로면 함수를 구성하면 되는 것인가,,,,? 😵

* [ 순수함수 예제](https://velog.io/@recordboy/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%EC%9D%98-%EC%88%9C%EC%88%98-%ED%95%A8%EC%88%98Pure-Function)

```swift

struct Obj{
    var a:Int = 1
}

func copy(param:Obj) -> Obj{
    return param
}

var temp = Obj()

var temp2 = copy(param: temp)

temp2.a = 3

print(temp.a) // 1
print(temp2.a)  //3
```

* 위의 예제를 보고 swift 예제로 바꾸어 봤다. swift struct는 call by value,  class는 call by reference여서 class로 작성시 pure function에 대해 주의해야할 것 같다.



### Function composition

* 우리가 고등학교때 배웠던 f(g(x))와 비슷한개념

```swift
func all(a: Int) -> Int {
    return (a + 10)*5
}

print(all(a: 10)) // 100

// 합성함수
func addTen(a: Int) -> Int{
    return a + 10
}

func multiFive(a: Int) -> Int{
    return a*5
}
print(multiFive(a: addTen(a: 10)))
```

* 여기서도 <u>***정의역과 치역의 관계성***</u>이 나타나고 그안에서 함수형 프로그래밍이 이루어진다 
  * [참고 링크](https://evan-moon.github.io/2020/01/27/safety-function-composition/)
  * 이전에 조사했던 factor와 monade를 조금더 공부하고 보면 좋을 것 같은 링크



### Void Shared State (공유상태)

* 공유되는 스코프안에 존재하는 모든 변수, 객체, 메모리 공간이거나 스코프 간에 전달되는 객체의 속성
* 전역 스코프, 클로즈 스코프
* 어떤 함수의 영향을 이해하기 위해서 그 함수가 사용하거나 영향을 미친 모든 공유된 변수의 전체 히스토리를 알아야 된다는 것
* **Race condition**을 말하는 것같다



### 상태 변경 피하기(Avoid mutating state) == Immutable

* 생성된 이후에는 바꿀 수 없는 객체
* 불변성이 없다면 프로그램의 데이터 흐름이 손실된다. 상태의 history가 버려지고, 이상한 버그가 당신의 소프트웨어에 발생할 수 있다.
* swift에서는 `let` 키워드가 object를 immutable하게 만드는 방법인것 같다.

