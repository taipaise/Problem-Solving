import Foundation

let word1 = readLine()!.map { String($0) }
let word2 = readLine()!.map { String($0) }
let word3 = readLine()!.map { String($0) }

var dp = Array(
    repeating: Array(
        repeating: Array(repeating: 0, count: word3.count + 1),
        count: word2.count + 1),
    count: word1.count + 1)

for i in 1...word1.count {
    for j in 1...word2.count {
        for k in 1...word3.count {
            // 세 문자가 모두 같은 경우
            if
                word1[i - 1] == word2[j - 1],
                word2[j - 1] == word3[k - 1]
            {
                dp[i][j][k] = dp[i - 1][j - 1][k - 1] + 1
            } else {
                dp[i][j][k] = max(
                    dp[i - 1][j][k],
                    dp[i][j - 1][k],
                    dp[i][j][k - 1])
            }
        }
    }
}

print(dp[word1.count][word2.count][word3.count])
