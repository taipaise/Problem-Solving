import Foundation

let input = readLine()!.split(separator: " ").map { Int($0)! }
var numbers = readLine()!
    .split(separator: " ")
    .map { Int($0)! }
let numbersSet = Set(numbers)
numbers = Array(numbersSet).sorted()

let n = numbers.count
let m = input.last!

var res: [String] = []
var resString: [String] = []
var check = Set<String>()

func solve(_ count: Int) {
    
    if count == m {
        let cur = res.joined(separator: " ")
        
        if check.contains(cur) { return }
        check.insert(cur)
        resString.append(cur)
        return
    }
    
    for i in 0..<n {
        res.append(String(numbers[i]))
        solve(count + 1)
        res.removeLast()
    }
}

solve(0)
print(resString.joined(separator: "\n"))
