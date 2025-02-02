import Foundation

struct Pos: Hashable {
    let y: Int
    let x: Int
}

var timeTrace: [Int: [Pos: Int]] = [:]

func move(_ start: Pos, _ dest: Pos, _ startTime: Int) -> Int {
    var curPos = start
    var curTime = startTime
    
    // r를 변경
    while curPos.y != dest.y {
        curTime += 1
        var posCount = timeTrace[curTime, default: [:]]
        posCount[curPos, default: 0] += 1
        timeTrace[curTime] = posCount
        
        let ny = curPos.y < dest.y ? curPos.y + 1 : curPos.y - 1
        curPos = Pos(y: ny, x: curPos.x)
    }
    
    // c를 변경
    while curPos.x != dest.x {
        curTime += 1
        var posCount = timeTrace[curTime, default: [:]]
        posCount[curPos, default: 0] += 1
        timeTrace[curTime] = posCount
        
        let nx = curPos.x < dest.x ? curPos.x + 1 : curPos.x - 1
        curPos = Pos(y: curPos.y, x: nx)
    }
    
    return curTime
}

func makeTrace(_ points: [Pos]) {
    var prevPoint = points.first!
    var moveTime = 0
    
    for nextPoint in points.dropFirst() {
        moveTime = move(prevPoint, nextPoint, moveTime)
        prevPoint = nextPoint
    }
    
    var posCount = timeTrace[moveTime + 1, default: [:]]
    posCount[prevPoint, default: 0] += 1
    timeTrace[moveTime + 1] = posCount
}

func checkCollision() -> Int {
    var result = 0

    for (_, record) in timeTrace {
        for (_, count) in record {
            if count > 1 {
                result += 1
            }
        }
    }
    
    return result
}

func solution(_ points:[[Int]], _ routes:[[Int]]) -> Int {
    for route in routes {        
        let movePoints: [Pos] = route.map {
            let index = $0 - 1
            let pos = Pos(y: points[index][0], x: points[index][1])
            return pos
        }
        makeTrace(movePoints)
    }
    
    return checkCollision()
}