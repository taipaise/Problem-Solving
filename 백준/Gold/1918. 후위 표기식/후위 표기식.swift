import Foundation

// 중위 표기식 -> 후위 표기식으로 바꾸기
// 피 연산자는 그대로 출력
// 연산자
//  스택이 비어있으면 넣는다.
//  본인보다 우선 순위가 같거나 높은 연산자가 없을 때까지 스택의 연산자를 꺼낸다. 여는 괄호는 닫는 괄호가 나오지 않으면 꺼내지 않음!!
//  본인을 넣는다.
enum Operator: String, Comparable {
    case addtion = "+"
    case subtraction = "-"
    case multiplication = "*"
    case division = "/"
    case open = "("
    case close = ")"

    var priority: Int {
        switch self {
        case .addtion, .subtraction:
            return 0
        case .multiplication, .division:
            return 1
        case .open, .close:
            return 2
        }
    }

    static func <(_ lhs: Operator, _ rhs: Operator) -> Bool {
        return lhs.priority < rhs.priority
    }
}

let infixExpression = readLine()!.map { String($0) }
var operatorStack: [Operator] = []
var res = ""

for element in infixExpression {
    if let op = Operator(rawValue: element) {
        // 닫는 괄호일 경우
        if op == .close {
            // 여는 괄호가 나올 때까지 스택에서 요소를 뺀다.
            while true {
                let lastOperator = operatorStack.removeLast()
                if lastOperator == .open { break }
                res += lastOperator.rawValue
            }
            continue
        }


        // 자기와 우선순위가 같거나 같은 것들을 스택에서 뺀다.
        while
            let lastOperator = operatorStack.last,
            op <= lastOperator
        {
            guard lastOperator != .open else { break } // 여는 괄호는 빼지 않음
            res += operatorStack.removeLast().rawValue
        }

        operatorStack.append(op)
    } else {
        res += element
    }
}

while !operatorStack.isEmpty {
    res += operatorStack.removeLast().rawValue
}

print(res)
