import Foundation

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let houseCount = numbers[0]
let wifiCount = numbers[1]
var houses: [Int] = []
for _ in 0..<houseCount {
    houses.append(Int(readLine()!)!)
}
houses.sort()

// 최소 거리를 mid로 했을 때 공유기를 wifiCount개 이상 설치 가능한가?
func check(_ mid: Int) -> Bool {
    var prePos = houses[0]
    var count = 1

    for i in 1..<houses.count {
        if houses[i] - prePos >= mid {
            prePos = houses[i]
            count += 1
        }

        if count >= wifiCount {
            return true
        }
    }

    return false
}

func solution() {
    var lo = 0
    var hi = houses.last! - houses.first! + 1

    while lo + 1 < hi {
        let mid = (lo + hi) / 2

        if check(mid) {
            lo = mid
        } else {
            hi = mid
        }
    }

    print(lo)
}

solution()
