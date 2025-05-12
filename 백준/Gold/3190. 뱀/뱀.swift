import Foundation

// 사과 먹으면 사과가 없어지고 꼬리가 움직이지 않는다.
// 1. 머리를 한 칸 늘려서 몸 길이를 늘린다.
// 2. 이동하는 칸에 사과가 있으면 사과를 없애고 꼬리를 움직이지 않는다
// 3. 사과 없으면 꼬리를 이동해서 몸 길이를 줄인다.
// 자기 자신이나 벽에 닿으면 게임이 끝난다

enum CommandDirection: String {
    case left = "L"
    case right = "D"

    var diff: Int {
        switch self {
        case .left:
            return -1
        case .right:
            return 1
        }
    }
}

enum Direction: Int, CaseIterable {
    case up
    case right
    case down
    case left

    func rotate(_ command: CommandDirection) -> Direction {
        let next = ((self.rawValue) + Direction.allCases.count + command.diff) % Direction.allCases.count
        return Direction(rawValue: next)!
    }
}

enum Space {
    case snake
    case blank
    case apple
}

struct RotateCommand {
    let time: Int
    let direction: CommandDirection
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

class Snake {
    private(set) var head: Pos
    private(set) var direction: Direction
    private(set) var traces = Queue<Pos>()

    init(head: Pos, direction: Direction) {
        self.head = head
        self.direction = direction
        traces.push(head)
    }

    func move(_ pos: Pos) {
        traces.push(pos)
        head = pos
    }

    func removeTail() -> Pos? {
        return traces.pop()
    }

    func rotate(_ commandDirection: CommandDirection) {
        direction = direction.rotate(commandDirection)
    }
}

let n = Int(readLine()!)!
let dy = [-1, 0, 1, 0]
let dx = [0, 1, 0, -1]
var boards: [[Space]] = Array(
    repeating: Array(repeating: .blank, count: n),
    count: n)
var commands: [RotateCommand] = []

func input() {
    let appleCount = Int(readLine()!)!
    for _ in 0..<appleCount {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
        boards[line[0]][line[1]] = .apple
    }

    let commandCount = Int(readLine()!)!

    for _ in 0..<commandCount {
        let line = readLine()!.split(separator: " ").map { String($0) }
        let count = Int(line[0])!
        let direction = CommandDirection(rawValue: line[1])!
        let command = RotateCommand(time: count, direction: direction)
        commands.append(command)
    }

    commands.append(RotateCommand(time: 10001, direction: .left))
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < n
}

func move(_ snake: Snake) -> Bool {
    let ny = snake.head.y + dy[snake.direction.rawValue]
    let nx = snake.head.x + dx[snake.direction.rawValue]

    guard
        inRange(ny, nx), // 범위 내에 있는지
        boards[ny][nx] != .snake // 몸통을 만나지는 않았는지
    else { return false }

    let isNextApple = boards[ny][nx] == .apple // 다음 칸이 사과인지 확인
    boards[ny][nx] = .snake // 일단 한 칸 전진
    snake.move(Pos(ny, nx))

    if
        !isNextApple,
        let tail = snake.removeTail()
    {
        // 꼬리를 한 칸 전진
        boards[tail.y][tail.x] = .blank
    }

    return true
}

func solution() {
    var time = 0
    let snake = Snake(head: Pos(0, 0), direction: .right)
    boards[0][0] = .snake
    input()

    for command in commands {
        var isGameOver = false

        while time < command.time {
            if !move(snake) {
                time += 1 
                isGameOver = true
                break
            }
            time += 1
        }

        if isGameOver { break }

        snake.rotate(command.direction)
    }

    print(time)
}

solution()
