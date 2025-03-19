import Foundation

// 큐 사용
// pop 후 front에 있는 값이 Pop한 값보다 크면 -> front까지 빼서 생각해야함

enum Roman: String, CaseIterable {
    case I
    case IV
    case V
    case IX
    case X
    case XL
    case L
    case XC
    case C
    case CD
    case D
    case CM
    case M

    var value: Int {
        switch self {
        case .I:
            return 1
        case .IV:
            return 4
        case .V:
            return 5
        case .IX:
            return 9
        case .X:
            return 10
        case .XL:
            return 40
        case .L:
            return 50
        case .XC:
            return 90
        case .C:
            return 100
        case .CD:
            return 400
        case .D:
            return 500
        case .CM:
            return 900
        case .M:
            return 1000
        }
    }
}

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0

    init(_ arr: [T]) {
        queue = arr
    }

    var isEmpty: Bool {
        return head >= queue.count
    }
    var front: T? {
        guard !isEmpty else { return nil }
        return queue[head]
    }

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        defer { head += 1 }
        return queue[head]
    }
}

var number1Roman = readLine()!
var number2Roman = readLine()!

func romanToArabian(_ roman: String) -> Int {
    var queue = Queue<Roman>(roman.map { Roman(rawValue: String($0))! })
    var res = 0

    while let element = queue.pop() {
        if
            let secondElement = queue.front,
            element.value < secondElement.value,
            let secondElement = queue.pop()
        {
            res += (secondElement.value - element.value)
        } else {
            res += element.value
        }
    }

    return res
}

func arabianToRoman(_ arabian: Int) -> String {
    var arabian = arabian
    var res = ""
    let romans = Array(Roman.allCases.reversed())
    var index = 0

    while
        arabian > 0,
        index < romans.count
    {
        if romans[index].value <= arabian {
            res += romans[index].rawValue
            arabian -= romans[index].value
        } else {
            index += 1
        }
    }

    return res
}

let arabian = romanToArabian(number1Roman) + romanToArabian(number2Roman)
let roman = arabianToRoman(arabian)

print(arabian, roman, separator: "\n")
