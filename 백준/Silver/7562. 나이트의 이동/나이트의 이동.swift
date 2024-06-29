struct Point {
    let y: Int
    let x: Int
    let count: Int
}

let tc = Int(readLine()!)!
var size = 0
var start = Point(y: 0, x: 0, count: 0)
var end = Point(y: 0, x: 0, count: 0)
var board: [[Bool]] = []
let dy = [-2, -1, 1, 2, 2, 1, -1, -2]
let dx = [1, 2, 2, 1, -1, -2, -2, -1]

func input() {
    size = Int(readLine()!)!
    let s = readLine()!.split(separator: " ").map { Int($0)! }
    let e = readLine()!.split(separator: " ").map { Int($0)! }
    start = .init(y: s[0], x: s[1], count: 0)
    end = .init(y: e[0], x: e[1], count: 0)
    board = Array(repeating: Array(repeating: false, count: size), count: size)
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return (0 <= y && y < size) && (0 <= x && x < size)
}

func bfs(_ start: Point) -> Int {
    var q = Queue<Point>()
    q.push(start)
    board[start.y][start.x] = true
    
    while !q.isEmpty {
        guard let point = q.pop() else { return -1 }
        let y = point.y
        let x = point.x
        let count = point.count
        
        if
            end.y == y,
            end.x == x
        { return count }
        
        for dir in 0..<8 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]
            
            guard
                inRange(ny, nx),
                !board[ny][nx]
            else { continue }
            
            board[ny][nx] = true
            q.push(.init(y: ny, x: nx, count: count + 1))
        }
    }
    
    return -1
}

for _ in 0..<tc {
    input()
    print(bfs(start))
}

struct Queue<T> {
    private var inQ: [T] = []
    private var outQ: [T] = []
    
    public var count: Int {
        return inQ.count + outQ.count
    }
    
    public var isEmpty: Bool {
        return inQ.isEmpty  && outQ.isEmpty
    }
    
    public mutating func push(_ element: T) {
        inQ.append(element)
    }
    
    public mutating func pop() -> T? {
        if outQ.isEmpty {
            outQ = inQ.reversed()
            inQ.removeAll()
        }
        return outQ.popLast()
    }
}
