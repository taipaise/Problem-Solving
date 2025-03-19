import Foundation

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right

    var mirrorDirection: Self {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
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

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0

    init(_ arr: [T]) {
        queue = arr
    }

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

// 다행히 이동할 때마다 블록이 추가되는 경우 없음
let size = Int(readLine()!)!
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var res = 0

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

// 블럭들을 움직이는 함수
// 한 번의 이동에서 합쳐진 블록은 합쳐질 수 없음
func move(_ direction: Direction, _ boards: [[Int]]) -> [[Int]] {
    guard size > 1 else { return boards }
    var boards = boards
    // 합쳐졌는지 확인하는 블럭
    var isMerged = Array(repeating: Array(repeating: false, count: size), count: size)

    // 이동하려는 방향의 끝 - 1부터 확인해야 함 (위쪽 이동시 위쪽부터, 아래쪽 이동시 아래부터)
    var positions: Queue<Pos>
    switch direction {
    case .up:
        positions = Queue((0..<size).map { Pos(1, $0) })
    case .down:
        positions = Queue((0..<size).map { Pos(size - 2, $0) })
    case .left:
        positions = Queue((0..<size).map { Pos($0, 1) })
    case .right:
        positions = Queue((0..<size).map { Pos($0, size - 2) })
    }

    // 이동할 수 있는 경우
    // 이동하려는 칸이 0임
    // 이동하려는 칸의 숫자와 같은 값을 가지고 있고, 합쳐진 적이 없어야 함
    while let pos = positions.pop() { // 각 칸을 하나씩 이동
        let posValue = boards[pos.y][pos.x]
        boards[pos.y][pos.x] = 0 // 이동할 자리를 일단 0으로 바꾸고 시작

        var curY = pos.y
        var curX = pos.x
        // 이동하려는 칸
        while true {
            let ny = curY + dy[direction.rawValue]
            let nx = curX + dx[direction.rawValue]

            guard
                inRange(ny, nx),
                boards[ny][nx] == 0 || (!isMerged[ny][nx] && boards[ny][nx] == posValue)
            else { break }

            curY = ny
            curX = nx
        }

        if boards[curY][curX] > 0 {
            boards[curY][curX] *= 2
            isMerged[curY][curX] = true
        } else {
            boards[curY][curX] = posValue
        }

        // 이동 다 했으면 다음 줄 확인해야 함
        let ny = pos.y + dy[direction.mirrorDirection.rawValue]
        let nx = pos.x + dx[direction.mirrorDirection.rawValue]

        guard inRange(ny, nx) else { continue }
        positions.push(Pos(ny, nx))
    }
    return boards
}


func recursive(_ count: Int, _ prevBoards: [[Int]]) {
    if count == 5 {
        let maxElement = prevBoards.map { $0.max() ?? 0 }.max() ?? 0
        res = max(maxElement, res)
        return
    }

    for direction in Direction.allCases {
        let newBoards = move(direction, prevBoards)
        recursive(count + 1, newBoards)
    }
}

func solution() {
    var boards: [[Int]] = []

    for _ in 0..<size {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        boards.append(line)
    }
    recursive(0, boards)

    print(res)
}

solution()
