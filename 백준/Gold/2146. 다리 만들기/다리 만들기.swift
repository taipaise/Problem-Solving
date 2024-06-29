struct Point {
    let y: Int
    let x: Int
    let count: Int
    
    init(y: Int, x: Int) {
        self.y = y
        self.x = x
        count = 0
    }
    
    init(y: Int, x: Int, count: Int) {
        self.y = y
        self.x = x
        self.count = count
    }
}

struct Island {
    var number: Int
    var isBoarder: Bool
    
    init() {
        number = -1
        isBoarder = false
    }
    
    init(_ number: Int, _ isBoarder: Bool) {
        self.number = number
        self.isBoarder = isBoarder
    }
}

let size = Int(readLine()!)!
var board: [[Island]] = Array(repeating: [], count: size)
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var res = Int.max

func inRange(_ y: Int, _ x: Int) -> Bool {
    return (0 <= y && y < size) && (0 <= x && x < size)
}

func input() {
    for i in 0..<size {
        let row: [Island] = readLine()!.split(separator: " ").map {
            let number = Int(String($0))!
            if number == 1 {
                return .init(0, false)
            } else {
                return .init()
            }
        }
        board[i] = row
    }
}

func isEdge(_ point: Point) -> Bool {
    let y = point.y
    let x = point.x
    
    for dir in 0..<4 {
        let ny = y + dy[dir]
        let nx = x + dx[dir]
        
        guard inRange(ny, nx) else { continue }
        
        if board[ny][nx].number == -1 { return true }
    }
    return false
}

func islandNumberBfs(_ start: Point, _ number: Int) {
    var visited = Array(repeating: Array(repeating: false, count: size), count: size)
    var q = Queue<Point>()
    q.push(start)
    visited[start.y][start.x] = true
    
    while !q.isEmpty {
        guard let point = q.pop() else { return }
        let y = point.y
        let x = point.x
        board[y][x].number = number
        
        if isEdge(point) { board[y][x].isBoarder = true }
        
        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]
            
            guard
                inRange(ny, nx),
                !visited[ny][nx],
                board[ny][nx].number != -1
            else { continue }
            
            visited[ny][nx] = true
            q.push(.init(y: ny, x: nx))
        }
    }
}

func bridgeBfs(_ start: Point, _ number: Int) {
    var visited = Array(repeating: Array(repeating: false, count: size), count: size)
    var q = Queue<Point>()
    q.push(start)
    visited[start.y][start.x] = true
    
    while !q.isEmpty {
        guard let point = q.pop() else { return }
        let y = point.y
        let x = point.x
        let count = point.count
        let curNumber = board[y][x].number
        let isValid = curNumber != -1
        
        if
            isValid,
            number != curNumber
        {
            res = min(res, count - 1)
            return
        }
        
        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]
            
            guard
                inRange(ny, nx),
                !visited[ny][nx]
            else { continue }
            
            visited[ny][nx] = true
            q.push(.init(y: ny, x: nx, count: count + 1))
        }
    }
}

func setIslandNumber() {
    var index = 1
    for i in 0..<size {
        for j in 0..<size {
            if board[i][j].number == 0 {
                islandNumberBfs(.init(y: i, x: j), index)
                index += 1
            }
        }
    }
}

func findBridge() {
    for i in 0..<size {
        for j in 0..<size {
            guard board[i][j].isBoarder else { continue }
            bridgeBfs(.init(y: i, x: j), board[i][j].number)
        }
    }
}

input()
setIslandNumber()
findBridge()
print(res)

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
