//
//  POP_yeoni.swift
//  
//
//  Created by 조연희 on 2022/03/20.
//

import Foundation

protocol Bird {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var airspeedVelocity : Double { get }
}


// 클래스의 다중 상속과 유사한 기능을 스위프트에서는 프로토콜의 다중 채택으로 제공
// FlappyBird 구조체는 Bird와 Flyable 프로토콜을 준수
struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    let canFly = true
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Pengiun: Bird {
    let name: String
    let canFly = false
}

struct SwiftbBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    var version: Double
    let canFly = true
    
    var airspeedVelocity: Double { return version*1000.0 }
}


// extesion
// 만일 Bird 프로토콜을 준수하는 객체가 Flyable 프로토콜도 준수한다면 canFly가 true 값을 반환하게끔 하는 코드
extension Bird {
    var canFly: Bool { return self as Flyable }
}


class UnknownBird: Bird, Flyable {
    var name:String=""
    var airspeedVelocity = 0.0
}

extension UnknownBird {
    var canFly: Bool {
        if self.airspeedVelocity > 0{
            return true
        }
        return false
    }
}

var unknown = UnknownBird()

print(unknown.canFly) // false
unknown.name = "NailerBird"
unknown.airspeedVelocity = 11.11
// 새가 날 수 있다는 것이 판명난 뒤
print(unknown.canFly)  // true
