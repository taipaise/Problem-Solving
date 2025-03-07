import Foundation

// 아이디어: 가장 위쪽 칸부터 아래쪽 칸까지 순차적 탐색. 이동은 위쪽 대각선 -> 평향이동 -> 아래쪽 대각선

enum Space: String {
    case wall = "x"
    case blank = "."
    case pipeLine = "#"
}

enum Direction: Int, CaseIterable {
    case up
    case right
    case down
}

struct Pos {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let dy = [-1, 0, 1]
let dx = [1, 1, 1]
let maxX = width - 1
var boards: [[Space]] = []

func input() {
    for _ in 0..<height {
        let line = readLine()!.map { Space(rawValue: String($0))! }
        boards.append(line)
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

func isCross(_ destY: Int, _ destX: Int, _ direction: Direction) -> Bool {
    switch direction {
    case .up:
        return boards[destY][destX - 1] == .pipeLine && boards[destY + 1][destX] == .pipeLine
    case .down:
        return boards[destY][destX - 1] == .pipeLine && boards[destY - 1][destX] == .pipeLine
    default: // 오른쪽으로 이동한 경우 검사하지 않음 (아예 함수 실행 x)
        return false
    }
}

func move(_ y: Int, _ x: Int) -> Bool {
    if x == maxX { return true }

    for dir in Direction.allCases {
        let ny = y + dy[dir.rawValue]
        let nx = x + dx[dir.rawValue]

        guard
            inRange(ny, nx),
            boards[ny][nx] == .blank
        else { continue }

        if
            dir != .right,
            isCross(ny, nx, dir)
        { continue }

        boards[ny][nx] = .pipeLine

        if move(ny, nx) { return true }
    }

    return false
}

func solve() {
    var res = 0

    for y in 0..<height {
        guard boards[y][0] == .blank else { continue }
        if move(y, 0) { res += 1 }
    }

    print(res)
}

input()
solve()
