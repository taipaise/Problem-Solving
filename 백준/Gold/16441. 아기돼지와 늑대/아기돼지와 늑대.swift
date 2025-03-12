import Foundation

enum Space: String {
    case wolf = "W"
    case wall = "#"
    case blank = "."
    case ice = "+"
    case safe = "P"
}

struct Pos: Equatable {
    let y: Int
    let x: Int
}

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
}

struct Queue<T> {
    private var queue: [T] = []
    private var head: Int = 0
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

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[Space]] = []
var visited: [[Bool]] = Array(
    repeating: Array(repeating: false, count: width),
    count: height)
var wolves: [Pos] = []


// 입력 받기
for y in 0..<height {
    let line: [Space] = readLine()!
        .enumerated()
        .map { x, element in
            let space = Space(rawValue: String(element))!
            if space == .wolf {
                wolves.append(Pos(y: y, x: x))
            }
            return space
        }
    boards.append(line)
}

// 좌표가 범위 내인지 확인
func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

// 늑대 이동시키는 함수. 방문했는지 안했는지 당장 따지지는 않음
func move(_ initialPos: Pos, _ direction: Direction) -> Pos {
    var curPos = initialPos
    // 초원을 만나거나, 벽을 만나기 전까지 이동해야 함
    while true {
        // 이동
        let ny = curPos.y + dy[direction.rawValue]
        let nx = curPos.x + dx[direction.rawValue]

        guard
            inRange(ny, nx),
            boards[ny][nx] != .wall
        else { break }

        curPos = Pos(y: ny, x: nx)

        // 초원인지 확인
        if boards[curPos.y][curPos.x] == .blank || boards[curPos.y][curPos.x] == .wolf { break }
    }

    return curPos
}

// 늑대 한 마리에 대한 bfs함수
func bfs(_ start: Pos) {
    var queue = Queue<Pos>()
    queue.push(start)
    visited[start.y][start.x] = true

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return }

        for dir in Direction.allCases {
            let nextPos = move(pos, dir)

            guard
                pos != nextPos,
                !visited[nextPos.y][nextPos.x]
            else { continue }

            visited[nextPos.y][nextPos.x] = true
            queue.push(nextPos)
        }
    }
}

func solve() {
    // 모든 늑대에 대해 bfs 수행
    for wolf in wolves {
        bfs(wolf)
    }

    for wolf in wolves {
        boards[wolf.y][wolf.x] = .wolf
    }

    // visited가 false이고, 초원인 곳은 안전 구역
    for y in 0..<height {
        for x in 0..<width {
            guard
                !visited[y][x],
                boards[y][x] == .blank
            else { continue }

            boards[y][x] = .safe
        }
    }

    for line in boards {
        for space in line {
            print(space.rawValue, terminator: "")
        }
        print()
    }
}

solve()