import Foundation

// MARK: - 흐름
/*
 1. 바람을 내보내는 함수. bfs를 통해 바람을 내보낸다. visited 배열을 이용해 이미 방문한 칸의 온도를 높이지 않는다.
 2. 온도 조절하는 함수. 온도 조절은 모든 칸에서 '동시에 일어난다'. 좌상단에서 우하단까지 순차적으로 조절할 온도를 구한다. 단 즉각적으로 온도 조절 반영하면 안됨. 임시로 조절한 온도를 저장할 배열이 필요하다.
 3. 가장 바깥쪽 칸들의 온도를 1도씩 감소시킨다. (영하일 수는 없음)
 4. 조사하려는 모든 칸의 온도가 K 이상인지 확인한다. 101번 이상 탐색해야할 시 101을 출력하고 종료한다.

 */

// MARK: - 필요한 데이터 타입 정의
// 방향을 나타냄
enum Direction: Int {
    case right
    case left
    case up
    case down
}

// 위치를 나타내기 위한 Pos
struct Pos: Hashable {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }

    // 맨해튼 거리
    func dist(_ to: Pos) -> Int {
        return abs(to.y - y) + abs(to.x - x)
    }
}

// 벽의 type이 0이면 해당 칸의 아래쪽에 벽이 있는 것이다.
// 벽의 type이 1이면 해당 칸의 오른쪽에 벽이 있는 것이다.

// 공간을 나타내기 위한 데이터 구조
enum Space {
    case blank
    case purifier(direction: Direction)
    case target

    static func parse(_ value: Int) -> Self {
        switch value {
        case 0:
            return .blank
        case 5:
            return .target
        default:
            let direction = Direction(rawValue: value - 1)!
            return .purifier(direction: direction)
        }
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

// MARK: - 상수 및 변수
let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let targetTemp = numbers[2]
let dy = [
    [-1, 0, 1], // 우상, 우, 우하
    [-1, 0, 1], // 좌상, 좌, 좌하
    [-1, -1, -1], // 상우, 상, 상좌
    [1, 1, 1]] // 하우, 하, 하좌
let dx = [
    [1, 1, 1], // 우상, 우, 우하
    [-1, -1, -1], // 좌상, 좌, 좌하
    [1, 0, -1], // 상우, 상, 상좌
    [1, 0, -1]] // 하우, 하, 하좌

var boards: [[Space]] = []
var purifiers: [Pos] = []
var targets: [Pos] = []
var walls: [[[Bool]]] = Array(
    repeating: Array(
        repeating: Array(repeating: false, count: 4),
        count: width),
    count: height)

for y in 0..<height {
    var line: [Space] = []
    let inputs = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }

    for x in 0..<width {
        let space = Space.parse(inputs[x])
        line.append(space)

        if case .purifier = space {
            purifiers.append(Pos(y, x))
        } else if case .target = space {
            targets.append(Pos(y, x))
        }
    }
    boards.append(line)
}

let wallCount = Int(readLine()!)!

for _ in 0..<wallCount {
    let inputs = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    let y = inputs[0] - 1
    let x = inputs[1] - 1

    if inputs[2] == 0 { // 해당 칸과 칸의 위쪽 사이에 벽 있는 경우
        walls[y][x][Direction.up.rawValue] = true
        if inRange(y - 1, x) {
            walls[y - 1][x][Direction.down.rawValue] = true
        }
    } else { // 해당 칸과 칸의 오른쪽에 벽 있는 경우
        walls[y][x][Direction.right.rawValue] = true
        if inRange(y, x + 1) {
            walls[y][x + 1][Direction.left.rawValue] = true
        }
    }
}

var temps: [[Int]] = Array(
    repeating: Array(repeating: 0, count: width),
    count: height) // 온도 저장 위한 배열

// MARK: - 풀이 함수
// 바람을 내보내는 함수
func spread() {
    for purifier in purifiers {
        spread(start: purifier)
    }
}

func spread(start: Pos) {
    let purifier = boards[start.y][start.x]
    guard case let .purifier(direction) = purifier else { return }
    var queue = Queue<(pos: Pos, count: Int)>()
    var visited = Array(
        repeating: Array(repeating: false, count: width),
        count: height)

    let initialPos: Pos
    switch direction {
    case .up:
        initialPos = Pos(start.y - 1, start.x)
    case .down:
        initialPos = Pos(start.y + 1, start.x)
    case .left:
        initialPos = Pos(start.y, start.x - 1)
    case .right:
        initialPos = Pos(start.y, start.x + 1)
    }

    guard inRange(initialPos.y, initialPos.x) else { return }

    visited[initialPos.y][initialPos.x] = true
    temps[initialPos.y][initialPos.x] += 5
    queue.push((pos: initialPos, count: 5))


    while let info = queue.pop() {
        let pos = info.pos
        let count = info.count
        let y = pos.y
        let x = pos.x
        guard count > 1 else { continue }
        // 대각선 두 개, 정방향 한 개 확인하기
        for dir in 0..<3 {
            let ny = y + dy[direction.rawValue][dir]
            let nx = x + dx[direction.rawValue][dir]
            let nPos = Pos(ny, nx)

            guard
                inRange(ny, nx), // 범위 내인지 확인
                !visited[ny][nx], // 방문 안한 곳인지
                canSpread(from: pos, to: nPos, direction: direction) // 도달 가능한 곳인지
            else { continue }

            temps[ny][nx] += (count - 1)
            visited[ny][nx] = true // 방문처리

            queue.push((pos: nPos, count: count - 1))
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

// 이동 불가능한 예시를 좀 자세히 알려줬으면 30분은 더 빨리 풀었을거 같아..
func canSpread(from: Pos, to: Pos, direction: Direction) -> Bool {
    // 맨해튼 거리로 대각선인지 아닌지 확인
    let dist = from.dist(to)

    guard dist > 1 else { // 맨해튼 거리가 1이면 상하좌우 직선 이동
        switch direction {
        case .up:
            return !walls[from.y][from.x][Direction.up.rawValue]
        case .down:
            return !walls[from.y][from.x][Direction.down.rawValue]
        case .left:
            return !walls[from.y][from.x][Direction.left.rawValue]
        case .right:
            return !walls[from.y][from.x][Direction.right.rawValue]
        }
    }

    // 이동 방향이 우측 대각선인지, 좌측 대각선인지 확인
    let isRight = to.x > from.x

    // 이동 방향이 상측 대각선인지, 하측 대각선인지 확인/ 이동
    let isUp = to.y < from.y

    // 대각선 이동 확인
    switch direction {
    case .up:
        if isRight {
            return !walls[from.y][from.x][Direction.right.rawValue] && !walls[to.y][to.x][Direction.down.rawValue]
        } else {
            return !walls[from.y][from.x][Direction.left.rawValue] && !walls[to.y][to.x][Direction.down.rawValue]
        }
    case .down:
        if isRight {
            return !walls[from.y][from.x][Direction.right.rawValue] && !walls[to.y][to.x][Direction.up.rawValue]
        } else {
            return !walls[from.y][from.x][Direction.left.rawValue] && !walls[to.y][to.x][Direction.up.rawValue]
        }
    case .left:
        if isUp {
            return !walls[from.y][from.x][Direction.up.rawValue] && !walls[to.y][to.x][Direction.right.rawValue]
        } else {
            return !walls[from.y][from.x][Direction.down.rawValue] && !walls[to.y][to.x][Direction.right.rawValue]
        }
    case .right:
        if isUp {
            return !walls[from.y][from.x][Direction.up.rawValue] && !walls[to.y][to.x][Direction.left.rawValue]
        } else {
            return !walls[from.y][from.x][Direction.down.rawValue] && !walls[to.y][to.x][Direction.left.rawValue]
        }
    }
}

// 온도를 조절하는 함수
func adjustTemp() {
    let adjustDy = [1, 0]
    let adjustDx = [0, 1]
    var calcTemp = Array(
        repeating: Array(repeating: 0, count: width),
        count: height)

    for y in 0..<height {
        for x in 0..<width {
            for dir in 0..<2 {
                let ny = y + adjustDy[dir]
                let nx = x + adjustDx[dir]

                guard inRange(ny, nx) else { continue }
                if dir == 0 { // 하측에 벽 있으면 안됨
                    guard !walls[y][x][Direction.down.rawValue] else { continue }
                } else { // 우측에 벽 있으면 안됨
                    guard !walls[y][x][Direction.right.rawValue] else { continue }
                }

                // Pos(ny, nx)와 온도 조절
                let adjustValue = abs(temps[y][x] - temps[ny][nx]) / 4
                if temps[y][x] > temps[ny][nx] {
                    calcTemp[y][x] -= adjustValue
                    calcTemp[ny][nx] += adjustValue
                } else {
                    calcTemp[y][x] += adjustValue
                    calcTemp[ny][nx] -= adjustValue
                }
            }
        }
    }

    for y in 0..<height {
        for x in 0..<width {
            temps[y][x] += calcTemp[y][x]
            if temps[y][x] < 0 { temps[y][x] = 0 }
        }
    }
}

// 가장 자리 온도를 감소시키는 함수
func decrease() {
    if height > 2 {
        for y in 1..<height - 1 {
            temps[y][0] = max(0, temps[y][0] - 1)
            temps[y][width - 1] = max(0, temps[y][width - 1] - 1)
        }
    }

    if width > 2 {
        for x in 1..<width - 1 {
            temps[0][x] = max(0, temps[0][x] - 1)
            temps[height - 1][x] = max(0, temps[height - 1][x] - 1)
        }
    }


    // 네 모서리 온도 감소
    temps[0][0] = max(0, temps[0][0] - 1)
    temps[height - 1][0] = max(0, temps[height - 1][0] - 1)
    temps[0][width - 1] = max(0, temps[0][width - 1] - 1)
    temps[height - 1][width - 1] = max(0, temps[height - 1][width - 1] - 1)
}


// 온도 조건을 만족하는지 탐색하는 함수
func check() -> Bool {
    for target in targets {
        guard temps[target.y][target.x] >= targetTemp else { return false }
    }

    return true
}


func solution() {
    var count = 0
    while true {
        if count > 100 { break }

        spread()
        adjustTemp()
        decrease()
        count += 1
        
        if check() { break }
    }

    print(count)
}

solution()
