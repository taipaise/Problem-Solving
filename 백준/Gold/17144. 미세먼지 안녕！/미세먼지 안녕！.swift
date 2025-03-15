import Foundation

struct Pos {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let second = numbers[2]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[Int]] = []
var purifiers: [Pos] = []

// 입력 받기
func input() {
    for y in 0..<height {
        let line = readLine()!
            .split(separator: " ")
            .map { Int(String($0))! }

        boards.append(line)

        for x in 0..<width {
            if line[x] == -1 {
                purifiers.append(Pos(y, x))
                boards[y][x] = 0
            }
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

func isPurifier(_ y: Int, _ x: Int) -> Bool {
    for purifier in purifiers {
        if y == purifier.y, x == purifier.x { return true }
    }

    return false
}

// 미세먼지 확산
func spread() {
    var adjust: [[Int]] = Array(
        repeating: Array(repeating: 0, count: width),
        count: height)

    // 보정값 구하기
    for y in 0..<height {
        for x in 0..<width {
            var spreadDirections: [Direction] = []

            for direction in Direction.allCases {
                let ny = y + dy[direction.rawValue]
                let nx = x + dx[direction.rawValue]

                guard
                    inRange(ny, nx),
                    !isPurifier(ny, nx)
                else { continue }

                spreadDirections.append(direction)
            }

            let adjustValue = (boards[y][x] / 5)

            for direction in spreadDirections {
                let ny = y + dy[direction.rawValue]
                let nx = x + dx[direction.rawValue]

                adjust[ny][nx] += adjustValue
            }

            adjust[y][x] -= adjustValue * spreadDirections.count
        }
    }

    // 보정값을 실제 방에 적용
    for y in 0..<height {
        for x in 0..<width {
            boards[y][x] += adjust[y][x]
        }
    }
}

// 공기청정기 작동
func purify(_ purifier: Pos, _ isClockwise: Bool) {
    let directions: [Direction] = isClockwise ? [.right, .down, .left, .up] : [.right, .up, .left, .down]
    var curDirectionIndex = 0

    var curY = purifier.y
    var curX = purifier.x + 1
    var prevDust = 0
    var curDust = 0

    while true {
        if
            curY == purifier.y,
            curX == purifier.x
        {
            boards[curY][curX] = 0
            return
        }
        var direction = directions[curDirectionIndex]

        // 이전 칸에서 먼지를 가져옴
        curDust = boards[curY][curX]
        boards[curY][curX] = prevDust
        prevDust = curDust

        // 좌표를 이동해야함
        let ny = curY + dy[direction.rawValue]
        let nx = curX + dx[direction.rawValue]

        if inRange(ny, nx) {
            curY = ny
            curX = nx
        } else {
            curDirectionIndex += 1
            direction = directions[curDirectionIndex]
            curY = curY + dy[direction.rawValue]
            curX = curX + dx[direction.rawValue]
        }
    }
}

func solve() {
    input()

    for _ in 0..<second {
        spread()
        purify(purifiers[0], false)
        purify(purifiers[1], true)
    }

    let res = boards.reduce(0) { $0 + $1.reduce(0, +) }
    print(res)
}

solve()
