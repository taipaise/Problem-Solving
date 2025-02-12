import Foundation
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

        if head > 50 {
            queue.removeFirst(head)
            head = 0
        }

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
let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let maxY = numbers[0]
let maxX = numbers[1]

var boards: [[String]] = []
// 불이 난 시간
var fireTimes: [[Int]] = Array(
    repeating: Array(repeating: Int.max, count: maxX),
    count: maxY)
// 지훈이가 방문했는지 체크
var visited = Array(
    repeating: Array(repeating: false, count: maxX),
    count: maxY)
var fires: [Pos] = []
var jihoon: Pos = Pos(y: 0, x: 0, time: 0)

// step1. 입력 받기
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

// bfs 준비 함수: 입력한 위치가 유효한 범위 내인지 확인하는 함수
func inRange(_ y : Int, _ x: Int) -> Bool {
    return (0 <= y && y < maxY) && (0 <= x && x < maxX)
}

// 불 지르는 함수
func spreadFire(_ starts: [Pos]) {
    var queue = Queue<Pos>()

    // 초기에 불이 난 지역을 큐에 넣음
    for start in starts {
        queue.push(start)
        fireTimes[start.y][start.x] = 0
    }

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return }

        let y = pos.y
        let x = pos.x
        let time = pos.time

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                boards[ny][nx] != "#",
                fireTimes[ny][nx] > time + 1
            else { continue }
            fireTimes[ny][nx] = time + 1
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
                fireTimes[ny][nx] > time + 1
            else { continue }

            visited[ny][nx] = true
            queue.push(Pos(y: ny, x: nx, time: time + 1))
        }
    }
    return nil
}

input()
spreadFire(fires)
let time = escape(jihoon)

if let time = time {
    print(time)
} else {
    print("IMPOSSIBLE")
}

