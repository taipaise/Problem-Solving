import Foundation

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers[0]
let target = numbers[1]

let nums = readLine()!.split(separator: " ").map { Int(String($0))! }
var shortestLen = Int.max
var rangeSum = 0
var lo = 0
var hi = 0

while true {
    if rangeSum >= target {
        shortestLen = min(shortestLen, hi - lo)
        rangeSum -= nums[lo]
        lo += 1
    } else if hi < n {
        rangeSum += nums[hi]
        hi += 1
    } else {
        break
    }
}

if shortestLen == Int.max {
    print(0)
} else {
    print(shortestLen)
}

