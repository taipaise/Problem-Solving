import Foundation

struct Queue<T> {
    private var queue: [T] = []
    private var head: Int = 0
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
    let dist: Int
}

let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[Int]] = []
var visited: [[Bool]] = []
var homes: [Pos] = []
var chickens: [Pos] = []
var selected: [Pos] = []
var n: Int = 0
var m: Int = 0
var result = Int.max

func input() {
    let numbers = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    n = numbers.first!
    m = numbers.last!

    for y in 0..<n {
        let line = readLine()!
            .split(separator: " ")
            .map { Int(String($0))! }
        boards.append(line)

        for (x, num) in line.enumerated() {
            if num == 2 {
                let chicken = Pos(y: y, x: x, dist: 0)
                boards[y][x] = 0
                chickens.append(chicken)
            } else if num == 1 {
                let home = Pos(y: y, x: x, dist: 0)
                homes.append(home)
            }
        }
    }
}

//func inRange(_ y: Int, _ x: Int) -> Bool {
//    return 0 <= y && y < n && 0 <= x && x < n
//}
//
//func initVisited() {
//    visited = Array(
//        repeating: Array(repeating: false, count: n),
//        count: n)
//}
//
//// 가장 가까운 치킨집 거리 찾기
//func bfs(_ start: Pos) -> Int? {
//    var queue = Queue<Pos>()
//    queue.push(start)
//    visited[start.y][start.x] = true
//
//    while !queue.isEmpty {
//        guard let pos = queue.pop() else { return nil }
//
//        let y = pos.y
//        let x = pos.x
//        let dist = pos.dist
//
//        if boards[y][x] == 2 {
//            return dist
//        }
//
//        for dir in 0..<4 {
//            let ny = y + dy[dir]
//            let nx = x + dx[dir]
//
//            guard
//                inRange(ny, nx),
//                !visited[ny][nx]
//            else { continue }
//
//            visited[ny][nx] = true
//
//            let newPos = Pos(y: ny, x: nx, dist: dist + 1)
//            queue.push(newPos)
//        }
//    }
//    return nil
//}

func getDist(_ pos1: Pos, _ pos2: Pos) -> Int {
    return abs(pos1.y - pos2.y) + abs(pos1.x - pos2.x)
}

func checkDist() -> Int {
    var totalDist = 0

    for home in homes {
        var minDist = Int.max
        for chicken in selected {
            minDist = min(minDist, getDist(home, chicken))
        }
        totalDist += minDist
    }

    return totalDist
}

// 재귀적으로 치킨집 m개 선택
func select(_ index: Int) {

    // 종료 조건
    if selected.count == m {
        let dist = checkDist()
        result = min(result, dist)
        return
    }

    for i in index..<chickens.count {
        let chicken = chickens[i]

        selected.append(chicken)
        boards[chicken.y][chicken.x] = 2

        select(i + 1)

        selected.removeLast()
        boards[chicken.y][chicken.x] = 0
    }
}

// 입력 받음
input()
select(0)
print(result)
