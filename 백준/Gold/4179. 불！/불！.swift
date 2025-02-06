import Foundation
// 아이디어
// 탈출할 수 있는지 확인한다. 가장자리에 있다면 탈출 성공
// 시간을 증가시킨다.
// 지훈이가 먼저 이동
// 불을 확산시킨다.

// 불을 먼저 쭉 지른다 (불이 난 시간 기록)
// 지훈이가 이동한다. 불이 난 시간이 이동할 시간보다 이후라면 이동할 수 있다
// 가장자리까지 이동할 수 있는 최소 시간을 구한다

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    var isEmpty: Bool {
        return head >= queue.count
    }

    mutating func push(_ e: T) {
        queue.append(e)
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
    let time: Int
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let maxY = numbers.first!
let maxX = numbers.last!

// 불이 난 시간을 기록
var fireMap: [[Int]] = Array(
    repeating: Array(repeating: Int.max, count: maxX),
    count: maxY)
// 처음 지도 상태
var boards: [[String]] = []
var fires: [Pos] = []
var jihoon: Pos = Pos(y: 0, x: 0, time: 0)
var visited: [[Bool]] = []

func input() {
    for y in 0..<maxY {
        let line = readLine()!.map { String($0) }
        boards.append(line)

        for x in 0..<maxX {
            if line[x] == "J" {
                jihoon = Pos(y: y, x: x, time: 0)
            } else if line[x] == "F" {
                fires.append(Pos(y: y, x: x, time: 0))
            }
        }
    }
}

func initVisited() {
    visited = Array(
        repeating: Array(repeating: false, count: maxX),
        count: maxY)
}

func inRange(_ y : Int, _ x: Int) -> Bool {
    return 0 <= y && y < maxY && 0 <= x && x < maxX
}

// 시작지점들로부터 불을 퍼뜨림
func spreadFire(_ starts: [Pos]) {
    var queue = Queue<Pos>()
    for start in starts {
        queue.push(start)
        visited[start.y][start.x] = true
    }

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return }

        let y = pos.y
        let x = pos.x
        let time = pos.time
        fireMap[y][x] = time

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                !visited[ny][nx],
                boards[ny][nx] != "#"
            else { continue }

            visited[ny][nx] = true
            queue.push(Pos(y: ny, x: nx, time: time + 1))
        }
    }
}

// 탈출 가능한지 return
func escape(_ start: Pos) -> Int? {
    var queue = Queue<Pos>()
    queue.push(start)
    visited[start.y][start.x] = true

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return nil } // 탈출 실패

        let y = pos.y
        let x = pos.x
        let time = pos.time

        // 가장자리에 도착했는지 확인
        if
            y == 0 || y == maxY - 1 ||
            x == 0 || x == maxX - 1
        {
            return time + 1
        }

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                !visited[ny][nx],
                boards[ny][nx] != "#",
                fireMap[ny][nx] > time + 1
            else { continue }

            visited[ny][nx] = true
            queue.push(Pos(y: ny, x: nx, time: time + 1))
        }
    }
    return nil
}

input()

initVisited()
spreadFire(fires)

initVisited()

let time = escape(jihoon)

if let time = time {
    print(time)
} else {
    print("IMPOSSIBLE")
}

