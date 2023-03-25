//
//  main.swift
//  BOJ_11650
//
//  Created by 이동현 on 2023/03/25.
//

import Foundation

var cnt = Int(readLine()!)!
var pos : [[Int]] = []

for _ in 0..<cnt{
    let temp = readLine()!.components(separatedBy: " ").map({(target : String) -> Int in return Int(target)!})
    pos.append(temp)
}

pos.sort(by: {($0[0], $0[1]) < ($1[0], $1[1])})

for i in 0..<pos.count{
    print(pos[i][0], pos[i][1])
}
