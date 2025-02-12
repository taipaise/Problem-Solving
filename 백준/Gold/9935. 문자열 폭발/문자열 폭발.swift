import Foundation

var word = readLine()!.map { String($0) }
var bomb = readLine()!.map { String($0) }
var stack: [String] = []
func checkStack() -> Bool {
    guard stack.count >= bomb.count else { return false }

    let target = Array(stack[stack.count - bomb.count...stack.count - 1])

    guard target == bomb else { return false }

    stack.removeLast(bomb.count)

    return true
}

for char in word {
    stack.append(char)

    while checkStack() { }
}

stack.isEmpty ? print("FRULA") : print(stack.joined(separator: ""))
