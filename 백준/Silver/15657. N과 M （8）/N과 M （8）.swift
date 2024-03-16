import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
let numbers = readLine()!
    .split(separator: " ")
    .map { Int($0)! }
    .sorted()

let n = input.first!
let m = input.last!

var res: [String] = []
var resString = ""

func solve(_ count: Int) {
    
    if count == m {
        resString += res.joined(separator: " ")
        resString += "\n"
        return
    }
    
    for i in 0..<n {
        
        if
            let last = res.last,
            Int(last)! > numbers[i]
        { continue }
        
        res.append(String(numbers[i]))
        solve(count + 1)
        res.removeLast()
    }
}

solve(0)
print(resString)
