# Protocol example



### delegation pattern

* delegate : 위임하다
*  어떤 객체에서 일어나는 이벤트에 관한 혹은 어떤 객체에 뿌려줄 **데이터에 관한 코드를 다른 객체에서 작성해주는 것**
*  A객체의 일을 B객체에서 대신해주는 일을 위임하는 행위

> protocol : 해야할 일의 목록
>
> sender(A) : 일을 시키는 객체
>
> receiver(B) : 일을 하는 객체



### ios에서 객체간 대화를 하는 방법

1. NotificationCenter
2. KVO(Key-Value Observing)
3. Completion handlers/Callbacks (using closures)
4. Target-Action



### delegation 적용

1. 요구사항을 파악한다.

   - 각각의 Delegate들은 Delegate Protocol에 의해 나열된 그들의 규칙이 있다.

   - 함수 시그니쳐들의 집합으로 해당 protocol을 따르게 된다면 반드시 구현해야하는 함수들

      ```
      protocol SomeDelegate {
          func someTask()
      }
      ```

2. Delegation을 따른다/채택한다.

   - 클래스 뒤에 `: SomeDelegate`를 작성함으로써 해당 클래스가 `SomeDelegate` protocol을 따른다는 것을 표현

3. Delegate 객체(일을 시키는 객체)와 연결을 한다.

   - protocol을 따르는 객체는 일의 목록을 수행해야하는데 ( 함수를 구현 ), 그 전에 이 일이 어떤 객체로부터 주어졌는지를 명시해야함

4. 요구사항들 구현하기

   - 우리의 비유법으로 표현하자면 요구한 일을 수행하기, 즉 protocol의 함수들을 구현하기 단계