import Foundation

struct Number: Comparable {
    let index: Int
    let value: Int

    init(_ i: Int, _ v: Int) {
        index = i
        value = v
    }

    static func<(lhs: Number, rhs: Number) -> Bool {
        return lhs.value != rhs.value ? lhs.value < rhs.value : lhs.index < rhs.index
    }
}

let n = Int(readLine()!)!
var arr: [Number] = Array(repeating: Number(0, 0), count: n)
var answer = 0

for i in 0..<n {
    let num = Int(readLine()!)!
    arr[i] = Number(i, num)
}
arr.sort()

for i in 0..<n {
    answer = max((arr[i].index - i), answer)
}

print(answer + 1)
