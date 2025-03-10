import Foundation

let colorCount = Int(readLine()!)!
let targetCount = Int(readLine()!)!

// dp[i][j] := i가지 색이 있을 때 j가지 색을 고를 수 있는 가짓수
var dp: [[Int64]] = Array(
    repeating: Array(repeating: 0, count: targetCount + 1),
    count: colorCount + 1)
let modulo: Int64 = 1000000003


for i in 0...colorCount {
    dp[i][0] = 1
    dp[i][1] = Int64(i)
}

// 색상환을 잘라서 선으로 늘여뜨려 생각한다.
for i in 2...colorCount {
    let selectCount = min(i, targetCount)
    guard selectCount >= 2 else { continue }

    for j in 2...selectCount { // 현재 색을 선택하거나, 선택하지 않거나의 합
        dp[i][j] = (dp[i - 2][j - 1] + dp[i - 1][j]) % modulo
    }
}

// 자른 색상환을 다시 원으로 만든다.
// 마지막 색과 첫번째 색이 인접한 색이 된다.
// 마지막 색을 선택한 경우 + 마지막 색을 선택하지 않은 경우를 더한다.
// 마지막 색을 선택한 경우, 마지막 색과 인접한 두 색을 뺀 나머지 색 중에 targetCount - 1 만큼 고른다.
print((dp[colorCount - 3][targetCount - 1] + dp[colorCount - 1][targetCount]) % modulo)