import Foundation

//0 1 1 2 3
let count = Int(readLine()!)!
var zero: [Int] = Array(repeating: 0, count: 41)
var one: [Int] = Array(repeating: 0, count: 41)

zero[0] = 1
zero[2] = 1
one[1] = 1
one[2] = 1

for i in 3...40 {
    zero[i] = zero[i - 2] + zero[i - 1]
    one[i] = one[i - 2] + one[i - 1]
}

for _ in 0..<count {
    let n = Int(readLine()!)!
    print(zero[n], one[n])
}