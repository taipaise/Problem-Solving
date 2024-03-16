import Foundation

struct Number: Comparable {
    let number: Int
    var isUsed = false
    static func < (lhs: Number, rhs: Number) -> Bool {
        lhs.number < rhs.number
    }
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
var numbers = readLine()!
    .split(separator: " ")
    .map { Number(number: Int($0)!) }
    .sorted()

let n = input.first!
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
        if numbers[i].isUsed == true { continue }
        res.append(String(numbers[i].number))
        numbers[i].isUsed = true
        solve(count + 1)
        res.removeLast()
        numbers[i].isUsed = false
    }
}

solve(0)
print(resString.joined(separator: "\n"))
