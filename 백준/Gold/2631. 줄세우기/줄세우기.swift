import Foundation

// dp[i] := i번째 아이까지 순서대로 줄 세우는데 필요한 순서 조정 횟수
// i번쨰 아이를 적절한 자리로 옮기거나 옮기지 않는 선택을 할 수 있다.

let n = Int(readLine()!)!
var children: [Int] = []
var dp: [Int] = Array(repeating: 1, count: n)
var lis: [Int] = []

for _ in 0..<n {
    children.append(Int(readLine()!)!)
}

func findIndex(_ num: Int) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if lis[mid] < num {
            lo = mid
        } else {
            hi = mid
        }
    }

    return hi
}

for i in 0..<n {

    let index = findIndex(children[i])

    if index == lis.count {
        lis.append(children[i])
    } else {
        lis[index] = children[i]
    }
}

print(n - lis.count)
