import Foundation

let inputs = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

var boards: [[String]] = []
var visited: [[Bool]] = []
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
let maxY = inputs[0]
let maxX = inputs[1]
let len =  inputs[2]
var res = 0

visited = Array(
    repeating: Array(repeating: false, count: maxX),
    count: maxY)

for _ in 0..<maxY {
    let line = readLine()!.map { String($0) }
    boards.append(line)
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < maxY && 0 <= x && x < maxX
}

func dfs(_ y: Int, _ x: Int, _ count: Int) {
    if
        y == 0,
        x == maxX - 1
    {
        if count == len { res += 1 }
        return
    }

    for dir in 0..<4 {
        let ny = y + dy[dir]
        let nx = x + dx[dir]
        guard
            inRange(ny, nx),
            !visited[ny][nx],
            boards[ny][nx] == "."
        else { continue }

        visited[ny][nx] = true
        dfs(ny, nx, count + 1)
        visited[ny][nx] = false
    }
}

visited[maxY - 1][0] = true
dfs(maxY - 1, 0, 1)

print(res)
