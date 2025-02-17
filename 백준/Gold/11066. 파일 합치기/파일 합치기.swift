import Foundation

let tcCount = Int(readLine()!)!
var n: Int = 0
var values: [Int] = []
var prefixSum: [Int] = []
var dp: [[Int]] = []


func input() {
    n = Int(readLine()!)!
    values.removeAll()
    values = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }

    dp = Array(
        repeating: Array(repeating: 1000000000, count: n),
        count: n)
}

func makePrefixSum() {
    prefixSum = Array(repeating: 0, count: n + 1)
    prefixSum[1] = values[0]

    for i in 1...n {
        prefixSum[i] = prefixSum[i - 1] + values[i - 1]
    }
}

func solve() {
    // dp[i][j] := i번째에서 j번째 파일까지 골랐을 때 최소 비용

    for i in 0..<n {
        dp[i][i] = 0
    }


    for length in 2...n {
        for start in 0...(n - length) {
            let end = start + length - 1

            for mid in start..<end {
                dp[start][end] = min(
                    dp[start][end],
                    dp[start][mid] + dp[mid + 1][end] + prefixSum[end + 1] - prefixSum[start]) // prefixSum에는 0 패딩 있음 주의
            }
        }
    }


    print(dp[0][n - 1])
}

for _ in 0..<tcCount {
    input()
    makePrefixSum()
    solve()
}
