import Foundation

// 자식 노드가 많은 노드에게 먼저 전화를 걸어야 함
// n번 노드에서 걸리는 시간: 자신의 직접 자식이 소식을 모두 전파하는데 걸리는 시간들 중 최댓값임
// 재귀적으로 풀이

let n = Int(readLine()!)! // 전체 사원 수

// 자식들의 index를 기록
var tree: [[Int]] = Array(repeating: [], count: n)
// dp[i] := 0번부터 i 번까지 정보가 전달되는데 걸리는 시간
// dp[
var dp: [Int] = Array(repeating: Int.max, count: n)
let info = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

for (index, num) in info.enumerated() {
    if index == 0 { continue }

    tree[num].append(index)
}

func solve(_ index: Int) -> Int {
    // 리프 노드라면
    if tree[index].isEmpty {
        return 1
    }

    var times: [Int] = []

    // index로부터 자식까지 전파하는데 걸리는 시간들을 구함
    for child in tree[index] {
        // 자식들이 자식들에게 전달하는 시간
        let childTime = solve(child)
        times.append(childTime)
    }

    times = times.sorted { $0 > $1 }

    for (index, time) in times.enumerated() {
        times[index] = time + index
    }

    return times.max()! + 1
}

print(solve(0) - 1)
