import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let numbers = readLine()!
    .split(separator: " ")
    .map { Int($0)! }
    .sorted()

let n = input.first!
let m = input.last!

var res: [Int] = []
var resString = ""

func solve(_ count: Int) {
    
    if count == m {
        resString += res
            .map { String($0) }
            .joined(separator: " ")
        resString += "\n"
        return
    }
    
    numbers.forEach { number in
        if !res.contains(number) {
            res.append(number)
            solve(count + 1)
            res.removeLast()
        }
    }
}

solve(0)
print(resString)

