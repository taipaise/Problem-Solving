//
//  main.swift
//  BOJ_2884
//
//  Created by 이동현 on 2023/03/31.
//

import Foundation

var time = readLine()!.components(separatedBy: " ").map{Int($0)!}
var hour = time[0]
var min = time[1]

if min - 45 < 0{
    min = 60 - 45 + min
    hour -= 1
    if hour < 0{
        hour = 23
    }
}
else{
    min -= 45
}
print("\(hour) \(min)")

