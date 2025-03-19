import Foundation

struct Meeting {
    let start: Int
    let end: Int
    let count: Int

    init(_ s: Int, _ e: Int, _ c: Int) {
        start = s
        end = e
        count = c
    }
}

let n = Int(readLine()!)!
var meetings: [Meeting] = []
var dp: [Int] = []

func input() {
    for _ in 0..<n {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        meetings.append(Meeting(line[0], line[1], line[2]))
    }

    meetings.sort(by: { $0.end < $1.end }) // 종료시간 기준 정렬
    dp = Array(repeating: 0, count: meetings.count + 1)
}

func findIndex(_ start: Int) -> Int {
    var lo = -1
    var hi = meetings.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if meetings[mid].end <= start {
            lo = mid
        } else {
            hi = mid
        }
    }

    return hi
}

func solution() {
    input()
    for i in 1...n {
        // 현재 회의를 선택 안하는 경우
        dp[i] = dp[i - 1]

        // 현재 회의 선택하는 경우
        // 현재 회의의 시작 전에 가장 나중에 끝나는 회의를 찾아야 한다.
        let prevIndex = findIndex(meetings[i - 1].start)
        dp[i] = max(dp[i - 1], dp[prevIndex] + meetings[i - 1].count)
    }

    print(dp[n])
}

solution()
