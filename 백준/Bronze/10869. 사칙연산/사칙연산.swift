//
//  main.swift
//  BOJ_10869
//
//  Created by 이동현 on 2023/03/25.
//

import Foundation

var nums = readLine()!.split(separator: " ").map{Int($0)!}
let a = nums[0]
let b = nums[1]

print(a + b)
print(a - b)
print(a * b)
print(a / b)
print(a % b)
