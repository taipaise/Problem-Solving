import Foundation

let MAX = Int(1e7)
let n = Int(readLine()!)!
let m = Int(readLine()!)!
var dists = Array(
    repeating: Array(repeating: MAX, count: n),
    count: n)

for _ in 0..<m {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let start = input[0] - 1
    let dest = input[1] - 1
    let cost = input[2]
    dists[start][dest] = min(dists[start][dest], cost) // 노선이 하나가 아닐 수 있음
}

for by in 0..<n {
    for start in 0..<n {
        for dest in 0..<n {
            guard start != dest else { continue }
            
            dists[start][dest] = min(
                dists[start][dest],
                dists[start][by] + dists[by][dest])
        }
    }
}

let res = dists.map { line in
    line.map { element in
        return element != MAX ? "\(element)" : "\(0)"
    }.joined(separator: " ")
}.joined(separator: "\n")

print(res)