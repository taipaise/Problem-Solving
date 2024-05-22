import Foundation
struct Point {
    let y: Int
    let x: Int
    let count: Int
}

let dy: [Int] = [1, -1, 0, 0]
let dx: [Int] = [0, 0, 1, -1]
var maxY = 0
var maxX = 0
var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: 100), count: 100)
var boardMap: [[String]] = []
var endPoint = Point(y: 0, x: 0, count: 0)

func inRange(_ y: Int, _ x: Int) -> Bool {
    return (0 <= y && y < maxY) && (0 <= x && x < maxX)
}

func bfs(_ start: Point) -> Int {
    var q = Deque<Point>()
    visited[start.y][start.x] = true
    q.pushLast(start)
    
    while(!q.isEmpty) {
        guard let point = q.popFirst() else { break }
        let y = point.y
        let x = point.x
        let count = point.count
        
        if y == endPoint.y && x == endPoint.x { return count }
        
        for dir in 0..<4 {
            var ny = y + dy[dir]
            var nx = x + dx[dir]

            if !inRange(ny, nx) { continue }
            if boardMap[ny][nx] == "D" { continue }
            
            while true {
                ny += dy[dir]
                nx += dx[dir]

                if !inRange(ny, nx) || boardMap[ny][nx] == "D" { break }
            }

            ny -= dy[dir]
            nx -= dx[dir]
            if visited[ny][nx] { continue }

            let newPoint = Point(
                y: ny,
                x: nx,
                count: count + 1
            )
            q.pushLast(newPoint)
            visited[ny][nx] = true
        }
    }
    
    return -1
}

func solution(_ board:[String]) -> Int {
    let row = board.count
    let col = board[0].count
    maxY = row
    maxX = col
    var startPoint = Point(y: 0, x: 0, count: 0)
    boardMap = board.map {
        return $0.map { String($0) }
    }
    for i in 0..<row {
        for j in 0..<col {
            if boardMap[i][j] == "R" {
                startPoint = Point(y: i, x: j, count: 0)
            }
            
            if boardMap[i][j] == "G" {
                endPoint = Point(y: i, x: j, count: 0)
            }
        }
    }
   
    let result = bfs(startPoint)
    return result
}

struct Deque<T> {
   private var enqueue: [T]
   private var dequeue: [T] = []
   
   var count: Int {
       return enqueue.count + dequeue.count
   }
   
   var isEmpty: Bool {
       return enqueue.isEmpty && dequeue.isEmpty
   }
   
   var first: T? {
       if dequeue.isEmpty {
           return enqueue.first
       }
       return dequeue.last
   }
   
   init() {
       enqueue = []
   }
   
   mutating func pushFirst(_ item: T) {
       dequeue.append(item)
   }
   
   mutating func pushLast(_ item: T) {
       enqueue.append(item)
   }
   
   mutating func popFirst() -> T? {
       if dequeue.isEmpty {
           dequeue = enqueue.reversed()
           enqueue.removeAll()
       }
       return dequeue.popLast()
   }
   
   mutating func popLast() -> T? {
       if enqueue.isEmpty {
           enqueue = dequeue.reversed()
           dequeue.removeAll()
       }
       return enqueue.popLast()
   }
   
   mutating func removeAll() {
       enqueue.removeAll()
       dequeue.removeAll()
   }
}