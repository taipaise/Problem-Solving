import Foundation

// 방문한 경로를 재방문할 가능성 있음 -> 시간 초과 시 최적화 필요

struct Pos: Hashable {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

struct BallPair: Hashable {
    let red: Pos
    let blue: Pos

    init(_ red: Pos, _ blue: Pos) {
        self.red = red
        self.blue = blue
    }
}

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
}

enum Space: String {
    case wall = "#"
    case blank = "."
    case hole = "O"
    case red = "R"
    case blue = "B"
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[Space]] = Array(
    repeating: Array(repeating: .blank, count: width),
    count: height)
var visited: [BallPair: Int] = [:]
var res = Int.max
var initialRed = Pos(0, 0)
var initialBlue = Pos(0, 0)

for y in 0..<height {
    let line = readLine()!.map { Space(rawValue: String($0))! }

    for x in 0..<width {
        if line[x] == .red {
            initialRed = Pos(y, x)
        } else if line[x] == .blue {
            initialBlue = Pos(y, x)
        } else {
            boards[y][x] = line[x]
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

// roll 함수 안에서 실제로 공을 굴리는 함수
func move(_ ball: Pos, _ direction: Direction) -> Pos {
    var curY = ball.y
    var curX = ball.x

    while true {
        let ny = curY + dy[direction.rawValue]
        let nx = curX + dx[direction.rawValue]

        guard
            boards[curY][curX] != .hole,
            inRange(ny, nx),
            boards[ny][nx] != .wall
        else { break }

        curY = ny
        curX = nx
    }

    return Pos(curY, curX)
}

// 방향에 따라 먼저 중력에 영향을 받는 공을 굴리는 함수
func roll(_ red: Pos, _ blue: Pos, _ direction: Direction) -> (red: Pos, blue: Pos) {
    enum FirstBall {
        case redFirst
        case blueFirst
    }

    let firstBall: FirstBall

    switch direction {
    case .up:
        firstBall = red.y < blue.y ? .redFirst : .blueFirst
    case .down:
        firstBall = red.y > blue.y ? .redFirst : .blueFirst
    case .left:
        firstBall = red.x < blue.x ? .redFirst : .blueFirst
    case .right:
        firstBall = red.x > blue.x ? .redFirst : .blueFirst
    }

    let (newRed, newBlue): (Pos, Pos)

    switch firstBall {
    case .redFirst:
        newRed = move(red, direction)
        let temp = boards[newRed.y][newRed.x]
        boards[newRed.y][newRed.x] = .wall
        newBlue = move(blue, direction)
        boards[newRed.y][newRed.x] = temp
    case .blueFirst:
        newBlue = move(blue, direction)
        let temp = boards[newBlue.y][newBlue.x]
        boards[newBlue.y][newBlue.x] = .wall
        newRed = move(red, direction)
        boards[newBlue.y][newBlue.x] = temp
    }

    return (newRed, newBlue)
}

func checkBlueInHole(_ blue: Pos, _ direction: Direction) -> Bool {
    var curY = blue.y
    var curX = blue.x

    while true {
        guard boards[curY][curX] != .hole else { return true }

        let ny = curY + dy[direction.rawValue]
        let nx = curX + dx[direction.rawValue]

        guard
            inRange(ny, nx),
            boards[ny][nx] != .wall
        else { break }

        curY = ny
        curX = nx
    }
    return false
}

// 깊이 우선 탐색을 통한 백트래킹
func dfs(_ red: Pos, _ blue: Pos, _ count: Int) {
    visited[BallPair(red, blue)] = count

    // 종료 조건1. 빨간 공이 구멍에 도달했을 때
    if boards[red.y][red.x] == .hole {
        res = min(res, count)
        return
    }

    // 종료 조건2. 10번 이동했을 경우
    if count >= 10 {
        if boards[red.y][red.x] == .hole { res = min(res, count) }
        return
    }

    for direction in Direction.allCases {
        let (newRed, newBlue) = roll(red, blue, direction)

        guard
            count < visited[BallPair(newRed, newBlue), default: Int.max]
        else { continue }

        if checkBlueInHole(blue, direction) { continue } // 파란 공이 hole에 들어가면 안됨

        dfs(newRed, newBlue, count + 1)
    }
}

dfs(initialRed, initialBlue, 0)
print(res < Int.max ? res : -1)
