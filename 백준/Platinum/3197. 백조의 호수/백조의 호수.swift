import Foundation

enum Space: String, Equatable, CustomStringConvertible {
    case water = "."
    case ice = "X"
    case swan = "L"

    var description: String {
        return self.rawValue
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

struct Pos: Hashable {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let maxY = numbers[0]
let maxX = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[Space]] = Array(
    repeating: Array(repeating: .water, count: maxX),
    count: maxY)
var visited: [[Bool]] = Array(
    repeating: Array(repeating: false, count: maxX),
    count: maxY)
var swanQueue = Queue<Pos>()
var meltQueue = Queue<Pos>()
var swans: [Pos] = []

for y in 0..<maxY {
    let line = readLine()!.map { Space(rawValue: String($0))! }

    for x in 0..<line.count {
        boards[y][x] = line[x]

        if line[x] == .swan {
            swans.append(Pos(y, x))
            meltQueue.push(Pos(y, x))
        } else if line[x] == .water {
            meltQueue.push(Pos(y, x))
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < maxY && 0 <= x && x < maxX
}

func bfs() -> Bool {
    var nextSwanQueue = Queue<Pos>()

    while !swanQueue.isEmpty {
        guard let pos = swanQueue.pop() else { return false }

        for dir in 0..<4 {
            let ny = pos.y + dy[dir]
            let nx = pos.x + dx[dir]

            guard
                inRange(ny, nx),
                !visited[ny][nx]
            else { continue }

            visited[ny][nx] = true

            switch boards[ny][nx] {
            case .swan:
                return true
            case .water:
                swanQueue.push(Pos(ny, nx))
            case .ice:
                nextSwanQueue.push(Pos(ny, nx))
            }
        }
    }
    swanQueue = nextSwanQueue
    return false
}


func melt() {
    var nextMeltQueue = Queue<Pos>()

    while !meltQueue.isEmpty {
        guard let ice = meltQueue.pop() else { return }

        for dir in 0..<4 {
            let ny = ice.y + dy[dir]
            let nx = ice.x + dx[dir]

            guard
                inRange(ny, nx),
                boards[ny][nx] == .ice
            else { continue }

            boards[ny][nx] = .water
            nextMeltQueue.push(Pos(ny, nx))
        }
    }
    meltQueue = nextMeltQueue
}

func solve() {
    let start = swans[0]
    var result = 0

    boards[start.y][start.x] = .water
    swanQueue.push(start)
    visited[start.y][start.x] = true

    while !bfs() {
        result += 1
        melt()
    }

    print(result)
}

solve()
