import Foundation

// 주의: 열쇠를 집으면, 이동했던 칸도 다시 이동할 수 있음 -> 어떻게 구현?
// 아이디어 1. 8차원 배열을 생성하여 열쇠 소유 여부에 따라 visited 배열 체크하기
// 아이디어 2. 열쇠 소유 여부를 비트마스킹으로 표시 -> 3차원 배열로 표시하기
enum Key: String {
    case a
    case b
    case c
    case d
    case e
    case f

    var value: Int {
        switch self {
        case .a:
            return 5
        case .b:
            return 4
        case .c:
            return 3
        case .d:
            return 2
        case .e:
            return 1
        case .f:
            return 0
        }
    }
}

enum Door: String {
    case A
    case B
    case C
    case D
    case E
    case F

    var key: Key {
        switch self {
        case .A:
            return .a
        case .B:
            return .b
        case .C:
            return .c
        case .D:
            return .d
        case .E:
            return .e
        case .F:
            return .f
        }
    }
}

enum BoardType: Equatable {
    case door(door: Door)
    case key(key: Key)
    case wall
    case blank
    case exit
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
    let key: Int

    init(_ y: Int, _ x: Int, _ key: Int) {
        self.y = y
        self.x = x
        self.key = key
    }
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let maxY = numbers[0]
let maxX = numbers[1]
var minsik = Pos(0, 0, 0)
var boards: [[BoardType]] = []
var visited: [[[Int]]] = Array( //열쇠 소유 여부
        repeating: Array( // 세로
            repeating: Array(repeating: Int.max, count: maxX), // 가로
            count: maxY),
        count: 0b111111 + 1)

// 미로 입력
for y in 0..<maxY {
    var inputs = readLine()!.map { String($0) }

    if let x = inputs.firstIndex(where: { $0 == "0" }) {
        minsik = Pos(y, x, 0)
        inputs[x] = "."
    }

    let line: [BoardType] = inputs.map {
        switch $0 {
        case "1":
            return .exit
        case ".":
            return .blank
        case "#":
            return .wall
        default:
            break
        }

        if let key = Key(rawValue: $0) {
            return .key(key: key)
        }

        return .door(door: Door(rawValue: $0)!)
    }
    boards.append(line)
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < maxY && 0 <= x && x < maxX
}

func bfs(_ start: Pos) -> Int {
    var queue = Queue<Pos>()
    queue.push(start)
    visited[0][start.y][start.x] = 0

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return -1 }
        let y = pos.y
        let x = pos.x
        let key = pos.key
        let time = visited[key][y][x]

        // 종료 조건
        if .exit == boards[y][x] {
            return visited[key][y][x]
        }

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]
            var newKey = key

            guard
                inRange(ny, nx),
                boards[ny][nx] != .wall
            else { continue }

            // 열쇠 찾으면, 열쇠 넣어주기
            if case .key(let key) = boards[ny][nx] {
                newKey |= (1 << key.value)
            }

            guard visited[newKey][ny][nx] > time + 1 else { continue }

            // 만약 문이라면, 열쇠를 가지고 있는지 확인하기
            if case .door(let door) = boards[ny][nx] {
                let requiredKey = door.key
                // 열쇠 없으면, continue
                guard key & (1 << requiredKey.value) != 0 else { continue }
            }

            visited[newKey][ny][nx] = time + 1
            let newPos = Pos(ny, nx, newKey)
            queue.push(newPos)
        }
    }
    return -1
}

print(bfs(minsik))