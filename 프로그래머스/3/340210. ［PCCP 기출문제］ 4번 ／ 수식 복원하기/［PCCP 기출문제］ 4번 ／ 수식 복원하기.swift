import Foundation

/*
1. 10진법이 아닌 n진법은 문자열로 표시해야한다.
2. n진법 계산 시 10진법으로 변환한 후 다시 n진법으로 변환한다.
3. n진법의 숫자는 n이상의 숫자를 사용할 수는 없다.
4. 가능한 진법을 집합으로 관리하고, 소거법으로 사용 불가능한 진법을 걷어낸다.
5. 가능한 진법만 모아 결과를 반환한다.
*/

// index로 사용할 상수
let num1Index = 0
let opIndex = 1
let num2Index = 2

// 연산자 열거형
enum Operator: String {
    case plus = "+"
    case minus = "-"
}

// 가능한 진수를 담은 집합
var candidates: Set<Int> = [2,3,4,5,6,7,8,9]

// convert to n-base. 
func convertToN(_ num :Int, _ base: Int) -> String {
    guard num != 0 else { return "0" }

    var num = num
    var result = ""
    
    while num > 0 {
        result = "\(num % base)" + result
        num /= base
    }
    
    return result
}

// convert to 10-base
func convertTo10(_ num: String, _ base: Int) -> Int {
    var result = 0
    let elements = num.map { Int(String($0))! }
    
    for element in elements {
        result *= base
        result += element
    }
    
    return result
}

// check is n-base
func checkIsNBase(_ num: String, _ base: Int) -> Bool {
    guard num != "X" else { return true }

    let elements = num.map { String($0) }
    
    for element in elements {
        guard element < "\(base)" else { return false }
    }
    
    return true
}

// 완성, 미완성 수식을 분리
func classifyExpression(_ expressions: [String]) -> ([String], [String]) {
    var completion: [String] = []
    var incompletion: [String] = []
    
    for expression in expressions {
        if expression.last == "X" {
            incompletion.append(expression)
        } else {
            completion.append(expression)
        }
    }
    
    return (completion, incompletion)
}

// 표현식 하나가 n base인지 확인하는 함수
func checkExpression(_ expression: String, _ base: Int) -> Bool {
    let expressionElements = expression.components(separatedBy: " ")
    let num1String = expressionElements[num1Index]
    let num2String = expressionElements[num2Index]
    let opString = expressionElements[opIndex]
    let resultString = expressionElements.last!
    
    // n진법으로 이뤄진 수인지 먼저 확인
    guard
        checkIsNBase(num1String, base),
        checkIsNBase(num2String, base),
        checkIsNBase(resultString, base)
    else { return false }
    
    guard expression.last != "X" else { return true }
    
    // 완성된 수식일 경우 결과 계산
    // 먼저 계산을 위해 숫자를 10진수로 변환
    let num1 = convertTo10(num1String, base)
    let num2 = convertTo10(num2String, base)
    let result = convertTo10(resultString, base)
    let op = Operator(rawValue: opString)!
    
    // switch 문에 따라 계산
    // 계산 결과에 따라 참 거짓 return
    switch op {
    case .plus:
        return num1 + num2 == result
    case .minus:
        return num1 - num2 == result
    }
}

// 표현식들이 n base인지 검증하는 함수
func checkExpressions(_ expressions: [String], _ base: Int) -> Bool {
    for expression in expressions {
        guard checkExpression(expression, base) else { return false }
    }

    return true
}

// 불완전 수식을 계산하는 함수
func calculate(_ expression: String) -> String {
    var result = expression.dropLast()
    // 수식의 결과를 임시 저장할 변수
    var answer: String? = nil
    
    // 반복문을 돌며 가능한 진법에 대해 결과를 확인
    for base in candidates {
        // 계산을 위해 10진법으로 변환
        let expressionElements = expression.components(separatedBy: " ")
        let num1String = expressionElements[num1Index]
        let num2String = expressionElements[num2Index]
        let opString = expressionElements[opIndex]
        
        let num1 = convertTo10(num1String, base)
        let num2 = convertTo10(num2String, base)
        let op = Operator(rawValue: opString)!
        let curAnswer: Int

        switch op {
        case .plus:
            curAnswer = num1 + num2            
        case .minus:
            curAnswer = num1 - num2
        }
        
        // 계산 결과를 다시 base로 바꿈
        let curAnswerString = convertToN(curAnswer, base)
        
        // 계산 결과를 이전 결과와 비교
        guard answer != nil else {
            answer = curAnswerString
            continue
        }
        
        // 이전 결과와 다르다면 답은 ?
        if curAnswerString != answer {
            return result + "?"
        }
    }
    
    return result + (answer ?? "?")
}

func solution(_ expressions:[String]) -> [String] {
    var result: [String] = []
    // 우선 완성 수식, 미완성 수식 분리
    let (completedExrpessions, incompletedExpressions) = classifyExpression(expressions)
    
    // 전체 표현식을 대상으로 사용 불가능한 진법 소거
    candidates = candidates.filter { checkExpressions(expressions, $0) }
    
    // 불완적 수식 계산 후 결과 배열에 저장
    for expression in incompletedExpressions {
        result.append(calculate(expression))
    }

    return result
}