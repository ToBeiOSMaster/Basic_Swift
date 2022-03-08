## RxSwift
> 함수형 프로그래밍에 대한 예시가 애매한 부분이 있어서,  
저는 함수형 프로그래밍을 더 용이하게 하는 라이브러리 RxSwift에 대한 내용을 가볍게 적어보려 해요! (요즘 공부하는 친구이기도 하고,,)  

#### RxSwift 등장 배경
우선, Rx란 Reactive Extension을 사용한 라이브러리이다.

만약 단순하게 비동기 코드를 작성하고자 할 때, 크게 2가지 문제가 발생한다
1) 각 동작들의 순서를 결정하기 어렵다
2) 공유자원에 대한 처리방법이 필요하다

-> Rx는 이러한 문제를 보다 간결한 코드로 해결할 수 있도록 도와준다.

#### RxSwift의 장점
**그렇다면, 이러한 RxSwift를 사용해야 하는 이유? 필요한 이유는 무엇일까?**
> 얼마전에도 막상 물어보면 버벅거려서 한번 다시 정리해보고자 합니다

### 1) Funtional Reactive Programming - Rx는 함수형으로 개발할 수 있도록 도와준다.
- RxSwift 없이도 함수형 프로그래밍은 가능하지만, Rx에서 비동기 처리에 제공되는 함수들이 `filter`, `map` 등의 함수들과 같이 사용하기 쉽도록 설계되어 있기 때문에, 보다 함수형으로 개발하는데 용이하며, 함수형 프로그래밍의 장점을 그대로 가져올 수 있다.
- 함수형 프로그래밍을 작성하면 
1) 함수 내에서 외부 값을 참조하는 빈도가 줄고, 
2) 이로 인해 보다 많은 값들을 Immutable하게 사용할 수 있기 때문에 
3) side-effect가 훨씬 줄어들고 이에 따라 보다 **안정적으로 프로그래밍** 할 수 있게 된다

**멀티스레드 상황에 유리**
- <비함수형 프로그래밍>에서는 하나의 공유자원에 여러 스레드가 접근하는 경우 race-Condition이 발생하기 때문에 **Lock을 걸어주는 등의 방법** 으로 해결  
-> **오버헤드가 크고, 프로그램이 느려진다**
- <함수형 프로그래밍>에서는 Immutable한 데이터 자체를 **복사**해서 Input값으로 활용하여, output으로 배출하여 update하는 방식이기 때문에 
-> **여러 스레드에서 공유자원에 접근한다고 해도 오버헤드가 작으며, 소스도 훨씬 간결해진다.**  

<hr/>

**함수형 프로그래밍을 용이하게 만드는 장점 이외에도 더 알아보자**
### 2) MVVM 디자인 패턴과 궁합이 좋다
**MVVM이란?**
- 응용 프로그램의 구성요소를 Model, View, ViewModel로 구분하는 소프트웨어 디자인 패턴
- ViewModel은 View와 Model 사이에 위치하여 둘을 연결: View의 변화에 따라 Model을 업데이트하고, Model에서 update된 값을 다시 View에 표시하는 역할
- 데이터를 View로 바인딩하는 방법은 여러 가지가 존재하는데, 일례로 Swift에서 자체적으로 Observer를 지원
- **하지만 단순히 데이터의 변경상황 뿐만 아니라, 네트워크 요청과 같은 비동기 작업, 혹은 이벤트/알림 같은 작업도 함께 처리해야 하는 경우가 많기 때문에 이 때 RxSwift를 가장 많이 사용**  


<hr/>  

### 3) 실시간화 지원
reactive programming에서는 연산의 값이 바뀔 때마다 바로 재연산되어 갱신된다  
즉, Reactive Programming의 핵심은 DataBinding을 통해 Model과 View, Input과 Output이 업데이트 상황을 실시간으로 공유하며 업데이트하는 프로그래밍 방식


<hr/>

### 4) 다수의 비동기 이벤트를 처리하는데 용이(⭐️)
-> Rx를 사용하는 주된 이유는 **다수의 비동기 이벤트를 처리하는데 용이** 하기 때문이다

Reactive Programming은 기본적으로 비동기를 포함한 모든 Event들을 Stream으로 본다
(여기서 스트림이란, 시간 순서로 전달되어지는 값들의 Collection)

- <명령형 프로그래밍>으로 다수의 비동기 이벤트들을 처리하려면, 여러 콜백을 중첩시키거나 (콜백지옥), 플래그 변수나 if문을 여러 번 사용해야 한다
- RxSwift를 통한 <Reactive Programming>의 경우, 콜백중첩으로 표현하는 구문보다 훨씬 간결하게 같은 내용을 표현할 수 있다. 또한 위와 같은 플래그 변수나 if문 사용했을 때 발생할 수 있는 실수를 줄여준다

  
```
func downloadJson(_ url: String, _ completion: @escaping (String?) -> Void) {
  DispatchQueue.global().async { 
    let url = URL(string: url)! 
    let data = try! Data(contentsOf: url) 
    let json = String(data: data, encoding: .utf8) 
      
    DispatchQueue.main.async { completion(json) } 
  } 
}
```

```
_ = downloadJson(MEMBER_LIST_URL) .subscribe { event in // 클로저 범위는 여기부터 
  switch event { 
    case .next(let json): 
          self.editView.text = json self.setVisibleWithAnimation(self.activityIndicator, false) 
    case .completed: 
          break 
    case .error: 
           break 
  } 
}
```

+) RxSwift 개념 정리 내용: https://github.com/Choyoonyoung98/MasteringRxSwift_Study
+) 공부했던 RxSwift 예제: https://github.com/Choyoonyoung98/RxSwift_Ex
