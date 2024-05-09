import Foundation

//s: 방향 유지, R: 방향 + 1, L: 방향 -1
let dy = [1, 0, -1, 0]
let dx = [0, -1, 0, 1]

struct Point {
    let y: Int
    let x: Int
    let dir: Int
    let moveCount: Int
}

func solution(_ grid:[String]) -> [Int] {
    var res: [Int] = []
    let maxY = grid.count
    let maxX = grid[0].count
    
    var visited = Array(
                repeating: Array(
                            repeating: Array(
                                            repeating: false,
                                             count: 4),
                            count: maxX),
                count: maxY)
        
    for y in 0..<maxY {
        for x in 0..<maxX {
            for dir in 0..<4 {
                if visited[y][x][dir] { continue }
                var count = 0
                var ny = y
                var nx = x
                var nd = dir
                
                while visited[ny][nx][nd] == false {
                    visited[ny][nx][nd] = true
                    let row = grid[ny]
                    let index = row.index(row.startIndex, offsetBy: nx)
                    let directionString = row[index]
                    
                    switch directionString {
                    case "R":
                        nd = (nd + 1) % 4
                    case "L":
                        nd = (nd - 1) % 4
                        nd = nd < 0 ? 3 : nd
                    default:
                        break
                    }
                    
                    ny = ny + dy[nd]
                    nx = nx + dx[nd]
                    ny = ny < 0 ? maxY - 1 : ny
                    nx = nx < 0 ? maxX - 1 : nx
                    ny = ny % maxY
                    nx = nx % maxX
                    count += 1
                }
                res.append(count)
            }
        }
    }

    return res.sorted()
}