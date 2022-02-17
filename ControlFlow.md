# [Control Flow(제어 흐름)](https://bbiguduk.gitbook.io/swift/language-guide-1/control-flow)

### 1. For-In 루프
배열에 아이템, 범위의 숫자 또는 문자열에 문자와 같은 연속된 것에 대해 `for-in` 루프를 사용하여 반복할 수 있다.
```
let names = ["yoonyoung", "Alex", "Brian"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, yoonyoung!
// Hello, Alex!
// Hello, Brian!
```

`for-in` 루프 바디 내에서 사용하기 위해 `(key, value)` 튜플의 멤버를 명시적으로 이름을 가진 상수로 분해할 수 있다
```
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs
```
  
숫자 범위에 대해 `for-in` 루프를 사용할 수 있다
```
for index in 1...5 {
  print(index)
}

//1
//2
//3
//4
//5
```

+) 시퀀스로부터 각 값이 필요하지 않다면 변수 이름의 위치에 언더바를 사용하여 값을 무시할 수 있다
```
var count = 0
let max = 5
for _ in 1...max {
  count += 1
  print(count)
}
//1
//2
//3
//4
//5

count = 0
for _ in 1..<max {
  count += 1
  print(count)
}
//1
//2
//3
//4

//닫힌 범위 전까지 출력 가능
for trikMark in stride(from: 0, to: 15, by: 5) {
  print(trikMark)
}
//0
//5
//10
//15
//20

//닫힌 범위도 출력 가능
for trikMark in stride(from: 3, through: 12, by: 3) {
  print(trikMark)
}
//3
//6
//9
//12
```

> 아래 구문들은 일반적인 문법과 동일하거나 겹치는 부분이 크다고 생각해서, comment나 Issue로 더 공부하고 싶은 요소가 있다면 적어주시면 제가 더 자세한 설명으로 작성해보도록 하겠습니다.
- While 루프
- Repeat-While
- 조건 구문
  - If
  - Switch
  - 명시적 Fallthrough
  - 간격 일치(Interval Matching)
  - 튜플
  - 값 바인딩
  - where
  - 혼합 케이스
  - 제어 변경 구문
  - continue
  - break
  - fallthrough
  - 라벨이 있는 구문
  - 이른 종료
  - 사용 가능한 API 확인
