import Foundation


enum Parentheses: String {
    case opening = "("
    case closing = ")"
}

func solution(_ s:String) -> Bool {
    var stack: [Parentheses] = []
    let elements = s.map { Parentheses(rawValue: String($0))! }
    
    for element in elements {
        switch element {
        case .opening:
            stack.append(.opening)
        case .closing:
            // 스택이 비어있으면 안됨.
            guard !stack.isEmpty else { return false }
            stack.removeLast()
        }
    }
    
    return stack.isEmpty
}