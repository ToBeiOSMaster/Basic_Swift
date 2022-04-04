## Generics
> 내일까지 보충해서 다시 업로드하겠습니다..!!!

Generic은 swift의 강력한 특징 중 하나이고, Swift 표준 라이브러리 대부분은 제너릭 코드로 되어 있다.  
ex) `Array`, `Dictionary`

Generic Code는  
- 정의한 요구사항에 따라 모든 타입에서 동작할 수 있는 유연하고 재사용 가능한 함수와 타입을 작성할 수 있다
- 중복을 피하고 명확하고 추상적인 방식으로 의도를 표현하는 코드를 작성할 수 있다

아래 3개의 함수는 a와 b의 타입이 모두 같아야 하는데,  
Swift는 타입 안정성 언어이고 String 타입의 변수와 Double 타입의 변수가 서로 값을 바꾸도록 허락하지 않기 때문이다.  
이러한 시도는 컴파일 에러가 발생한다.   
  
```
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//=> Generic verison
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
```
