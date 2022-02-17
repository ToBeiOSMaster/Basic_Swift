# Basic
### Swift 언어의 특징
* Safe, Fast, Expressive
* Safe
	* Swift는 `type safe`한 언어이다 
	* 프로그래머가 저지를 수 있는 실수를 엄격한 문법을 적용해 미연에 방지하려고 노력한다
	* ex) optional, guard, 오류처리, 강력한 타입통제
* Fast
	* C언어 수준과 동등한 성능을 일정한 수준으로 유지하는데 초점을 맞춰 개발되었다
	* 실행속도의 최적화뿐만 아니라 컴파일러를 지속적으로 개량하고 있다
* Expressive
	* 사용하기 편하고 보기 좋은 문법을 구사하려고 노력했음
* 여러 패러다임을 차용한 `다중 패러다임`언어
	* 명령형 프로그래망, 객체지향 프로그래망, **함수형** 프로그래밍, **프로토콜** 지향 프로그래밍

### 함수형 프로그래밍 (간단히)
* 상태의 변화 없이 데이터 처리를 수학적 함수 계산으로 취급하고자 하는 패러다임
* 값이나 상태의 변화보다 `함수 자체의 응용`을 중요하게 여김
* 순수하게 함수에 전달된 인자 값만 결과에 영향을 준다
* 대규모 병렬처리가 쉬움 (사이드이펙드가 별로 없다)
* 함수를 일급 객체로 다룸

### var vs let
* 상수는 **let 키워드**를 사용해서 선언, 변수는 **var 키워드**를 사용해서 선언
```
func hackInterview(for value: String) {
	value = "android"
}

hackInterview(for:"ios")
```
* 위의 상황에서 중간에 파라미터 값을 바꾸게되면 컴파일 에러를 냄 => 함수 파라미터는 상수다
* `var [변수명] : [테이터 타입] = [값] `의 형태로 **변수** 선언
* `let [상수명] : [데이터 타입] = [값]` 의 형태로 **상수** 선언

### Type Safety 와 Type Inference
* Swift는 type safe 하기 때문에 코드를 컴파일 할 떄 타임 검살ㄹ 수행하고 일치하지 않는 타입을 오류로 표시한다 
* 특정 타입을 지정하지 않으면 Swift가 적절한 타입으로 타입을 유추한다
```
let meaningOfLift = 42
// Int로 자동 유추
```
* 

### 타입 별칭 (Type Aliases)
* 이미 존재하는 타입을 다른 이름으로 정의한다
```
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
// 0
```

