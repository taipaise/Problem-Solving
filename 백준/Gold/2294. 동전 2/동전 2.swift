import Foundation

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers[0]
let target = numbers[1]
let INF = 1000000
var coins = Set<Int>()
var dp: [Int] = Array(repeating: INF, count: target + 1) // 0 패딩 추가

for _ in 0..<n {
    coins.insert(Int(readLine()!)!)
}
let filteredCoins = coins.filter { $0 <= target }

dp[0] = 0
for coin in filteredCoins {
    dp[coin] = 1
}

// dp[i] := i원을 만들기 위해 필요한 최소 동전 수
// 동전 종류를 하나씩 추가하면서 확인한다. 최대 100 * 10000번 확인
for coin in filteredCoins {
    for i in 1...target {
        guard i - coin >= 0 else { continue }

        dp[i] = min(dp[i], dp[i - coin] + 1)
    }
}

if dp[target] == INF {
    print(-1)
} else {
    print(dp[target])
}

