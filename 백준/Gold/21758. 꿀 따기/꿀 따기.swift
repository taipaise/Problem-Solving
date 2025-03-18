import Foundation

// 벌을 위치 시킬 두 군데를 모두 확인해야한다
// 얻을 수 있는 꿀을 구간합으로 구할 수 있도록 한다.
// i구간 < ~~ <= j구간 합 = sumArray[j] - sumArray[i]

let n = Int(readLine()!)!
var honey: [Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
var sumArray: [Int] = Array(repeating: 0, count: n)
var homePosition = 0
var beePositions: [Int] = []
var res = 0

var sum = 0
for i in 0..<n {
    sum += honey[i]
    sumArray[i] = sum
}

func solution() {
    for i in 0..<n {
        homePosition = i
        select(index: 0)
    }
    print(res)
}


func select(index: Int) {
    if beePositions.count == 2 {
        let bee1 = calculate(beePositions[0], beePositions[1])
        let bee2 = calculate(beePositions[1], beePositions[0])

        res = max(res, bee1 + bee2)
        return
    }

    for i in index..<n {
        if i == homePosition { continue } // 집을 제외하고 벌을 배치

        beePositions.append(i)
        select(index: i + 1)
        beePositions.removeLast()
    }
}

func calculate(_ targetBeePosition: Int, _ otherBeePosition: Int) -> Int {
    var res = 0
    if targetBeePosition < homePosition {
        res = sumArray[homePosition] - sumArray[targetBeePosition]

        if
            targetBeePosition < otherBeePosition,
            otherBeePosition < homePosition
        { res -= honey[otherBeePosition] }
    } else {
        res = sumArray[targetBeePosition] - sumArray[homePosition]
        res -= honey[targetBeePosition]
        res += honey[homePosition]

        if
            homePosition < otherBeePosition,
            otherBeePosition < targetBeePosition
        { res -= honey[otherBeePosition] }
    }

    return res
}

solution()
