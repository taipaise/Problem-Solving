import Foundation

struct Stack<T> {
    private var stack: [T]

    var count: Int {
        return stack.count
    }

    var isEmpty: Bool {
        return stack.isEmpty
    }

    var top: T? {
        if stack.isEmpty {
            return nil
        }
        return stack.last
    }
    
    init() {
        stack = []
    }

    mutating func push(_ item: T) {
        stack.append(item)
    }

    mutating func pop() -> T? {
        stack.popLast()
    }

    mutating func removeAll() {
        stack.removeAll()
    }
}

var stack = Stack<String>()
var n = Int(readLine()!)!

for _ in 0..<n {
    var temp = readLine()!
    let strs = temp.components(separatedBy: " ")
    let op = strs.first
    if op == "push" {
        stack.push(strs.last!)
    } else if op == "pop" {
        if let res = stack.pop() {
            print(res)
        } else {
            print(-1)
        }
    } else if op == "size" {
        print(stack.count)
    } else if op == "empty" {
        if stack.isEmpty {
            print(1)
        } else {
            print(0)
        }
    } else { //top
        if let res = stack.top {
            print(res)
        } else {
            print(-1)
        }
    }
}
