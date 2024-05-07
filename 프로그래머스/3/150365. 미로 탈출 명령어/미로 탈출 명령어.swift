import Foundation
//알파벳 순서: d - l - r -u

struct Point {
    let y: Int
    let x: Int
    var route: String
    var count : Int
}

func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ r:Int, _ c:Int, _ k:Int) -> String {
    let dy = [1, 0, 0, -1]
    let dx = [0, -1, 1, 0]
    let direction = ["d", "l", "r", "u"]
    var visited: [[[Bool]]] = Array(repeating: Array(repeating: Array(repeating: false, count: k + 1), count: m + 1), count: n + 1)
    let maxY = n
    let maxX = m
    
    let startPoint = Point(y: x, x: y, route: "", count: 0)
    
    var q = Queue<Point>()
    q.append(startPoint)
    visited[startPoint.y][startPoint.x][0] = true
    
    while(!q.isEmpty) {
        let point = q.pop()!
        
        let y = point.y
        let x = point.x
        let route = point.route
        let count = point.count
    
        if 
            y == r,
            x == c,
            count == k
        {
            return route
        }

        
        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]
            
            guard (1 <= ny && ny <= maxY) && (1 <= nx && nx <= maxX) else { continue }
            if count >= k { continue }
            if visited[ny][nx][count + 1] { continue }
            
            visited[ny][nx][count + 1] = true
            let nextDir = direction[dir]
            let nr = route + nextDir
            let newPoint = Point(y: ny, x: nx, route: nr, count: count + 1)
            q.append(newPoint)
        }
    }
    
    return "impossible"
}

class Queue<T> {
    private var left: [T] = []
    private var right: [T] = []

    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }

    func append(_ data: T) {
        right.append(data)
    } 

    func pop() -> T? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}