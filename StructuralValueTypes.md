## Structural Value Types

>  다른 프로그래밍 언어와 달리 Swift는 사용자 정의 구조체와 클래스에 대해 별도의 인터페이스와 구현 파일을 만들 필요가 없다.
 단일 파일로 구조체 또는 클래스를 정의하면 해당 클래스 또는 구조체에 대한 외부 인터페이스가 자동으로 다른 코드에서 사용할 수 있다.
> Swift에서의 구조체와 클래스는 다른 언어보다 기능성으로 유사하다

### Comparing Structures and Classes 구조체 VS 클래스

### 공통점
- 값을 저장하는 [프로퍼티](https://bbiguduk.gitbook.io/swift/language-guide-1/properties) 정의
- 기능 제공을 위한 [메서드](https://bbiguduk.gitbook.io/swift/language-guide-1/methods) 정의
- 서브 스크립트 구문을 사용하여 값에 접근을 제공하는 [서브 스크립트](https://bbiguduk.gitbook.io/swift/language-guide-1/subscripts) 정의
- 초기화 상태를 설정하기 위한 [초기화](https://bbiguduk.gitbook.io/swift/language-guide-1/initialization) 정의
- 기본 구현을 넘어 기능적 확장을 위한 [확장](https://bbiguduk.gitbook.io/swift/language-guide-1/extensions)
- 특정 종료의 표준 기능을 제공하는 [프로토콜](https://bbiguduk.gitbook.io/swift/language-guide-1/protocols) 준수

### 차이점
클래스는 추가적으로
- 상속을 통해 한 클래스가 다른 클래스의 특성을 [상속](https://bbiguduk.gitbook.io/swift/language-guide-1/inheritance) 할 수 있다
- [타입 캐스팅](https://bbiguduk.gitbook.io/swift/language-guide-1/type-casting)을 통해 런타임에 클래스 인스턴스의 타입을 확인하고 해석할 수 있다
- [초기화 해제](https://bbiguduk.gitbook.io/swift/language-guide-1/deinitialization) 구문을 통해 클래스의 인스턴스가 할당된 리소스를 해제할 수 있도록 한다
- [참조 카운팅](https://bbiguduk.gitbook.io/swift/language-guide-1/automatic-reference-counting)은 **하나 이상의 클래스 인스턴스 참조를 허락한다**  

> 클래스를 사용하게 되면 복잡성이 증가하기 때문에 실질적으로 정의하는 대부분의 사용자 정의 데이터 타입이 구조체와 열거형이다.

* 그렇다면 어떤 상황에서 구조체 또는 클래스를 선택해야 잘 선택했다고 소문이 날까?
- 기본적으로는 구조체 사용을 기본으로 하라
> 기본적인 데이터의 꼴을 표현하기 위한 목적에서 구조체를 사용해라
Swift의 구조체는 다른 언어에서 클래스의 기능으로만 한정지어진 많은 기능을 포함한다


- Objective-C와의 상호 운용성이 필요할 경우 클래스를 사용해라 (왜?)
- Use classes when you need to control the identity of the data you're modeling (직역하면 이해가 힘들 것 같아 그대로 작성)
- `implementations`로 하고자 하는 일(behavior)을 채택하기 위한 목적에서 구조체와 프로토콜을 사용하라

