import Foundation

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let target = numbers[1]

let trees = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

func check(_ height: Int) -> Bool {
    let result = trees.reduce(0) { $0 + max(($1 - height), 0)}

    return result >= target
}

var lo = -1
var hi = trees.max()! + 1

while lo + 1 < hi {
    let mid = (lo + hi) >> 1

    if check(mid) {
        lo = mid
    } else {
        hi = mid
    }
}

print(lo)
