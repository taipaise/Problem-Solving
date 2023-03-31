//
//  main.swift
//  BOJ_2439
//
//  Created by 이동현 on 2023/03/31.
//

import Foundation

var cnt = Int(readLine()!)!

for i in 1...cnt{
    for _ in 0..<(cnt - i){
        print(" ", terminator: "")
    }
    for _ in 1...i{
        print("*",terminator: "")
    }
    print("")
}

