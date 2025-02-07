import Foundation

let word1 = readLine()!.map { String($0) }
let word2 = readLine()!.map { String($0) }

var dp = Array(
    repeating: Array(repeating: 0, count: word2.count + 1),
    count: word1.count + 1)

for i in 1...word1.count {
    for j in 1...word2.count {
        if word1[i - 1] == word2[j - 1] {
            dp[i][j] = dp[i - 1][j - 1] + 1
        } else {
            dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
        }
    }
}

func findLCS(_ startLen: Int) -> String {
    var curLen = startLen
    var result: [String] = []

    var i = word1.count
    var j = word2.count

    while i > 0, j > 0 {
        let tempI = max(0, i - 1)
        let tempJ = max(0, j - 1)

        if dp[tempI][j] == curLen {
            i = tempI
        } else if dp[i][tempJ] == curLen {
            j = tempJ
        } else {
            result.append(word1[i - 1])
            curLen -= 1
            i = tempI
            j = tempJ
        }
    }

    return result.reversed().joined(separator: "")
}


let len = dp[word1.count][word2.count]

print(len)

if len > 0 {
    print(findLCS(len))
}
