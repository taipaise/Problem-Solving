//
//  main.swift
//  BOJ_2563
//
//  Created by 이동현 on 2023/03/24.
//

import Foundation

var cnt = Int(readLine()!)!
var paper = Array(repeating: Array(repeating: 0, count: 100), count: 100)
var res = 0

for _ in 0..<cnt{
    var pos = readLine()!.components(separatedBy: " ").map({(target : String) -> Int in return Int(target)!})
    let xpos = pos[0]
    let ypos = pos[1]
    for y in ypos..<(ypos + 10){
        for x in xpos..<(xpos + 10){
            if paper[y][x] == 0{
                paper[y][x] = 1
                res += 1
            }
        }
    }
}
print(res)
