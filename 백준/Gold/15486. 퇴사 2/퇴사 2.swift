import Foundation

struct Work {
    let time: Int
    let price: Int

    init(_ time: Int, _ price: Int) {
        self.time = time
        self.price = price
    }
}


let n = Int(readLine()!)!
var works: [Work] = [Work(0, 0)]
var dp: [Int] = Array(repeating: 0, count : n + 2)
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    works.append(Work(line[0], line[1]))
}

// dp[i] := i번째 일까지 탐색했을 때 얻을 수 있는 최대 이익
for i in stride(from: n, to: 0, by: -1) {

    // 끝나는 날 이후에 일이 끝나면 해당 일은 일을 할 수 없다.
    guard works[i].time + i - 1 <= n else {
        dp[i] = dp[i + 1]
        continue
    }

    // 해당 날짜에 일을 하는 경우 / 일을 하지 않는 경우
    dp[i] = max(
        dp[i + works[i].time] + works[i].price, // i + time 일에 얻을 수 있는 이익 + 일했을 때 얻는 이익
        dp[i + 1])
}

print(dp[1])
