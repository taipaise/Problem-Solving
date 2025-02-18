import Foundation

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

let n = numbers[0]
let requiredMemory = numbers[1]

let memories = [0] + readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

let costs = [0] + readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

let maxCost = 10001

// dp[i][j] := i번째 앱까지 선택했을 때, j 비용으로 확보할 수 있는 메모리
var dp = Array(
    repeating: Array(repeating: 0, count: maxCost + 1),
    count: n + 1)

for i in 1...n {
    for j in 0...maxCost {
        let appCost = costs[i]

        if appCost > j {
            dp[i][j] = dp[i - 1][j]
        } else {
            dp[i][j] = max(
                dp[i - 1][j], // 해당 앱을 끄지 않는 경우
                dp[i - 1][j - appCost] + memories[i])// 해당 앱을 끄는 경우
        }
    }
}

for i in 0...maxCost {
    if dp[n][i] >= requiredMemory {
        print(i)
        break
    }
}
