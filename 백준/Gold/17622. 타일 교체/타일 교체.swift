import Foundation

// 우상단 기준으로
enum Tile: Int, CaseIterable {
    case downRight
    case leftDown
    case UpRight
    case leftUp
    case upDown // 혹은 다운 업
    case leftRight // 혹은 rightLeft

    var availableDirections: [Direction] {
        switch self {
        case .downRight:
            return [.down, .right]
        case .leftDown:
            return [.left, .down]
        case .UpRight:
            return [.up, .right]
        case .leftUp:
            return [.left, .up]
        case .upDown:
            return [.up, .down]
        case .leftRight:
            return [.left, .right]
        }
    }
}

enum Direction: Int {
    case up
    case down
    case left
    case right


    var mirrorDirection: Direction {
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

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers[0]
let k = numbers[1]
var boards: [[Tile]] = []
var visited = Array(
    repeating: Array(repeating: false, count: n),
    count: n)
var canReach = Array(
    repeating: Array(repeating: 0, count: n),
    count: n)

for _ in 0..<n {
    let line = readLine()!.split(separator: " ").map { Tile(rawValue: (Int(String($0))!))! }
    boards.append(line)
}

// 교체 할 수 있는 타일의 최대 갯수 -> 1개. 브루트 포스
// k가 1인데 이미 이동가능하다면, 그리고 이동하지 않는 블록이 있다면 -> K가 1이어도 답임. 안쓰는 블럭을 바꾸면 되니까
// 50가지 블럭을 6종류로 모두 하나씩 확인한다면.. 6^50
// 도착점에서 갈 수 있는 블럭을 모두 표시 -> 해당 지점을 제외하고, 시작점에서부터 모든 블럭을 바꿔 본다. -> 도착점에서 갈 수 잇는 지점에 도착하면 성공

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n  && 0 <= x && x < n
}

// 도착 지점에서 먼저 갈 수 있는 지점들 체크
func markCanReach() {
    guard
        boards[n - 1][n - 1] == .leftRight ||
        boards[n - 1][n - 1] == .UpRight
    else { return }

    var queue = Queue<(Int, Pos)>()
    canReach[n - 1][n - 1] = 1
    queue.push((1, Pos(n - 1, n - 1)))

    while let (count, pos) = queue.pop() {
        let y = pos.y
        let x = pos.x
        let tile = boards[y][x]

        // 각 타일에서는 총 두 방향으로 이동할 수 있다.
        // 둘 중 하나가 바로 이전에 왔던 칸이다.
        var ny = -1
        var nx = -1

        for direction in tile.availableDirections {
            let tempNy = y + dy[direction.rawValue]
            let tempNx = x + dx[direction.rawValue]

            guard
                inRange(tempNy, tempNx),
                canReach[tempNy][tempNx] == 0,
                boards[tempNy][tempNx].availableDirections.map({ $0.mirrorDirection }).contains(direction)
            else { continue }

            ny = tempNy
            nx = tempNx
            break
        }

        guard
            ny != -1,
            nx != -1
        else { continue }

        canReach[ny][nx] = count + 1
        queue.push((count + 1, Pos(ny, nx)))
    }
}

// 타일을 하나 골라 바꾸는 함수
func selectAndChange() -> Int {
    canReach[0][0] = 0
    var moveCount = Int.max

    for y in 0..<n {
        for x in 0..<n {
            guard canReach[y][x] == 0 else { continue } // 도착지점 이미 방문 가능하면 바꿀 필요 없음

            let oldTile = boards[y][x]

            for i in 1...Tile.allCases.count {
                let newTile = Tile(rawValue: (oldTile.rawValue + i) % Tile.allCases.count)!
                boards[y][x] = newTile

                let curMoveCount = findRoute()
                if curMoveCount != -1 { moveCount = min(moveCount, curMoveCount) }

                boards[y][x] = oldTile
            }
        }
    }

    return moveCount < Int.max ? moveCount : -1
}

func findRoute() -> Int {
    guard
        boards[0][0] == .leftRight ||
        boards[0][0] == .leftDown
    else { return -1 }


    // 방문 배열 초기화
    for y in 0..<n {
        for x in 0..<n {
            visited[y][x] = false
        }
    }

    var queue = Queue<(Int, Pos)>()
    visited[0][0] = true
    queue.push((1, Pos(0, 0)))

    while let (count, pos) = queue.pop() {
        let y = pos.y
        let x = pos.x
        let tile = boards[y][x]

        if canReach[y][x] > 0 { return count + canReach[y][x] - 1 }

        if
            y == n - 1,
            x == n - 1,
            boards[n - 1][n - 1] == .leftRight || boards[n - 1][n - 1] == .UpRight
        { return count }

        // 각 타일에서는 총 두 방향으로 이동할 수 있다.
        // 둘 중 하나가 바로 이전에 왔던 칸이다.
        var ny = -1
        var nx = -1

        for direction in tile.availableDirections {
            let tempNy = y + dy[direction.rawValue]
            let tempNx = x + dx[direction.rawValue]

            guard
                inRange(tempNy, tempNx),
                !visited[tempNy][tempNx],
                boards[tempNy][tempNx].availableDirections.map({ $0.mirrorDirection }).contains(direction)
            else { continue }

            ny = tempNy
            nx = tempNx
            break
        }

        guard ny != -1, nx != -1 else { continue }
        visited[ny][nx] = true
        queue.push((count + 1, Pos(ny, nx)))
    }

    return -1
}


func solution() {
    markCanReach()
    var moveCount = findRoute()


    if moveCount != -1
    {

        // k가 0이면 바로 답
        if k == 0 {
            print(moveCount)
        } else {
            if moveCount < n * n {
                print(moveCount)
            } else {
                print(-1)
            }
        }
        return
    }


    if k == 1 {
        moveCount = selectAndChange()
    }

    print(moveCount)
}

solution()
