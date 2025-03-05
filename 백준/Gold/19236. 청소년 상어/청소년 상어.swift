import Foundation

// 물고기가 먼저 이동
// 물고기가 이동하는 함수 필요
// - 숫자가 작은 물고기 먼저 이동함
// - 물고기가 진행할 수 있는지 확인하는 함수
// - 방향을 모두 돌아도 이동할 수 없으면 이동하지 않음
// - 이동할 위치에 물고기 있으면 서로 위치 스왑 (swapAt() 사용)

// 상어 이동 함수
// - 물고기를 먹으면 해당 물고기의 방향을 가진다.
// - 이동하는 중 마주친 물고기는 안먹음
// - 물고기 없는 칸으로 이동은 불가능

// 상어는 어떤 물고기를 먹어야 하는가?
// - 항상 큰 번호의 물고기를 먹는 것이 나은가? - x
// 백트래킹을 이용하여 모든 경우의 수를 탐색

enum Direction: Int {
    case up
    case upLeft
    case left
    case downLeft
    case down
    case downRight
    case right
    case upRight
}

struct Pos {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

struct Fish: CustomStringConvertible {
    let number: Int
    var direction: Direction
    var description: String {
        return "\(number)"
    }

    init(_ number: Int, _ dirNumber: Int) {
        self.number = number
        direction = Direction(rawValue: dirNumber - 1)!
    }
}

let dy = [-1, -1, 0, 1, 1, 1, 0, -1]
let dx = [0, -1, -1, -1, 0, 1, 1, 1]

let size = 4
var res = 0
var index: [Int: Pos] = [:]
var boards: [[Fish?]] = []

for y in 0..<size {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    var fish: [Fish] = []

    for x in 0..<size {
        let fishNum = line[x * 2]
        let dirNum = line[x * 2 + 1]
        index[fishNum] = Pos(y, x)
        fish.append(Fish(fishNum, dirNum))
    }

    boards.append(fish)
}

// MARK: - 범위 확인
func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

// MARK: - 물고기 이동 함수
// 정방향 이동 시 번호순
func moveFish(_ fishNum: Int, _ sharkPos: Pos) {
    guard
        let pos = index[fishNum],
        let fish = boards[pos.y][pos.x]
    else { return }

    // 이동 가능할 때까지 반시계 방향 회전
    for dir in 0..<8 {
        var newDir = fish.direction.rawValue + dir
        newDir %= 8

        let ny = pos.y + dy[newDir]
        let nx = pos.x + dx[newDir]

        guard
            inRange(ny, nx),
            !(sharkPos.y == ny && sharkPos.x == nx)
        else { continue }

        // 이동이 가능한 경우 스왑해주기
        (boards[ny][nx], boards[pos.y][pos.x]) = (boards[pos.y][pos.x], boards[ny][nx])

        // 위치 갱신
        index[fish.number] = Pos(ny, nx)
        boards[ny][nx]!.direction = Direction(rawValue: newDir)!

        // 만약 스왑할 때 다른 물고기와 스왑했다면
        if let otherFish = boards[pos.y][pos.x] {
            index[otherFish.number] = Pos(pos.y, pos.x)
        }
        return
    }
}

// MARK: - 시뮬레이션 시작
func dfs(_ sharkPos: Pos, _ sharkDir: Direction, _ score: Int) {
    let boardsBackUp = boards
    let indexBackUp = index
    res = max(res, score)

    // 물고기를 이동시킨다.
    for fishNum in 1...16 {
        moveFish(fishNum, sharkPos)
    }

    // 상어는 한 번에 최대 3칸 이동이 가능하다.
    for dist in 1..<size {
        let ny = sharkPos.y + dy[sharkDir.rawValue] * dist
        let nx = sharkPos.x + dx[sharkDir.rawValue] * dist

        // 범위 내 이동인지 확인, 이동할 곳에 물고기가 있는지 확인
        guard
            inRange(ny, nx),
            let fish = boards[ny][nx]
        else { continue }

        // 물고기가 있다면, 먹는다.
        index[fish.number] = nil
        boards[ny][nx] = nil
        let newSharkDir = fish.direction

        // dfs 시작
        dfs(Pos(ny, nx), newSharkDir, score + fish.number)

        // 먹기 취소
        boards[ny][nx] = fish
        index[fish.number] = Pos(ny, nx)
    }

    // 물고기 이동을 되돌린다.
    boards = boardsBackUp
    index = indexBackUp
    return
}

// 상어 초기 위치 세팅
let initialSharkDirection = boards[0][0]!.direction
let initialScore = boards[0][0]!.number
boards[0][0] = nil
index[initialScore] = nil

dfs(
    Pos(0, 0),
    initialSharkDirection,
    initialScore)

print(res)
