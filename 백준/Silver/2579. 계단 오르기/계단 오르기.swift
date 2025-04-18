import Foundation

// 마지막 계단은 반드시 밟아야 함
// 하나, 또는 두 계단 씩 오를 수 있다.
// 단, 연속된 세 개의 계단을 밟을 수는 없다.
// 이전 계단에서 오는 경우
//   이전 계단에서는 반드시 2계단 전에서 왔어야 함
// 2계단 전에서 오는 경우
//   이전 계단에서 2계단 전, 이전 계단에서 1계단 전 모두 가능
// dp[i][j]  := j번 연속해서 계단을 밟아 i번째 계단에 다다랐을 때 얻을 수 있는 최고 점수
// dp[i][0] = max(dp[i - 2][0], dp[i - 2][1]) + i번째 계단 점수 -> j가 0이므로 이전 계단 밟을 수 없음
// dp[i][1] = dp[i - 1][0] + i번째 계단 점수

let n = Int(readLine()!)!
var scores = Array(repeating: 0, count : 301)
var dp = Array(repeating: Array(repeating: 0, count: 2), count: 301)
for i in 1...n {
    scores[i] = Int(readLine()!)!
}

dp[1][0] = scores[1]
dp[2][0] = scores[2]
dp[2][1] = scores[1] + scores[2]

func solution() {
    guard n > 2 else {
        print(max(dp[n][0], dp[n][1]))
        return
    }

    for i in 3...n {
        dp[i][0] = max(dp[i - 2][0], dp[i - 2][1]) + scores[i]
        dp[i][1] = dp[i - 1][0] + scores[i]
    }

    print(max(dp[n][0], dp[n][1]))
}

solution()
