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

        if head > 100 {
            queue.removeFirst(head)
            head = 0
        }

        defer { head += 1 }
        return queue[head]
    }
}

struct Pos {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
var boards: [[Int]] = []
var ways = Array(
    repeating: Array(repeating: -1, count: width),
    count: height)

for _ in 0..<height {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    boards.append(line)
}

func inRange(y: Int, x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

// (y, x) 좌표에서 오른쪽 맨 아래까지 갈 수 있는 경로 수 return
func dfs(y: Int, x: Int) -> Int {
    // 종료 조건
    if
        y == height - 1,
        x == width - 1
    { return 1 }

    guard ways[y][x] == -1 else { return ways[y][x] }

    ways[y][x] = 0

    for dir in 0..<4 {
        let ny = y + dy[dir]
        let nx = x + dx[dir]

        guard
            inRange(y: ny, x: nx),
            boards[y][x] > boards[ny][nx]
        else { continue }

        ways[y][x] += dfs(y: ny, x: nx)
    }

    return ways[y][x]
}

print(dfs(y: 0, x: 0))
