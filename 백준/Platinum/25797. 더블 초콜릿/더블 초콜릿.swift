import Foundation

enum Color: Int {
    case white
    case black
}

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
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

struct Pos: Hashable {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

// MARK: - 변수 및 상수, 입력
let size = Int(readLine()!)!

// 색상 정보
var colorInfo: [[Color]] = []
for _ in 0..<size {
    let line = readLine()!
        .split(separator: " ")
        .map { Color(rawValue: Int(String($0))!)! }
    colorInfo.append(line)
}

// 특정 영역의 칸 수 정보 입력
var requiredSizeCount = Int(readLine()!)!
var requiredPosInfo: [(Pos, Int)] = []
var requiredSizeInfo: [Int: Int] = [:] // 각 area에 대해 만족해야하는 칸 수가 있는지 저장
for _ in 0..<requiredSizeCount {
    let line = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    let pos = Pos(line[0] - 1, line[1] - 1)
    requiredPosInfo.append((pos, line[2]))
}

// 벽 정보 입력 받기. (y, x) 칸에 대하여 상하좌우로 벽 정보 저장
var walls: [[[Bool]]] = Array(
    repeating: Array(
        repeating: Array(repeating: false, count: 4),
        count: size),
    count: size)
let inputSize = size * 2 + 1
for i in 0..<inputSize { // 가로 세로 모두 총 size * 2 + 1 만큼의 입력이 들어온다.
    let line = readLine()!.map { String($0) }

    guard
        i > 0, // 가장 윗 줄 입력과
        i < inputSize - 1 // 가장 아랫줄 입력은 필요 없어서 버림 (어차피 inRange() 함수에서 걸림)
    else { continue }

    for j in 1..<inputSize - 1 { // 마찬가지로 가장 첫 열, 마지막 열 입력 버린다.
        let y = i / 2
        let x = j / 2

        guard line[j] != "+" else { continue } // 꼭짓점에 대한 정보 필요 없음

        if i % 2 == 0 { // i가 짝수면 상,하 벽 정보
            guard line[j] == "-" else { continue }
            walls[y][x][Direction.up.rawValue] = true // 해당 칸의 윗 쪽에 벽이 있는 것이다.

            guard y - 1 >= 0 else { continue }
            walls[y - 1][x][Direction.down.rawValue] = true // 따라서 해당 칸의 윗 칸의 아랫쪽에도 벽이 있는 것이다.
        } else { // i가 홀수면 좌, 우 벽 정보
            guard line[j] == "|" else { continue }
            walls[y][x][Direction.left.rawValue] = true // 해당 칸의 왼쪽에 벽이 있는 것이다.

            guard x - 1 >= 0 else { continue }
            walls[y][x - 1][Direction.right.rawValue] = true // 따라서 해당 칸의 왼쪽 칸의 오른쪽에도 벽이 있다.
        }
    }
}

// 영역 정보를 담을 배열. (y, x)로 접근하면 해당 영역의 번호를 알 수 있다.
var areaInfo: [[Int]] = Array(
    repeating: Array(repeating: 0, count: size),
    count: size)
var areaSizes: [Int: Int] = [:] // 각 영역의 크기를 알 수 있는 딕셔너리
var areaStarts: [Int: Pos] = [:] // 각 영역의 시작점

// 상하좌우 이동 위한 배열
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

// MARK: - 풀이

// step 1. 각 칸이 어느 영역인지 체크한다.
func assignArea() {
    var areaNumber = 0

    for y in 0..<size {
        for x in 0..<size {
            guard areaInfo[y][x] == 0 else { continue } // 아직 영역 정보 부여받지 못한 것들만 확인
            areaNumber += 1
            let startPos = Pos(y, x)
            areaStarts[areaNumber] = startPos // 영역의 시작점을 입력
            let areaSize = assignAreaBFS(startPos, areaNumber) // 이어진 칸들에 대해 같은 영역 번호를 부여
            areaSizes[areaNumber] = areaSize // 영역 크기 정보 저장
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

func assignAreaBFS(_ start: Pos, _ areaNumber: Int) -> Int {
    var queue = Queue<Pos>()
    var areaSize = 0 // 영역의 크기
    queue.push(start)
    areaInfo[start.y][start.x] = areaNumber

    while let pos = queue.pop() {
        let y = pos.y
        let x = pos.x
        areaSize += 1

        for dir in Direction.allCases {
            let ny = y + dy[dir.rawValue]
            let nx = x + dx[dir.rawValue]

            guard
                inRange(ny, nx),
                !walls[y][x][dir.rawValue], // 이동하려는 쪽에 벽 없어야 함
                areaInfo[ny][nx] == 0 // 영역 번호 부여받은 곳이면 안됨
            else { continue }

            areaInfo[ny][nx] = areaNumber
            queue.push(Pos(ny, nx))
        }
    }
    return areaSize
}

// step 2. 필수 칸 수가 있는 영역을 체크한다.
func checkRequiredAreaSizes() -> Bool {
    for (pos, requiredSize) in requiredPosInfo {
        let areaNumber = areaInfo[pos.y][pos.x]

        guard requiredSizeInfo[areaNumber] == nil else { return false } // 이미 해당 영역에 필수 사이즈가 저장되어 있으면 안됨
        requiredSizeInfo[areaNumber] = requiredSize
    }
    return true
}

// step 3. 각 영역에 대하여 더블 초콜릿을 만족하는지 확인한다.
func checkIsDoubleChocolate(_ areaNumber: Int) -> Bool {
    // 영역 내에 불필요한 경계선 없는지 확인
    guard !hasUnnecessaryWall(areaNumber) else { return false }

    // 영역의 두 색상 영역들을 추출한다.
    var (positions1, positions2) = fetchColorsOfArea(areaNumber)

    // step2에서 영역에 필수 칸 수 수가 두 개 이상 나오는거 체크 했음. 여기서 안해도 됨

    // 두 영역의 크기가 같고, 각 영역 칸 수의 합이 전체 영역 칸 수와 같아야 함
    guard
        !positions1.isEmpty && !positions2.isEmpty,
        positions1.count == positions2.count,
        positions1.count + positions2.count == areaSizes[areaNumber, default: 0]
    else { return false }

    // 만약 필수 칸 수가 있다면, 두 영역 모두 해당 칸 수를 만족하는지 확인
    if let requiredSize = requiredSizeInfo[areaNumber] {
        guard
            positions1.count == requiredSize,
            positions2.count == requiredSize
        else { return false }
    }

    // 각 영역의 origin을 (0, 0)으로 변환한다.
    positions1 = sortToZero(positions1)
    positions2 = sortToZero(positions2)

    // 회전, 뒤집고 회전해서 같은 모양이 나오는지 확인
    return isSameShape(positions1, positions2)
}

// step 3-0 불필요한 경계가 있는지 확인한다.
func hasUnnecessaryWall(_ areaNumber: Int) -> Bool {
    guard let start = areaStarts[areaNumber] else { return true }
    var queue = Queue<Pos>()
    var visited = Array(
        repeating: Array(repeating: false, count: size),
        count: size)
    queue.push(start)
    visited[start.y][start.x] = true

    while let pos = queue.pop() {
        let y = pos.y
        let x = pos.x

        for dir in Direction.allCases {
            let ny = y + dy[dir.rawValue]
            let nx = x + dx[dir.rawValue]
            guard
                inRange(ny, nx),
                areaInfo[ny][nx] == areaNumber
            else { continue }

            // 네 방향에 대해 같은 영역이라면, 벽이 없는지 확인
            guard !walls[y][x][dir.rawValue] else { return true }
            // 방문한 적 없다면, 큐에 넣음
            guard !visited[ny][nx] else { continue }
            visited[ny][nx] = true
            queue.push(Pos(ny, nx))
        }
    }

    return false
}

// step 3-1. 특정 영역의 흰칸 집합, 검은칸 집합을 반환한다.
func fetchColorsOfArea(_ areaNumber: Int) -> (position1: Set<Pos>, positions2: Set<Pos>) {
    guard let start = areaStarts[areaNumber] else { return ([], []) }
    let startColor = colorInfo[start.y][start.x]
    var queue = Queue<Pos>()
    var otherColorStart: Pos? = nil // 시작한 색과 다른 색이 처음 나오는 좌표
    var visited = Array(
        repeating: Array(repeating: false, count: size),
        count: size)
    var positions1 = Set<Pos>()
    var positions2 = Set<Pos>()

    visited[start.y][start.x] = true
    queue.push(start)

    // 첫번째 색에 대해 좌표들을 뽑는다.
    while let pos = queue.pop() {
        let y = pos.y
        let x = pos.x
        positions1.insert(pos)

        for dir in Direction.allCases {
            let ny = y + dy[dir.rawValue]
            let nx = x + dx[dir.rawValue]

            guard
                inRange(ny, nx),
                !visited[ny][nx],
                areaInfo[ny][nx] == areaNumber,
                !walls[y][x][dir.rawValue]
            else { continue }

            // 색이 다른 좌표가 처음 나왔다면, 기록하고 일단 넘어감
            if colorInfo[ny][nx] != startColor {
                if otherColorStart == nil { otherColorStart = Pos(ny, nx) }
                continue
            }

            visited[ny][nx] = true
            queue.push(Pos(ny, nx))
        }
    }

    // 두번째 색 좌표들 뽑는다.
    guard let secondStart = otherColorStart else { return (positions1, positions2) }

    visited[secondStart.y][secondStart.x] = true
    queue.push(secondStart)

    while let pos = queue.pop() {
        let y = pos.y
        let x = pos.x
        positions2.insert(pos)

        for dir in Direction.allCases {
            let ny = y + dy[dir.rawValue]
            let nx = x + dx[dir.rawValue]

            guard
                inRange(ny, nx),
                areaInfo[ny][nx] == areaNumber,
                !walls[y][x][dir.rawValue],
                !visited[ny][nx],
                colorInfo[ny][nx] != startColor // 처음 시작한 색과 다른 색만 나와야 함
            else { continue }

            visited[ny][nx] = true
            queue.push(Pos(ny, nx))
        }
    }

    return (positions1, positions2)
}

// step 3-2. 두 좌표 집합이 같은 모양인지 확인한다.
func isSameShape(_ positions1: Set<Pos>, _ positions2: Set<Pos>) -> Bool {
    var positions2 = positions2
    var height = positions2.max(by: { $0.y < $1.y })!.y + 1
    var width = positions2.max(by: {$0.x < $1.x })!.x + 1

    // 같은지 비교
    if positions1 == positions2 { return true }

    // positions2을 90도, 180도, 270도 회전 후 비교
    for _ in 0..<3 {
        positions2 = rotate(positions2, height) // position2를 회전
        positions2 = sortToZero(positions2) // 회전 결과를 (0, 0)을 origin으로 하여 정렬
        swap(&height, &width) // 회전했으니까 가로 세로 길이 스왚

        if positions1 == positions2 { return true } // 회전 결과가 같다면 true 리턴
    }

    positions2 = flip(positions2, width) // y축 기준 뒤집기
    positions2 = sortToZero(positions2) // flip 결과를 (0, 0)을 origin으로 하여 정렬
    if positions1 == positions2 { return true }
    // 뒤집은 positions2을 90, 180, 270도에 대해 같은 모양인지 확인
    for _ in 0..<3 {
        positions2 = rotate(positions2, height) // position2를 회전
        positions2 = sortToZero(positions2) // 회전 결과를 (0, 0)을 origin으로 하여 정렬
        swap(&height, &width) // 회전했으니까 가로 세로 길이 스왚

        if positions1 == positions2 { return true } // 회전 결과가 같다면 true 리턴
    }

    return false // 모든 조건 만족 불가능한 경우
}

// MARK: 좌표를 정렬, 회전, 뒤집는 함수
func sortToZero(_ positions: Set<Pos>) -> Set<Pos> {
    let minY = positions.min(by: {$0.y < $1.y })!.y
    let minX = positions.min(by: {$0.x < $1.x })!.x

    let sortedPositions = positions.map {
        Pos($0.y - minY, $0.x - minX)
    }

    return Set(sortedPositions)
}

// 90도 회전 하는 함수. 반드시 origin이 (0, 0)인 것들만 넣는다.
// y좌표는 기존의 x좌표이다.
// x좌표는 기존의 높이 - y좌표 - 1이다.
func rotate(
    _ positions: Set<Pos>,
    _ height: Int
) -> Set<Pos> {
    var res: Set<Pos> = []

    for pos in positions {
        let ny = pos.x
        let nx = height - pos.y - 1
        res.insert(Pos(ny, nx))
    }

    return res
}

// 가로로 뒤집는 함수 반드시 origin이 (0, 0)인 것들만 넣는다.
// y좌표는 그대로 유지
// x좌표는 너비 - 기존 x좌표 - 1
func flip(
    _ positions: Set<Pos>,
    _ width: Int
) -> Set<Pos> {
    var res: Set<Pos> = []

    for pos in positions {
        let nx = width - pos.x - 1
        res.insert(Pos(pos.y, nx))
    }

    return res
}

// MARK: - 최종 풀이 함수
func solution() {
    // 영역 부여
    assignArea()

    // 필수 칸 수 체크. 한 영역에 중복된 필 수 칸 수 있으면 종료
    guard checkRequiredAreaSizes() else {
        print(0)
        return
    }

    for areaNumber in areaSizes.keys {
        guard checkIsDoubleChocolate(areaNumber) else {
            print(0)
            return
        }
    }

    print(1)
}

solution()
