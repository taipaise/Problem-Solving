import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input.first!
let m = input.last!

var res: [Int] = []

func solve(_ count: Int) {
    
    if count == m {
        print(
            res
                .map { String($0) }
                .joined(separator: " ")
        )
        return
    }
    
    for i in 1...n {
        if res.contains(i) { continue }
        res.append(i)
        solve(count + 1)
        res.popLast()
    }
}

solve(0)
