import Foundation

let n = Int(readLine()!)!
let FullMask = ((1 << n) - 1)
var costs: [[Int]] = []
var dp: [[Int]] = Array(
    repeating: Array(repeating: Int.max, count: n),
    count: FullMask + 1)

func initialize() {
    for _ in 0..<n {
        let line = readLine()!
            .split(separator: " ")
            .map { Int(String($0))!}
        costs.append(line)
    }
}

func solve() {
    initialize()

    dp[1][0] = 0


    for mask in 1...FullMask {
        for city in 0..<n {
            if dp[mask][city] == Int.max { continue }

            for next in 0..<n {
                guard
                    (mask & (1 << next)) == 0, // 방문하지 않았어야 하고
                    costs[city][next] != 0 // 길이 있어야 함
                else { continue }

                let nextMask = mask | (1 << next)

                dp[nextMask][next] = min(
                    dp[nextMask][next],
                    dp[mask][city] + costs[city][next])
            }
        }
    }

    var res = Int.max

    for city in 1..<n {
        guard
            costs[city][0] != 0,
            dp[FullMask][city] < Int.max
        else { continue }

        res = min(
            res,
            dp[FullMask][city] + costs[city][0])
    }

    print(res)
}

solve()
