import Foundation

// 특정 칸에서 이동할 수 있는 최대 칸 수는 정해져 있다.
// 대나무 양이 큰 칸부터, 이동할 수 있는 최대 칸 수를 구한다면? -> 힙 구조를 이용해 가장 큰 칸부터 시작한다
enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
}

let size = Int(readLine()!)!
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var bamboo: [[Int]] = Array(
    repeating: Array(repeating: 0, count: size),
    count: size)
var memorization: [[Int]] = Array(
    repeating: Array(repeating: 0, count: size),
    count: size)
var res = 0

for y in 0..<size {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    for x in 0..<size {
        bamboo[y][x] = line[x]
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

func dfs(_ y: Int, _ x: Int) -> Int {
    if memorization[y][x] > 0 { return memorization[y][x] }

    memorization[y][x] = 1

    for dir in Direction.allCases {
        let ny = y + dy[dir.rawValue]
        let nx = x + dx[dir.rawValue]

        guard
            inRange(ny, nx),
            bamboo[y][x] < bamboo[ny][nx]
        else { continue }

        memorization[y][x] = max(memorization[y][x], dfs(ny, nx) + 1)
    }

    return memorization[y][x]
}

func solution() {
    for y in 0..<size {
        for x in 0..<size {
            res = max(res, dfs(y, x))
        }
    }

    print(res)
}

solution()