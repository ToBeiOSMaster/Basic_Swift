import UIKit

var greeting = "Hello, playground"


var completionHandlers: [() -> Void] = [ ]
func withEscaping(completion: @escaping () -> Void) {
    //클로저를 구문(함수) 밖에서 탈출시켜 배열에 넣겠다는 의미로 escaping 사용
    //일반적으로 Swift에서는 파라미터로 전달된 클로저는 기본적으로 함수 내부 스코프 안에서만 사용이 가능
    completionHandlers.append(completion)
}

/*
 escaping closure의 대표적인 사용 예시 - completionHandlers
 : 네트워크 요청 작업을 비동기적으로 처리하고, 이 처리가 끝난 후 동작하는 것을 completionHandlers에게 명령하는 것
*/

//ex1)
func postCatSelection(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        let catSelectURL = "http://baseURL/home/cats"
    
        post(catSelectURL, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.postSuccess.rawValue : //201
                    //함수 내 결과를 받은 후, 결과 데이터를 담아 escaping closure 실행(결과값을 외부로 탈출)
                    completion(.networkSuccess(networkResult.resResult))
                    break
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    break
                case HttpResponseCode.maintainance.rawValue: //503
                    completion(.maintainance)
                    break
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
            }
        }
}

//ex2)
/*
 escaping closure를 사용하지 않았을 경우,
 함수가 리턴되기 전에 서버 작업이 완료되었는지 보장되지 않는다.
 -> 즉 Alamofire.request는 비동기적으로 실행시켜놓고, Alamofire 결과값 반환 여부와 상관없이 return result 실행
 -> 서버에서 이미지 받아오는 부분이 끝나지 않은 채 빈 이미지 return될 가능성 있음
 
 => 특정 함수가 종료될 때 특정 행동을 취하고 싶을 떄, 즉 비동기처리 사이 동기적인 실행 흐름을 필요로 할 때 사용하는 것으로 보인다
 */
func setImage(url: String) -> UIImage {
    var result = UIImage()
    
    Alamofire.request(url).responseImage { (response) in
        if let image = response.result.value {
            result = image
        }
    }
    return result
}

//-> 이렇게 바꾸는 게 맞을지,,
func setImage(url: String, completion: @escaping (UIImage) -> Void) {
    Alamofire.request(url).responseImage { (response) in
        if let image = response.result.value {
            completion(image)
        }
    }
}
/*
 => 그렇다면 escaping, non-escaping closure를 나눠서 사용하는 이유? 컴파일러의 퍼포먼스와 최적화
 * non-escaping closure: 컴파일러가 클로저의 실행이 언제 종료되는지 알기 때문에 때에 따라 클로저에서 사용하는 특정 객체에 대한 retain, release 등의 처리를 생략해 객체의 라이프사이클을 효율적으로 관리한다
 
 * escaping closure: 함수 밖에서 실행되기 때문에 클로저가 함수 밖에서도 적절히 실행되는 것을 보장하기 위해,
 클로저에서 사용하는 객체에 대한 추가적인 reference cycles 관리 등을 해줘야 한다
 */
