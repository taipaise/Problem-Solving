import Foundation

// dp[i] := i 만큼의 무게를 배달하기 위한 설탕봉지 갯수
let MAX = 5001
let target = Int(readLine()!)!
var dp = Array(repeating: MAX, count: MAX)
dp[0] = 0
dp[3] = 1
dp[5] = 1

func solution() {
    guard target > 5 else {
        dp[target] < MAX ? print(dp[target]) : print(-1)
        return
    }

    for i in 6...target {
        if dp[i - 3] < MAX {
            dp[i] = min(dp[i - 3] + 1, dp[i])
        }

        if dp[i - 5] < MAX {
            dp[i] = min(dp[i - 5] + 1, dp[i])
        }
    }

    dp[target] < MAX ? print(dp[target]) : print(-1)
}

solution()