## Memory
> Memory Safety, Automatic Reference Counting, 그리고 마지막으로 메모리 누수 추적 방법에 대해 정리해보고자 합니다.

### Memory Safety
- Swift는 안전성을 가지고 있는 언어이다. 
  1) 예를 들어 Swift는 변수가 사용되기 전에 초기화되고 
  2) 메모리가 할당 해제된 후에는 접근되지 않으며 
  3) 배열 인덱스는 범위를 벗어난 에러가 있는지를 확인한다.
- (??) Swift는 메모리의 위치를 수정하는 코드가 해당 메모리에 대한 독점 접근 권한을 갖도록 요구함으로써 동일한 메모리 영역에 대해 다중 접근이 충돌나지 않도록 한다.
- Swift는 메모리를 자동으로 관리하기 때문에 대부분의 경우에 메모리 접근에 대해 생각할 필요가 없다. (그럼에도 불구하고 고려해야하는 상황 있음)

#### Understanding Conflicting Access to Memory
변수의 값을 설정하거나, 함수에 인자를 전달하는 것과 같은 동작을 하게 될 때, 메모리에 접근하게 된다.

ex)   
```
//write access to the memory
var one = 1

//read access from the memory
print("number \(one)")
```

메모리에 충돌하는 접근이란, 코드의 다른 부분이 같은 시간에 메모리의 같은 위치에 접근할 때 발생한다.  
같은 시간에 메모리 위치에 다중 접근은 예측할 수 없거나 일관성 없는 동작이 발생할 수 있다

(와 의자에 앉기만하면 졸리네)
