struct Info {
    let str: String
    var isBreaked: Bool
    
    init() {
        str = "."
        isBreaked = false
    }
    
    init(_ str: String) {
        self.str = str
        isBreaked = false
    }
}

var b: [[Info]] = []
var maxX = 0
var maxY = 0
let dy = [0, 1, 1]
let dx = [1, 0, 1]
var res = 0

func inRange(_ y: Int, _ x: Int) -> Bool {
    return (0 <= y && y < maxY ) && (0 <= x && x < maxX)
}

func checkBreak(_ y: Int, _ x: Int) -> Bool {
    let curStr = b[y][x].str
    var flag = true
    
    for dir in 0..<3 {
        let ny = y + dy[dir]
        let nx = x + dx[dir]
        
        guard
            inRange(ny, nx),
            b[ny][nx].str == curStr
        else { 
            flag = false
            break
        }    
    }
    
    if flag {
        b[y][x].isBreaked = true
        
        for dir in 0..<3 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]
            
            b[ny][nx].isBreaked = true
        }
    }
    
    return flag
}

func removeBreaked() {
    for i in 0..<maxY {
        b[i] = b[i].filter { $0.isBreaked == false }
        let removedCount = maxX - b[i].count
        res += removedCount
        
        for j in 0..<removedCount {
            b[i].append(Info())    
        }
    }
}

func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
    maxY = n
    maxX = m
    b = Array(repeating: [], count: n)
    let temp = board.map { $0.map { String($0) } }
    
    for i in 0..<n {
        for j in 0..<m {
            b[i].append(Info(temp[j][i]))
        }
    }
    
    for i in 0..<n {
        b[i] = Array(b[i].reversed())
    }
    
    var flag = true
    while flag {
        flag = false
        
        for i in 0..<maxY {
            for j in 0..<maxX {
                if b[i][j].str == "." { continue }
                if checkBreak(i, j) { flag = true }
            }
        }
        
        removeBreaked()
    }
    
    return res
}