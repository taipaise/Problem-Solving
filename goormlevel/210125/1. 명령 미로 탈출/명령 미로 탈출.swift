enum PointInfo: Int {
    case empty
    case start
    case end
    case wall
}

enum Direction: String {
    case U
    case D
    case L
    case R
    
    var index: Int {
        switch self {
        case .U:
            return 0
        case .D:
            return 1
        case .L:
            return 2
        case .R:
            return 3
        }
    }
}
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0]
let k = nk[1]
var player = (0, 0)
var moveCnt = 0
var isSuccess = false
let commands = readLine()!.map { String($0) }
var board: [[Int]] = Array(repeating: [], count: n)


func inRange(_ y: Int, _ x: Int) -> Bool {
    return (0 <= y && y < n) && (0 <= x && x < n)
}

for i in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    board[i] = row
    for j in 0..<n {
        if board[i][j] == PointInfo.start.rawValue {
          player.0 = i
					player.1 = j
        }
    }
}


for command in commands {
	let direction = Direction(rawValue: command)!.index	
	let ny = player.0 + dy[direction]
	let nx = player.1 + dx[direction]
	
	guard
		inRange(ny, nx),
		board[ny][nx] != PointInfo.wall.rawValue
	else { continue }
	moveCnt += 1
	guard board[ny][nx] != PointInfo.end.rawValue else {
		isSuccess = true
		break
	}
	
	player.0 = ny
	player.1 = nx
}

if isSuccess {
	print("SUCCESS", moveCnt)
} else {
	print("FAIL")	
}
