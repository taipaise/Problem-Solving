import Foundation

// 이분 탐색

// 입력값 세팅
var inputs = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m, endPos) = (inputs[0], inputs[1], inputs[2])
var rests: [Int] = [0]
if n > 0 {
    rests += readLine()!.split(separator: " ").map { Int($0)! }
}
rests.append(endPos)
rests.sort()


func check(_ dist: Int) -> Bool {
    var count = 0

    // 각 휴게소 사이 사이에 몇 개의 휴게소를 세워야 하는지 판단
    for i in 0..<rests.count - 1 {
        let diff = rests[i + 1] - rests[i]

        guard diff > dist else { continue }

        let needs = (diff - 1) / dist
        count += needs
    }

    return count <= m
}

func binarySearch() -> Int {
    var lo = 0
    var hi = endPos

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if check(mid) { // 해당 최소 거리를 만족할 수 있다면 더 촘촘하게
            hi = mid
        } else {
            lo = mid
        }
    }
    return hi
}

print(binarySearch())
