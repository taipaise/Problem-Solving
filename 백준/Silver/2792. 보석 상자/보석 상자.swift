import Foundation

// 질투심이 n이 되도록 할 수 있는지 이분 탐색으로 구한다.

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers.first!
let jewelCount = numbers.last!

var jewels: [Int] = Array(repeating: 0, count: jewelCount)

for i in 0..<jewelCount {
    let count = Int(readLine()!)!
    jewels[i] = count
}

func check(_ envy: Int) -> Bool {
    // 모든 보석을 최대 질투심만큼 나누어 줌
    var kidCount = 0
    for jewel in jewels {
        var curKid = jewel / envy
        if jewel % envy  > 0 {
            curKid += 1
        }
        kidCount += curKid
    }

    return kidCount <= n
}

var lo = 0
var hi = jewels.max()! + 1

while lo + 1 < hi {
    let mid = (lo + hi) >> 1

    // 가능하면 질투심을 줄이기
    if check(mid) {
        hi = mid
    } else {
        lo = mid
    }
}

print(hi)
