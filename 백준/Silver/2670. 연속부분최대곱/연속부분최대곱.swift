import Foundation

let n = Int(readLine()!)!
var dp: [Double] = []

for _ in 0..<n {
    let number = Double(readLine()!)!
    dp.append(number)
}

for i in 1..<n {
    dp[i] = max(dp[i], dp[i - 1] * dp[i])
}

let res = dp.max()!
print(String(format: "%.3f", (res * 1000).rounded() / 1000))
