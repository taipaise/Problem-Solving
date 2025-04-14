import Foundation

struct Deque<T> {
    private var left: [T] = []
    private var right: [T] = []
    private var leftHead = 0
    private var rightHead = 0

    private var isLeftEmpty: Bool {
        return leftHead >= left.count
    }

    private var isRightEmpty: Bool {
        return rightHead >= right.count
    }

    var isEmpty: Bool {
        return isLeftEmpty && isRightEmpty
    }

    mutating func pushLeft(_ element: T) {
        left.append(element)
    }

    mutating func pushRight(_ element: T) {
        right.append(element)
    }

    mutating func popLeft() -> T? {
        guard !isEmpty else { return nil }

        if isLeftEmpty {
            guard !isRightEmpty else { return nil }

            defer { rightHead += 1 }
            return right[rightHead]
        }

        return left.removeLast()
    }

    mutating func popRight() -> T? {
        guard !isEmpty else { return nil }

        if isRightEmpty {
            guard !isLeftEmpty else { return nil }

            defer { leftHead += 1 }
            return left[leftHead]
        }

        return right.removeLast()
    }
}

enum Operator: CaseIterable {
    case minus
    case plus
    case mult

    func calc(_ num: Int) -> Int {
        switch self {
        case .minus:
            return num - 1
        case .plus:
            return num + 1
        case .mult:
            return num * 2
        }
    }
}

struct PosInfo {
    let pos: Int
    let count: Int

    init(_ pos: Int, _ count: Int) {
        self.pos = pos
        self.count = count
    }
}

let inputs = readLine()!.split(separator: " ").map { Int(String($0))! }
let start = inputs[0]
let end = inputs[1]
let MAX = Int(1e5)

func bfs() -> Int {
    var visited = Array(repeating: MAX + 1, count: MAX + 1)
    var deque = Deque<PosInfo>()
    visited[start] = 0
    deque.pushRight(PosInfo(start, 0))

    while let info = deque.popLeft() {
        let pos = info.pos
        let count = info.count
        
        if pos == end { return count }

        for op in Operator.allCases {
            let newPos = op.calc(pos)

            guard
                0 <= newPos,
                newPos <= MAX
            else { continue }

            switch op {
            case .mult:
                guard count < visited[newPos] else { continue }
                deque.pushLeft(PosInfo(newPos, count))
                visited[newPos] = count
            default:
                guard count + 1 < visited[newPos] else { continue }
                deque.pushRight(PosInfo(newPos, count + 1))
                visited[newPos] = count + 1
            }
        }
    }
    return 0
}

print(bfs())
