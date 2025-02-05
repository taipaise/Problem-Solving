import Foundation

enum Bracket: String {
    case bigOpen = "["
    case bigClose = "]"
    case smallOpen = "("
    case smallClose = ")"
}

func checkBalance(_ line: [String]) -> Bool {
    var stack: [Bracket] = []

    for char in line {
        guard let bracket = Bracket(rawValue: char) else { continue }

        switch bracket {
        case .bigClose:
            guard
                !stack.isEmpty,
                stack.last == .bigOpen
            else { return false }
            stack.removeLast()
        case .smallClose:
            guard
                !stack.isEmpty,
                stack.last == .smallOpen
            else { return false }
            stack.removeLast()
        default:
            stack.append(bracket)
        }
    }
    return stack.isEmpty
}

func input() {
    while true {
        let line = readLine()!.map { String($0) }

        if
            line.count == 1,
            line[0].isEqual(".")
        { return }

        checkBalance(line) ? print("yes") : print("no")
    }
}

input()
