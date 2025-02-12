import Foundation

struct Item {
    let weight: Int
    let value: Int

    init(_ weight: Int, _ value: Int) {
        self.weight = weight
        self.value = value
    }
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let maxWeight = numbers[1]
var items: [Item] = []
// dp[i][j] := i번째 item까지 선택했을 때, j무게에서 얻을 수 있는 최대 가치
var dp: [[Int]] = Array(
    repeating: Array(repeating: 0, count: maxWeight + 1),
    count: n + 1)


for _ in 0..<n {
    let inputs = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    items.append(Item(inputs[0], inputs[1]))
}

for item in 1...n {
    for weight in 1...maxWeight {
        let curItem = items[item - 1]

        // 현재 아이템의 무게가 확인하고 싶은 무게보다 작거나 같아야 함
        guard curItem.weight <= weight else {
            dp[item][weight] = dp[item - 1][weight]
            continue
        }

        dp[item][weight] = max(
            dp[item - 1][weight], // 현재 아이템을 선택하지 않음
            dp[item - 1][weight - curItem.weight] + curItem.value // 현재 아이템을 선택
        )
    }
}

print(dp[n][maxWeight])
