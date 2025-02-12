import Foundation

// 상어는 가장 가까운 물고기를 먹는다.
// 가장 가까운 물고기가 여러마리면, 가장 왼쪽, 가장 위쪽에 있는 물고기를 먹는다
// 자기보다 큰 물고기는 먹을 수 없다.
// 처음 아기 상어의 크기는 2이다. 아기 상어는 자신의 크기만큼 물고기를 먹으면 크기가 1 증가한다.
// 더 이상 먹을 수 있는 물고기가 없으면 엄마 상어를 부른다.

struct Pos: Comparable {
    let y: Int
    let x : Int
    let time: Int

    init(_ y: Int, _ x: Int, _ time: Int) {
        self.y = y
        self.x = x
        self.time = time
    }

    static func < (_ lhs: Pos, _ rhs: Pos) -> Bool {
        if lhs.y != rhs.y {
            return lhs.y < rhs.y
        }
        return lhs.x < rhs.x
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

let n = Int(readLine()!)!
// 위쪽, 왼쪽 순서로 우선순위 높음
let dy = [-1, 0, 0, 1]
let dx = [0, -1, 1, 0]
var boards: [[Int]] = []
var visited = Array(
    repeating: Array(repeating: false, count : n),
    count: n)
var sharkPos: Pos = Pos(0, 0, 0)
var eatCount = 0
var sharkSize = 2
var totalTime = 0

// 입력 받기
for i in 0..<n {
    let line = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }

    boards.append(line)
    if let firstIndex = line.firstIndex(where : { $0 == 9 }) {
        sharkPos = Pos(i, firstIndex, 0)
        boards[i][firstIndex] = 0
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < n && 0 <= x && x < n
}

// 먹는데 성공하면 이동한 위치 return
func bfs(_ start: Pos) -> Pos? {
    var queue = Queue<Pos>()
    queue.push(start)
    for i in 0..<n {
        for j in 0..<n {
            visited[i][j] = false
        }
    }
    visited[start.y][start.x] = true

    var targetPos: Pos? = nil

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return targetPos }

        let y = pos.y
        let x = pos.x
        let time = pos.time

        if
            let targetPos = targetPos,
            targetPos.time < time
        { return targetPos }

        if
            boards[y][x] > 0,
            boards[y][x] < sharkSize
        { targetPos = min(targetPos ?? pos, pos) }

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                !visited[ny][nx],
                boards[ny][nx] <= sharkSize
            else { continue }

            visited[ny][nx] = true
            queue.push(Pos(ny, nx, time + 1))
        }
    }

    return targetPos
}

while let movedPos = bfs(sharkPos) {
    totalTime += movedPos.time
    eatCount += 1

    if eatCount == sharkSize {
        sharkSize += 1
        eatCount = 0
    }

    boards[movedPos.y][movedPos.x] = 0
    sharkPos = Pos(movedPos.y, movedPos.x, 0)
}

print(totalTime)
