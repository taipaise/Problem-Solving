import Foundation

// 냄새 없는 곳 > 내 냄새가 있는 곳
// 우선 순위 같은 곳이 있다면, 방향 우선 순위를 따짐

// MARK: - 문제 풀이 위한 데이터 구조
enum Direction: Int {
    case up
    case down
    case left
    case right
}

struct Pos: Hashable {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

struct Shark: Hashable {
    let number: Int
    var priorities: [[Direction]]
    var direction: Direction
}

struct Space {
    var number: Int
    var smellCount: Int

    init(number: Int, smellCount: Int) {
        self.number = number
        self.smellCount = smellCount
    }
}

// MARK: - 변수 및 상수
let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let size = numbers[0]
let sharkCount = numbers[1]
let smellCount = numbers[2]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var spaces: [[Space]] = []
var sharks: [Shark] = [Shark(
    number: 0,
    priorities: [],
    direction: .up)] // 상어 0 패딩
var sharkPos: [Int: Pos] = [:] // 상어 번호로 위치 조회

// MARK: - 입력
func inputBoards() {
    for y in 0..<size {
        let line: [Space] = readLine()!
            .split(separator: " ")
            .enumerated()
            .map { (index, numberString) in
                let number = Int(String(numberString))!
                if number > 0 {
                    sharkPos[number] = Pos(y, index)
                    sharks.append(Shark(
                        number: number,
                        priorities: [],
                        direction: .up))
                    return Space(number: number, smellCount: smellCount)
                } else {
                    return Space(number: 0, smellCount: 0)
                }
            }

        spaces.append(line)
    }
}

func inputSharks() {
    sharks.sort(by: {$0.number < $1.number }) // 상어 번호 순 정렬

    // 상어의 초기 방향 입력 받기
    let directions: [Direction] = readLine()!
        .split(separator: " ")
        .map {
            let rawValue = Int(String($0))! - 1
            return Direction(rawValue: rawValue)!
        }

    for i in 1...sharkCount {
        sharks[i].direction = directions[i - 1]
    }

    // 각 상어의 방향 별 우선 순위 입력
    for i in 1...sharkCount {
        for _ in 0..<4 {
            let priority: [Direction] = readLine()!
                .split(separator: " ")
                .map {
                    let rawValue = Int(String($0))! - 1
                    return Direction(rawValue: rawValue)!
                }
            sharks[i].priorities.append(priority)
        }
    }
}


// MARK: - 풀이
// 범위 내인지 확인
func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

// 모든 상어를 이동시키는 함수
func moveSharks() {
    // 1. 상어를 한마리씩 이동시킨다.
    // 2. 좌표가 겹치는 상어가 있으면 밖으로 내보낸다.
    // 아이디어: 번호가 작은 상어를 순차적으로 먼저 이동시킨다. 이후 오는 상어가 해당 칸으로 이동한다면 밖으로 내보낸다.
    // 임시로 이동한 pos들 저장
    var posRecord: Set<Pos> = []
    for shark in sharks.dropFirst() { // 0 패딩 있으므로 건너뛰고 시작
        guard let pos = move(shark.number) else { continue } // 이미 죽은 상어의 경우 nil 값이 return됨

        // 이미 현재 상어보다 번호 작은 상어가 pos로 이동한 적이 있다는 의미
        guard !posRecord.contains(pos) else {
            sharkPos[shark.number] = nil // 밖으로 쫓아냄
            continue
        }

        posRecord.insert(pos)
        sharkPos[shark.number] = pos // 상어 위치 정보 업데이트
    }
}

// 상어가 이동할 위치를 구하는 함수
func move(_ sharkNum: Int) -> Pos? {
    // 이미 없어진 상어는 아닌지 확인
    guard let pos = sharkPos[sharkNum] else { return nil }

    let shark = sharks[sharkNum]
    let direction = shark.direction
    let priority = shark.priorities[direction.rawValue]
    let y = pos.y
    let x = pos.x

    // step1. 냄새가 없는 칸 찾기
    for i in 0..<4 {
        let nDir = priority[i]
        let ny = y + dy[nDir.rawValue]
        let nx = x + dx[nDir.rawValue]

        guard inRange(ny, nx) else { continue }

        // 냄새가 없는 칸 있으면 해당 칸 반환
        if spaces[ny][nx].number == 0 {
            // 상어의 방향 업데이트
            sharks[sharkNum].direction = nDir
            return Pos(ny, nx)
        }
    }

    // step2. 자신의 냄새 있는 칸 찾기
    for i in 0..<4 {
        let nDir = priority[i]
        let ny = y + dy[nDir.rawValue]
        let nx = x + dx[nDir.rawValue]

        guard inRange(ny, nx) else { continue }

        if spaces[ny][nx].number == sharkNum {
            sharks[sharkNum].direction = nDir
            return Pos(ny, nx)
        }
    }

    return nil // 이 경우는 절대 나올 수 없음. 이전에 내가 이동했던 칸이 무조건 있기 때문
}

// MARK: - 냄새 뿌리기 / 감소시키기

// 각 칸에 냄새를 뿌린다.
func spreadSmell() {
    for (shark, pos) in sharkPos {
        spaces[pos.y][pos.x].number = shark
        spaces[pos.y][pos.x].smellCount = smellCount
    }
}

func decreaseSmell() {
    for y in 0..<size {
        for x in 0..<size {
            guard spaces[y][x].smellCount > 0 else { continue }
            spaces[y][x].smellCount -= 1
            if spaces[y][x].smellCount == 0 {
                spaces[y][x].number = 0
            }
        }
    }
}

// MARK: - 최종 풀이 함수
func solution() {
    var res = 1
    // 입력 받기
    inputBoards()
    inputSharks()

    while res <= 1000 {
        // 상어를 이동한다.
        moveSharks()

        // 냄새를 감소시킨다.
        decreaseSmell()

        // 냄새를 퍼뜨린다.
        spreadSmell()

        // 종료 조건
        if sharkPos.count == 1 { break }

        res += 1
    }

    if res <= 1000 {
        print(res)
    } else {
        print(-1)
    }

}

solution()
