import Foundation

let n = Int(readLine()!)!
var scv = readLine()!.split(separator: " ").map { Int(String($0))! }
scv += [0, 0]
scv = Array(scv[0...2])

// dp[i][j][k] := i체력, j체력, k체력의 scv를 모두 죽이는데 필요한 최소 공격 수
var dp: [[[Int]]] = Array(
    repeating: Array(
        repeating: Array(repeating: 100, count: 61),
        count: 61),
    count: 61)

var diffs: [[Int]] = [
    [9, 3, 1],
    [9, 1, 3],
    [3, 9, 1],
    [3, 1, 9],
    [1, 9, 3],
    [1, 3, 9]]

dp[0][0][0] = 1

for i in 0...scv[0] {
    for j in 0...scv[1] {
        for k in 0...scv[2] {
            if i == j, j == k, k == 0 { continue }

            for diff in diffs {
                let newI = max(0, i - diff[0])
                let newJ = max(0, j - diff[1])
                let newK = max(0, k - diff[2])

                dp[i][j][k] = min(dp[i][j][k], dp[newI][newJ][newK] + 1)
            }
        }
    }
}

print(dp[scv[0]][scv[1]][scv[2]] - 1)
