# OOP(Object-Oriented Programming)

> OOP 관련 작성 내용이 중복될 가능성이 큰 것 같아서  
연희님께서 작성해주신 객체지향 개발의 5대 원칙, SOLID를 swift에 직접 적용해서 정리해보겠습니다

OOP는 
- 코드의 중복을 줄이고, 
- 입력코드/계산 코드/결과 출력 코드 등 코드의 역할 분담을 확실하게 함으로써   
=> 코드의 가독성을 높이는 것에 목표를 두고 있다.

그래서 이와 같은 OOP의 방법론을 구현하고 개발하기 위한 원칙으로 **객체지향 개발의 5대 원칙인 SOLID**가 등장하게 되었다.
- SRP(Single Responsibility Principle)
- OCP(Open Closed Principle)
- LSP(Liskov Substitution Principle)
- ISP(Interface Segregation Principle)
- DIP(Dependency Inversion Principle)

### 1) Single Responsibility Principle
말 그대로 각 클래스는 단일 책임을 가지기 때문에 클래스가 변경되는 이유는 단 하나  

```
protocol Openable {
    mutating func open()
}

protocol Closeable {
    mutating func close()
}

struct PodBayDoor: Openable, Closeable {

    private enum State {
        case open
        case closed
    }

    private var state: State = .closed

    mutating func open() {
        state = .open
    }

    mutating func close() {
        state = .closed
    }
}

//'문을 연다'라는 하나의 책임만을 가지고 있는 클래스
final class DoorOpener {
    private var door: Openable

    init(door: Openable) {
        self.door = door
    }

    func execute() {
        door.open()
    }
}

//'문을 닫는다'라는 하나의 책임만을 가지고 있는 클래스
final class DoorCloser {
    private var door: Closeable

    init(door: Closeable) {
        self.door = door
    }

    func execute() {
        door.close()
    }
}

let door = PodBayDoor()

let doorOpener = DoorOpener(door: door)
doorOpener.execute()

let doorCloser = DoorCloser(door: door)
doorCloser.execute()

```

### 2) Open Closed Principle
확장에는 열려있고, 변경에는 닫혀있다

```
protocol Shooting {
    func shoot() -> String
}

final class LaserBeam: Shooting {
    func shoot() -> String {
        return "빵!!!!!"
    }
}

final class WeaponsComposite {
    let weapons: [Shooting]

    init(weapons: [Shooting]) {
        self.weapons = weapons
    }

    func shoot() -> [String] {
        return weapons.map { $0.shoot() }
    }
}

let laser = LaserBeam()
var weapons = WeaponsComposite(weapons: [laser])
weapons.shoot()

// 로켓 런처를 무기로 추가하기 위해서는 기존의 클래스들을 변경할 필요 없이 확장이 가능하다
final class RocketLauncher: Shooting {
    func shoot() -> String {
        return "Whoosh!"
    }
}

let rocket = RocketLauncher()
weapons = WeaponsComposite(weapons: [laser, rocket])
weapons.shoot()
```

### 3) Liskov Substitution Principle
서브 클래스는 기존 클래스를 대체할 수 있다  

```
let requestKey: String = "NSURLRequestKey"

//NSError 파생클래스 - RequestError
class RequestError: NSError {
    var request: NSURLRequest? {
        return self.userInfo[requestKey] as? NSURLRequest
    }
}

//NSError를 RequestError로 대체한 예시
func fetchData(request: NSURLRequest) -> (data: NSData?, error: RequestError?) {
    let userInfo: [String:Any] = [requestKey : request]

    return (nil, RequestError(domain:"DOMAIN", code:0, userInfo: userInfo))
}


func willReturnObjectOrError() -> (object: AnyObject?, error: NSError?) {

    let request = NSURLRequest()
    let result = fetchData(request: request)

    return (result.data, result.error)
}

let result = willReturnObjectOrError()

let error: Int? = result.error?.code


if let requestError = result.error as? RequestError {
    requestError.request
}
```

### 4) Interface Segregation Principle
클라이언트별 세분화된 인터페이스
-> 예시는 

### 5) Dependency Inversion Principle

