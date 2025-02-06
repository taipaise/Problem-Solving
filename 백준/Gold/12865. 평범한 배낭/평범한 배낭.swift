import Foundation

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let m = numbers[1]

var weights = Array(repeating: 0, count: n + 1)
var values = Array(repeating: 0, count: n + 1)
var dp = Array(
    repeating: Array(repeating: 0, count: m + 1),
    count: n + 1)

for i in 0..<n {
    let input = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    let weight = input[0]
    let value = input[1]

    weights[i + 1] = weight
    values[i + 1] = value
}

for i in 1...n {
    for bagWeight in 1...m {
        let weight = weights[i]
        let value = values[i]

        // 물건보다 가방이 작으면 담을 수 없음
        guard weight <= bagWeight else {
            dp[i][bagWeight] = dp[i - 1][bagWeight]
            continue
        }

        // 물건을 챙겼을 때, 안 챙겼을 때
        dp[i][bagWeight] = max(
            dp[i - 1][bagWeight],
            dp[i - 1][bagWeight - weight] + value)
    }
}

print(dp[n][m ])
