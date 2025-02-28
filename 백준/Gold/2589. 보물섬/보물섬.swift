import Foundation

enum Space: String {
    case land = "L"
    case water = "W"
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

struct Pos {
    let y: Int
    let x: Int
    let count: Int

    init(_ y: Int, _ x: Int, _ count: Int) {
        self.y = y
        self.x = x
        self.count = count
    }
}


let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
var boards: [[Space]] = []
var visited: [[Bool]] = Array(
    repeating: Array(repeating: false, count: width),
    count: height)
var result = 0
var dy = [-1, 1, 0, 0]
var dx = [0, 0, -1, 1]

func inputBoards() {
    for _ in 0..<height {
        let spaces = readLine()!
            .map { Space(rawValue: String($0))! }
        boards.append(spaces)
    }
}

func initVisited() {
    for y in 0..<height {
        for x in 0..<width {
            visited[y][x] = false
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

func bfs(_ start: Pos) -> Int {
    var queue = Queue<Pos>()
    var res = 0

    initVisited()
    visited[start.y][start.x] = true
    queue.push(start)

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return res }
        let y = pos.y
        let x = pos.x
        res = pos.count

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                !visited[ny][nx],
                boards[ny][nx] == .land
            else { continue }

            visited[ny][nx] = true
            queue.push(Pos(ny, nx, res + 1))
        }
    }

    return res
}


func solve() {
    inputBoards()

    for y in 0..<height {
        for x in 0..<width {
            guard boards[y][x] == .land else { continue }
            let dist = bfs(Pos(y, x, 0))

            result = max(dist, result)
        }
    }

    print(result)
}


solve()
