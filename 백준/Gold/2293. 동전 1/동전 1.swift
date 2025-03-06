import Foundation

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let k = numbers[1]
var coins: [Int] = []
var dp: [Int64] = Array(repeating: 0, count: k + 1)
dp[0] = 1

for _ in 0..<n {
    let coin = Int(readLine()!)!
    guard coin <= k else { continue }
    coins.append(coin)
}

for coin in coins.sorted() {
    for value in coin..<k + 1 {
        dp[value] += dp[value - coin]
        if dp[value] > Int32.max { dp[value] = 0 }
    }
}

print(dp[k])

