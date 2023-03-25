//
//  main.swift
//  BOJ_1330
//
//  Created by 이동현 on 2023/03/25.
//

import Foundation

var nums = readLine()!.split(separator: " ").map{Int($0)!}
var a = nums[0]
var b = nums[1]

if a > b{
    print(">")
}
else if a == b{
    print("==")
}
else{
    print("<")
}

