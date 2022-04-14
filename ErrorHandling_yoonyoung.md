## Error Handling
Error Handling은 프로그램의 에러 조건에서 응답하고 복구하는 프로세스이다.

### Representing and Throwing Errors
Swift에서 에러는 **`Error` 프로토콜에 준수하는 타입의 값으로 표현** 된다.
Swift 열거형은 관련된 에러 조건의 그룹을 모델링하는데 특히 적합하며 관련값을 사용하여 에러의 특성에 대한 추가 정보를 전달할 수 있다

```
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

### Handling Errors
Swift에서는 에러를 처리하는 4가지 방법이 있다
1) 함수에서 해당 함수를 호출하는 코드로 에러를 전파
2) `do-catch`구문
3) 옵셔널 값으로 처리
4) 에러가 발생하지 않을 것이라는 주장

함수에서 에러가 발생하면 프로그램의 흐름이 변경되므로 **코드에서 에러가 발생할 수 있는 위치**를 신속하게 알 수 있어야 한다.
코드에서 이러한 위치를 식별하려면 에러가 발생할 수 있는 함수, 메서드, 또는 초기화 구문 호출하는 코드 이전에 `try`, `try?`, `try!` 키워드를 작성한다.    

### Propagating Erros Using Throwing Functions
에러가 발생할 수 있는 함수, 메서드, 또는 초기화 구문을 나타내기 위해 파라미터 뒤에 함수의 선언에 `throws` 키워드를 작성한다.
- throwing function은 Error를 전파만 할 수 있다
- throws 선언이 되어 있지 않은 함수 내에서 발생된 모든 에러는 함수 내에서 처리되어야 한다  
```
class VendingMachine {
  func vend(itemNamed name: String) throws {
    guard let item = inventory[name] else {
      throw VendingMachineError.invalidSelection
    }
  }
}

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName) //에러를 발생할 수 있는 메서드이기 때문에 try 키워드를 앞에 두어 호출
}
```

### Handling Errors Using Do-catch
처리할 수 있는 에러가 무엇인지를 나타내기 위해 `catch` 뒤에 패턴을 작성한다
```
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
```

### Converting Errors to Optional Values
에러를 옵셔널 값으로 변환하여 처리하기 위해 `try?`를 사용한다  
`try?` 표현식을 평가하는 동안 에러가 발생되면 이 표현식의 값은 `nil`이다.
```
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```

### Disabling Error Propagation
가끔 던지는 함수 또는 메서드가 실제로 런타임 에러를 발생하지 않는다는 사실을 알고 있다.
이러한 경우 표현식 전에 에러 전파를 비활성화하기 위해 `try!`를 작성할 수 있고 에러를 발생하지 않는다고 호출을 래핑할 수 있다.  
```
//이미지는 애플리케이션과 함께 제공되고 런타임에 에러가 발생하지 않는다는 것이 명백하므로
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

### Specifying Cleanup Actions
- `defer`: 코드 실행이 코드의 현재 블럭이 종료되기 직전에 해당 구문 실행.
- 이 구문을 사용하여 에러가 발생하여 종료되거나, `return`, `break`와 같은 구문에 의해 종료되는 방식에 **상관없이** 필요한 정리를 수행할 수 있다
- 현재 범위가 종료될 때까지 해당 구문의 실행을 연기한다.  
