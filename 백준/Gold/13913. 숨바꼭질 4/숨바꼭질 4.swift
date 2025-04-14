import Foundation

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    var isEmpty: Bool {
        return head >= queue.count
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

let inputs = readLine()!.split(separator: " ").map { Int(String($0))! }
let start = inputs[0]
let end = inputs[1]
let MAX = Int(1e5)

func bfs() -> [String] {
    var visited = Array(repeating: -1, count: MAX + 1)
    var queue = Queue<Int>()
    visited[start] = start
    queue.push(start)

    while let pos = queue.pop() {

        if pos == end {
            var curPos = pos
            var res: [String] = ["\(curPos)"]

            while curPos != start {
                res.append("\(visited[curPos])")
                curPos = visited[curPos]
            }
            return res
        }

        for op in Operator.allCases {
            let newPos = op.calc(pos)

            guard
                0 <= newPos,
                newPos <= MAX,
                visited[newPos] == -1
            else { continue }

            queue.push(newPos)
            visited[newPos] = pos
        }
    }

    return []
}

let res = bfs().reversed()
print(res.count - 1)
print(res.joined(separator: " "))
