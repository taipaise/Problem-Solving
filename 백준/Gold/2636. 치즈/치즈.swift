import Foundation

struct Pos {
    let y: Int
    let x: Int
}

struct Queue {
    private var queue: [Pos] = []
    private var head = 0
    var isEmpty: Bool {
        return head >= queue.count
    }

    mutating func push(_ e: Pos) {
        queue.append(e)
    }

    mutating func pop() -> Pos? {
        guard head < queue.count else { return nil }

        if head > 50 {
            queue.removeFirst(head)
            head = 0
        }

        defer { head += 1 }
        return queue[head]
    }

}

let constants = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let maxY = constants.first!
let maxX = constants.last!
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var cheezeCount = 0
var time = 0

//공기는 0, 곧 녹을건 1, 안 녹는 치즈 2
var boards: [[Int]] = []

var visited: [[Bool]] = []
var meltTime = 0

func input() {
    for _ in 0..<maxY {
        let line = readLine()!
            .split(separator: " ")
            .map { Int(String($0))! == 1 ? 2 : 0 } // 안 녹는 치즈는 2
        boards.append(line)
    }
}

func initVisited() {
    visited = Array(
        repeating: Array(repeating: false, count: maxX),
        count: maxY)
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < maxY && 0 <= x && x < maxX
}

func bfs() -> Int { // 다음에 녹일 치즈 갯수
    var result = 0
    var queue = Queue()
    queue.push(Pos(y: 0, x: 0))
    visited[0][0] = true

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return result }

        let y = pos.y
        let x = pos.x

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                visited[ny][nx] == false
            else { continue }
            visited[ny][nx] = true

            if boards[ny][nx] == 2 { // 치즈를 만났으면 다음에 녹여야 함
                boards[ny][nx] = 1
                result += 1
            } else if boards[ny][nx] == 0 { // 외부 공기일 때만 탐색 수행
                let newPos = Pos(y: ny, x: nx)
                queue.push(newPos)
            }
        }
    }

    return result
}

func melt() -> Int { // 다음에 녹일 치즈 갯수
    // 이번 시간에 녹아야 하는 치즈 녹이기
    for y in 0..<maxY {
        for x in 0..<maxX {
            if boards[y][x] == 1 {
                boards[y][x] = 0
            }
        }
    }

    // 다음 시간에 녹아야 하는 치즈 표시 bfs
    initVisited()
    return bfs()
}

func solve() {
    while true {
//        printBoards()
        time += 1
        let cheezeToMelt = melt()

        if cheezeToMelt == 0 { break }

        cheezeCount = cheezeToMelt
    }

    print(time - 1, cheezeCount, separator: "\n")
}
//
//func printBoards() {
//    print("#######")
//
//    for line in boards {
//        print(line)
//    }
//    print("#######")
//
//}
input()
solve()
