//
//  main.swift
//  BOJ_10813
//
//  Created by 이동현 on 2023/03/24.
//

import Foundation

func sToI() -> [Int]{
    readLine()!.components(separatedBy: " ").map({(target : String) -> Int in return Int(target)!})
}
//input[0] == n
//input[1] == m
var nm = sToI()

var balls = [Int](1...nm[0])

for _ in 0..<nm[1]{
    let change = sToI()
    var temp : Int
    temp = balls[change[0] - 1]
    balls[change[0] - 1] = balls[change[1] - 1]
    balls[change[1] - 1] = temp
}

for i in 0..<nm[0]{
    print(balls[i], separator: " ")
}
        
