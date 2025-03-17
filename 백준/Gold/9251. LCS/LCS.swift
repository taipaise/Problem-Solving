import Foundation

let word1 = readLine()!.map { String($0) }
let word2 = readLine()!.map { String($0) }


var dp = Array(repeating: Array(repeating: 0, count: word2.count + 1), count: word1.count + 1)

for i in 1...word1.count {
    for j in 1...word2.count {
        if word1[i - 1] == word2[j - 1] {
            dp[i][j] = dp[i - 1][j - 1] + 1
        } else {
            dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
        }
    }
}

print(dp[word1.count][word2.count])

