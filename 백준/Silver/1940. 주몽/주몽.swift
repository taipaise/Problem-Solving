import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var nums: [Int: Bool] = [:]
var res = 0

let inputs = readLine()!
    .components(separatedBy: " ")
    .map { Int($0)! }
    .sorted()

var lo = 0
var hi = inputs.count - 1

while lo < hi {
    let cur = inputs[lo] + inputs[hi]

    if cur > m {
        hi -= 1
    } else if cur < m {
        lo += 1
    } else {
        res += 1
        lo += 1
    }
}

print(res)
