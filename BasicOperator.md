# Basic Operator
### Terminology
 * 스위프트의 연산자는 특정한 문자로 표현한 함수
 * 특정 연산자의 역할알 프로그래머의 의도대로 변경할 수 있다.
 * 단항 (unary), 이항(binary), 삼항(ternary) 연산자가 존재한다
 
### 연산자의 종류
* 할당연산자
* 산술연산자
* 비교연산자
* 삼항 조건 연산자
* 범위연산자
* 부울연산자
* 비트연산자
* 복합할당연산자
* 오버플로우 연산자

### 할당연산자
* 값을 할당할 때 사용
* A = B
* 서로 데이터 타입이 다르면 오류 발생

### 산술연산자
* 더하기(+), 뺴기(-), 곱하기(*), 나누기(/), 나머지 (%)
* 스위프트에서는 보동소수점 타입의 나머지 연산자 지원
```
let number: Double = 5.0
var result: Double = number.truncatingRemainder(dividingBy: 1.5) //0.5
result = 12.truncatingRemainder(dividingBy: 2.5) // 2.0
```
* 다른 타입의 연산에서는 연산 엄격히 제한 
* UInt와 Int도 제한

### 비교연산자
* ==. >=, <=, >, <. !=, ===, ~=
* === : 참조 타입일때 A와 B가 같은 인스턴트스를 가리키는지 비교하여 불리언 값 반환
* ~= : 패턴매치, 패턴이 매치되는지 확인하여 불리연 반환

### +참조비교연산자
* 스위프트의 기본 데이터 타입은 모두 `구조체`로 구현되어 있다
* 값의 비교는 `==`연산자를 활용하고 클래스의 인스턴스인 경우에만 `===`를 사용한다

### 삼항조건연산자
* 조건 ? A : B 
* 조건이 참이면 A 아니면 B 반환

### 범위연산자
* A…B : A부터 B까지
* A..<B : A부터 B미만까지
* …A : A 이하
* A… : A 이상
* _ < A : ㅁ 미만

### 부울 연산자
* !A : A가 아니다 (NOT)
* A && B : A 와 B (AND)
* A || B : A 또는 B (OR)

### 비트 연산자
* ~A : A의 비트 반전 결과
* A & B :  A 와 B의 AND 연산
* A | B :  A 와 B의 OR 연산
* A ^ B : :  A 와 B의 XOR 연산
* A >> B : B만큼 시프트
* A << B

### 오버플로우 연산자
* 기본 연산자를 통해 오버플로우를 대비할 수 있음
* &+ : 오버플로우 덧셈
* &- : 오버플로우 뺼셈
* &* : 오버플로우 곱셈
```
var unsignedInteger: UInt8 = 0
let errorUnderflowResult: UInt8 = unsignedInteger - 1 // 런타임 에러
let underflowedValue: UInt8 = unsignedInteger& - 1 // 255
```

### 기타 연산자
* A ?? B : A가 nil이면 B, 아니면 A 반환
* -A : A의 부호를 변경
* A! : A(옵셔널개체)의 값을 강제로 추출
* A? : A를 안전하게 추출하거나 A가 옵셔널임을 표현
*  