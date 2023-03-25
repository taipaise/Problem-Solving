//
//  main.swift
//  BOJ_3052
//
//  Created by 이동현 on 2023/03/25.
//

import Foundation

var mod : [Int:Int] = [:]

for _ in 0..<10{
    var num = Int(readLine()!)!
    num %= 42
    if mod[num] == nil{
        mod[num] = 1
    }
    else{
        mod[num]! += 1
    }
}

print(mod.count)
