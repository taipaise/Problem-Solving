import Foundation

enum Grade: String, CaseIterable {
    case ap = "A+"
    case a0 = "A0"
    case am = "A-"
    case bp = "B+"
    case b0 = "B0"
    case bm = "B-"
    case cp = "C+"
    case c0 = "C0"
    case cm = "C-"
    case dp = "D+"
    case d0 = "D0"
    case dm = "D-"
    case f = "F"
    
    var value: Float {
        switch self {
        case .ap:
            return 4.3
        case .a0:
            return 4.0
        case .am:
            return 3.7
        case .bp:
            return 3.3
        case .b0:
            return 3.0
        case .bm:
            return 2.7
        case .cp:
            return 2.3
        case .c0:
            return 2.0
        case .cm:
            return 1.7
        case .dp:
            return 1.3
        case .d0:
            return 1.0
        case .dm:
            return 0.7
        case .f:
            return 0
        }
    }
}

let input = readLine()!
let grades = Grade.allCases
for grade in grades {
    if grade.rawValue != input { continue }
    print(grade.value)
}
