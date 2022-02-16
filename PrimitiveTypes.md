# [Primitive Types](https://bbiguduk.gitbook.io/swift/language-guide-1/strings-and-characters)

## String
```
let exString = "example String"
```
Swift의 String 타입은 Foundation의 NSString 클래스와 연결되어 있다. 
Foundation은 NSString에 의해 정의된 메서드를 노출시키기 위해 String을 확장하는 역할을 수행한다. (Extension?)
> 어떤 String 인스턴스든 type cast operator `as` 를 사용해서 NSString과 브릿지 관계를 형성할 수 있다.  
Objective-C에서 기원한 String 인스턴스는 NSString을 스토리지와 같이 사용할 수 있다.    
그 이유는 NSString 인스턴스의 임의의 서브클래스는 String의 인스턴스가 될 수 있기 때문이다.

> 변경할 수 없기 때문에 저장소가 복사본에 의해 공유된 것과 같다. 변경 작업 시퀀스의 첫 번쨰 작업은 요소를 공유하고 연속적인 저장소에 복사하도록 하며, 여기에 `O(n)`의 시간과 공간이 소요된다.
* 여기서 n은 문자열의 인코딩된 표현의 길이

=> Foundation을 import하면 캐스팅 없이 String에서 NSString 메서드를 접근할 수 있다.

### 1. Multiline String Literals
- `따옴표(""")`를 통해 표현
- 줄바꿈 또한 문자열의 값으로 표현되나, 줄바꿈이 문자열 값의 일부가 되는 것을 원치 않을 경우에는 줄 바꿈을 원하는 라인 끝에 `백슬래시(\)` 입력
- 들여쓰기의 경우에는 공백의 문자열로 계산하지 않는다.
```
let quotation = """
고양이는 야옹야옹
강아지는 멍멍
호랑이는 어흥
"""
```

### Extended String Delimiters
- 문자를 `#`으로 둘러쌀 경우 특수문자를 출력할 수 있다.
```
let exString1 = "Line1 \n Line2"
print(exString1)
//출력 결과: 
Line1
Line2

let exString2 = #"Line1 \n Line2"#
print(exString2)
//출력 결과: Line1 \n Line2
```

### Initializing an Empty String
방법 1) 빈 문자열 리터럴을 변수에 할당: `var emptyString = ""`
방법 2) 초기화: `var emptyString = String()`
=> emptyString.isEmpty == true

### ⭐️String Mutability 문자열 변경 가능성
특정 String은 변수`var` 또는 상수`let`에 할당되어 변경될 수 있는지 여부를 알 수 있다
- var: 값 할당 이후 변경 가능. 가장 최근에 할당한 값을 담는다.
- let: 값 할당 이후 변경 불가능.

### ⭐️String Are Value Types 문자열은 값 타입!
Swift의 String 타입은 값 타입 (value type)이다.
새로운 String 값을 생성한다면 String 값은 함수 또는 메서드에 전달될 때나 상수 또는 변수에 대입될 때 복사 됩니다. 
각 경우에 존재하는 String 값의 새로운 복사본이 생성되고 원본이 아닌 새로운 복사본은 전달되거나 할당됩니다.
