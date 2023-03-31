//
//  main.swift
//  BOJ_1546
//
//  Created by 이동현 on 2023/03/31.
//

import Foundation
var cnt = Double(readLine()!)!
var scores = readLine()!.components(separatedBy: " ").map({ (score : String) -> Double in return Double(score)!})
//var scores = readLine()!.components(separatedBy: " ").map{Double($0)!} 로 축약가능
var maxScore = scores.max()!
scores = scores.map({$0/maxScore*100})
var result = scores.reduce(0, {(res : Double, element : Double) -> Double in return res + element})

print(result/cnt)
