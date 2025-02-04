import Foundation

var count = Int(readLine()!)!
var numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
var stack: [Int] = []

for i in 0..<count {
    while
        !stack.isEmpty,
        numbers[stack.last!] < numbers[i]
    {
        numbers[stack.removeLast()] = numbers[i]
    }

    stack.append(i)
}

for element in stack {
    numbers[element] = -1
}

let result = numbers
    .map{ String($0) }
    .joined(separator: " ")
print(result)

