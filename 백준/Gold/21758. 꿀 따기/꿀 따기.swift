import Foundation

// 벌을 위치 시킬 두 군데를 모두 확인해야한다
// 얻을 수 있는 꿀을 구간합으로 구할 수 있도록 한다.
// i구간 < ~~ <= j구간 합 = sumArray[j] - sumArray[i]

let n = Int(readLine()!)!
var honey: [Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
var sumArray: [Int] = Array(repeating: 0, count: n)
var homePosition = 0
var bee1Position = 0
var bee2Position = 0
var res = 0

var sum = 0
for i in 0..<n {
    sum += honey[i]
    sumArray[i] = sum
}

func solution() {
    // 집이 한쪽 끝에 있는 경우
    // 벌 한 마리는 반대쪽 끝에 있어야 함
    // 다른 벌 한마리는 남은 위치 중 한개

    // 집이 왼쪽 끝에 있는 경우
    homePosition = 0
    bee1Position = n - 1
    for i in 1..<n - 1 {
        bee2Position = i
        let honey1 = calculate(bee1Position, bee2Position)
        let honey2 = calculate(bee2Position, bee1Position)
        res = max(res, honey1 + honey2)
    }

    // 집이 오른쪽 끝에 있는 경우
    homePosition = n - 1
    bee1Position = 0
    for i in 1..<n - 1 {
        bee2Position = i
        let honey1 = calculate(bee1Position, bee2Position)
        let honey2 = calculate(bee2Position, bee1Position)
        res = max(res, honey1 + honey2)
    }

    // 집이 중간에 있는 경우
    // 벌이 양쪽 끝에 하나씩 있어야 함. 집의 위치를 1~n-2위치까지 확인 -> 집에 있는 꿀 채취 가능 굳이 확인할 필요 x
    bee1Position = 0
    bee2Position = n - 1
    homePosition = 1
    let honey1 = calculate(bee1Position, bee2Position)
    let honey2 = calculate(bee2Position, bee1Position)
    res = max(res, honey1 + honey2)


    print(res)
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
