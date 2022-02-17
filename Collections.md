# Collection
### 정의
* 집합 컨테이너를 묘사하는 프로토콜
* Collection = Sequence 프로토콜 상속 + 인덱스를 통해 개별 원소 액세스
* Array, Set, Dictionary가 있다
* 저장할 수 있는 값의 타입가 키에 대해서 항상 명확하다
* 콜렉션에는 잘못된 타입을 추가 할 수 없다
* 값에 대한 타입이 명확하다

### Sequence 프로토콜
* 직역 -> 연속열
* 개개의 원소들을 순서대로 하나씩 순회할 수 있는 타입을 의미
* 모든 집합 타입이 이에 해당함
* `for - in `구문에서 사용
```
let numbers = 2...7
for n in numbers {
	print(n)
}
```
* Sequence 프로토콜의 조건
	* `makeIterator()`만 구현해 주면 된다
	* makeIterator는 `IteratorProtocol`을 만족해야하는 타입
	* 매 스텝에서 다음번 원소를 리턴해주는 시퀀스 엔진과 같다
```
struct CountDown: Sequence {
    var value: Int
    struct CountDownIterator: IteratorProtocol {
        var value: Int
        mutating func next() -> Int ? {
            if value < 0 { return nil }
            defer{ value -= 1}
            return value
        }
    }
    func makeIterator() -> CountDownIterator {
        return CountDownIterator(value: self.value)
    }
}
for i in CountDown(value: 5) {
  print(i)
}
// 5, 4, 3, 2, 1, 0
```

	* IteratorProtocol을 만족한다면 되기 때문에 실질적으로는 next()라는 메소드 하나만 정의해주면 된다.

```
struct SimpleCountDown: Sequence, IteratorProtocol {
    var value: Int
    mutating func next() -> Int? {
      if value < 0 { return nil }
      value -= 1
      return value + 1
    }
}
for i in SimpleCountDown(5) { print(i) }
// 5, 4, 3, 2, 1, 0 각 라인에 출력
```

### Collection
* Collection내의 모든 원소는 집합 구조 내에서 자신의 위치를 특정 지을 수 있는 인덱스를 갖는다.
* 모든 원소는 고정된 고유의 위치를 가지며, 이는 인덱스를 통해서 액세스 할 수 있다.
* 두 원소간의 거리는 인덱스의 거리로 표현할 수 있고, 두 인덱스간의 범위를 통해 처음과 끝이 아닌 중가 부분의 부분열을 얻을 수 있다.
* 개별 원소를 소모하지 않고 인덱스를 조작하여 순회하는 것이 가능하다.
* `랜덤액세스`가 가능하다
* `Comparable`프로토콜을 만족해야한다.

### Collection 프로토콜의 조건
* startIndex, endIndex 프로퍼티 제공
* 인덱스를 이용해 원소를 액세스하는 subscript(_:)를 구현해야한다.
* 내부에서 인덱스를 증가시키기 위해 index(after:)를 구현해주어야한다.

### Array
* 같은 타입의 데이터를 일렬로 나열 후 순서대로 저장
* let으로 선언하면 변경 불가
* 빈 배열을 이니셜라이저 또는 문법을 통해 생성 가능
* 인덱스는 0부터 시작
* 잘못된 인덱스로 접근하면 오류 발생
* first, last 프로퍼티 존재
```
var names: Array<String> = ["one", "two", "three"]
var numbers: [String] = ["one", "two", "three"]

var emptyArray: [Any] = [Any]()
var emptyArray: [Any] = Array<Any>()
var emptyArray: [Any] = []

names.append("four")
names.append(contentsOf: ["five", "six"])
names.insert("half", at:0)
```

### Set
* Set형태로 저장되기 위해서는 반드시 타입이 `hashable`이어야만 한다.
```
var letters = Set<Character>() //빈 Set생성
letters.insert("a")
letters = [] //빈 Set
```
* Set과 Array의 차이는 **중복여부**
```
let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]

oddDigits.uion(evenDigits).sorted() //[0,1,2,3,4,5,6,7,8,9]
oddDigits.intersection(evenDigits).sorted() // []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() // [1,9]
oddDigits.symmetricDifference(singleDigitPrimeNumers).sorted() //[1,2,9]
```


### Dictionary
* 순서 없이 키와 값의 쌍으로 구성되는 컬렉션
* Dictionary<KeyType, ValueType> 형태로 쓰여야한다
* KeyType은 반드시 `해쉬가능`한 타입이여야한다

### Hashable
* integer hash value를 생성하는 Hasher로 hash될 수 있는 타입
* Hashable protocol을 상속 받는다는 건 **hash 될 수 있는** 타입
	* Key가 unique해야한다
* Hashable은 Equatable protocol을 상속 받고 있다 
```
protocol Equatable {
	static func == (lhs: Self, rhs: Self) -> Bool
}
```
* Hashable이 되기 위한 두가지 조건
	* Equatable에 있는 == 함수를 구현
	* HashValue를 만든다
* 현재 Swift5 기준으로 hashValue를 직접 설정 해주는 것은 deprecated 되어있음
	* Hashable protocol에 있었던 func hash(into hasher: inoutHa Hasher)를 사용하라고 되어있음

