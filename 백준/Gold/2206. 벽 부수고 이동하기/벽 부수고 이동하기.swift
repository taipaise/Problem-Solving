import Foundation

enum Cell: Int {
    case blank
    case wall
}

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
}

struct Pos {
    let y: Int
    let x: Int
    let count: Int
    let isBroken: Bool

    init(
        _ y: Int,
        _ x: Int,
        _ count: Int,
        _ isBroken: Bool
    ) {
        self.y = y
        self.x = x
        self.count = count
        self.isBroken = isBroken
    }
}

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

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers[0]
let m = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

var boards: [[Cell]] = []

for _ in 0..<n {
    boards.append(readLine()!.map { Cell(rawValue: Int(String($0))!)! })
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < m
}

func bfs() -> Int {
    var visited: [[[Int]]] = Array(
        repeating: Array(
            repeating: Array(repeating: n * m, count: 2),
            count: m),
        count: n)
    var queue = Queue<Pos>()
    visited[0][0][false.intValue] = 0
    queue.push(Pos(0, 0, 1, false))


    while let pos = queue.pop() {
        let y = pos.y
        let x = pos.x
        let count = pos.count

        if
            y == n - 1,
            x == m - 1
        { return count  }

        for direction in Direction.allCases {
            let ny = y + dy[direction.rawValue]
            let nx = x + dx[direction.rawValue]
            var isBroken = pos.isBroken

            guard inRange(ny, nx) else { continue }

            if boards[ny][nx] == .wall {
                guard !isBroken else { continue }
                // 벽을 부숴야 함
                isBroken = true
            }

            guard count + 1 < visited[ny][nx][isBroken.intValue] else { continue }

            visited[ny][nx][isBroken.intValue] = count + 1
            queue.push(Pos(ny, nx, count + 1, isBroken))
        }
    }

    return -1
}

print(bfs())

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
