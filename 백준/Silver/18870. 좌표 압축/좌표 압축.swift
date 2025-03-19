import Foundation

let n = Int(readLine()!)!
let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
var sorted = Set(numbers).sorted()
var indices = Dictionary(uniqueKeysWithValues: sorted.enumerated().map { ($1, $0) })
var res = ""
for number in numbers {
    res += "\(indices[number, default: 0]) "
}
print(res.dropLast())
